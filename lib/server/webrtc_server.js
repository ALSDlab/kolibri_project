// webrtc_server.js

const express = require('express');
const http = require('http');
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// 현재 접속 중인 모든 사용자를 관리하는 Map (roomId별로 관리)
const rooms = new Map();

// 사용자 목록을 특정 룸의 모든 클라이언트에게 브로드캐스트하는 함수
const updateUserListForRoom = (roomId) => {
    const roomUsers = rooms.get(roomId) || [];
    const userIds = roomUsers.map(user => user.id);
    io.to(roomId).emit('update-user-list', userIds);
    console.log(`Room ${roomId} users updated:`, userIds);
};

io.on('connection', (socket) => {
    console.log(`User connected: ${socket.id}`);

    // 룸 참여 처리
    socket.on('join', (roomId) => {
        socket.join(roomId);
        socket.currentRoom = roomId;

        // 룸에 사용자 추가
        if (!rooms.has(roomId)) {
            rooms.set(roomId, []);
        }
        const roomUsers = rooms.get(roomId);
        const existingUser = roomUsers.find(user => user.id === socket.id);
        if (!existingUser) {
            roomUsers.push({ id: socket.id, socketId: socket.id });
        }

        console.log(`User ${socket.id} joined room ${roomId}`);

        // 기존 사용자들에게 새 사용자 참여 알림
        socket.to(roomId).emit('peer-joined', { peerId: socket.id });

        // 해당 룸의 사용자 목록 업데이트 브로드캐스트
        updateUserListForRoom(roomId);
    });

    // Offer 전송 (private 통신) - 수정됨
    socket.on('offer', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId, sdp } = data; // targetPeerId를 받도록 수정
        console.log(`Offer from ${socket.id} to ${targetPeerId}`);

        if (targetPeerId) {
            // 특정 사용자에게만 offer 전송
            io.to(targetPeerId).emit('private-offer', {
                sdp: sdp,
                from: socket.id
            });
        }
    });

    // Answer 전송 (private 통신) - 수정됨
    socket.on('answer', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId, sdp } = data; // targetPeerId를 받도록 수정
        console.log(`Answer from ${socket.id} to ${targetPeerId}`);

        if (targetPeerId) {
            // 특정 사용자에게만 answer 전송
            io.to(targetPeerId).emit('private-answer', {
                sdp: sdp,
                from: socket.id
            });
        }
    });

    // ICE Candidate 전송 - 수정됨
    socket.on('ice-candidate', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId, candidate } = data; // targetPeerId를 받도록 수정
        console.log(`ICE candidate from ${socket.id} to ${targetPeerId}`);

        if (targetPeerId) {
            // 특정 사용자에게만 ICE candidate 전송
            io.to(targetPeerId).emit('private-ice-candidate', {
                candidate: candidate,
                from: socket.id
            });
        }
    });

    // 제스처 및 조이스틱 신호 전송 - 수정됨
    socket.on('signal', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId, signalData } = data; // targetPeerId를 받도록 수정
        // console.log(`Signal from ${socket.id} to ${targetPeerId}:`, signalData.type);

        if (targetPeerId) {
            // 특정 사용자에게만 신호 전송
            io.to(targetPeerId).emit('signal', {
                signalData: signalData,
                from: socket.id
            });
        }
    });

    // hang-up 이벤트가 특정 사용자에게 전달되도록 수정
    socket.on('hang-up', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId } = data;
        console.log(`Hang up from ${socket.id} to ${targetPeerId}`);
        if (targetPeerId) {
            io.to(targetPeerId).emit('hang-up', { from: socket.id });
        }
    });

    // 통화 거절 신호 처리 (새로 추가)
    socket.on('call-refusal', (data) => {
        if (!data || !data.targetPeerId) return;
        const { targetPeerId, roomId } = data;
        console.log(`Call refusal from ${socket.id} to ${targetPeerId} in room ${roomId}`);

        if (targetPeerId) {
            socket.to(targetPeerId).emit('call-refused', {
                from: socket.id,
                roomId: roomId
            });
        }
    });

    // 연결 종료 시 처리
    socket.on('disconnect', () => {
        console.log(`User disconnected: ${socket.id}`);

        // 사용자가 속한 모든 룸에서 제거
        const currentRoom = socket.currentRoom;
        if (currentRoom && rooms.has(currentRoom)) {
            const roomUsers = rooms.get(currentRoom);
            const updatedUsers = roomUsers.filter(user => user.id !== socket.id);

            if (updatedUsers.length === 0) {
                rooms.delete(currentRoom);
            } else {
                rooms.set(currentRoom, updatedUsers);
            }

            // 해당 룸의 사용자 목록 업데이트
            updateUserListForRoom(currentRoom);

            // 룸의 다른 사용자들에게 연결 해제 알림
            socket.to(currentRoom).emit('peer-disconnected', { peerId: socket.id });
        }
    });
});

const PORT = process.env.PORT || 2607;
server.listen(PORT, '0.0.0.0', () => {
    console.log(`Signaling server is running on port ${PORT}`);
});