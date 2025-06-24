// webrtc_server.js

const express = require('express');
const http = require('http');
const { Server } = require("socket.io");
const path = require('path');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

// 정적 파일 제공 (테스트용 HTML 파일을 위해)
app.use(express.static(path.join(__dirname, 'public')));

// 기본 라우트 - 서버 상태 확인용
app.get('/', (req, res) => {
    res.send(`
        <h1>WebRTC Signaling Server</h1>
        <p>Server is running on port ${PORT}</p>
        <p>Socket.IO connections: ${io.engine.clientsCount}</p>
        <p>Active rooms: ${rooms.size}</p>
        <script src="/socket.io/socket.io.js"></script>
        <script>
            const socket = io();
            socket.on('connect', () => {
                document.body.innerHTML += '<p style="color: green;">Socket.IO connected successfully!</p>';
            });
            socket.on('disconnect', () => {
                document.body.innerHTML += '<p style="color: red;">Socket.IO disconnected!</p>';
            });
        </script>
    `);
});

// 서버 상태 API
app.get('/status', (req, res) => {
    res.json({
        status: 'running',
        port: PORT,
        connections: io.engine.clientsCount,
        rooms: rooms.size,
        roomDetails: Array.from(rooms.entries()).map(([roomId, users]) => ({
            roomId,
            userCount: users.length,
            users: users.map(u => u.id)
        }))
    });
});

// 현재 접속 중인 모든 사용자를 관리하는 Map (roomId별로 관리)
const rooms = new Map();

// 사용자 목록을 특정 룸의 모든 클라이언트에게 브로드캐스트하는 함수
const updateUserListForRoom = (roomId) => {
    if (!rooms.has(roomId)) return;

    const roomUsers = rooms.get(roomId) || [];
    const userIds = roomUsers.map(user => user.id);
    io.to(roomId).emit('update-user-list', userIds);
    console.log(`Room ${roomId} users updated:`, userIds);
};

// 에러 핸들링 미들웨어
io.use((socket, next) => {
    console.log(`Authentication attempt for socket ${socket.id}`);
    next();
});

io.on('connection', (socket) => {
    console.log(`[${new Date().toISOString()}] User connected: ${socket.id}`);

    // 연결 확인 응답 (기존 이벤트 이름 유지)
    console.log(`Connection established for socket: ${socket.id}`);

    // 룸 참여 처리
    socket.on('join', (roomId) => {
        try {
            if (!roomId) {
                console.error(`Join failed: Room ID is required for ${socket.id}`);
                return;
            }

            socket.join(roomId);
            socket.currentRoom = roomId;

            // 룸에 사용자 추가
            if (!rooms.has(roomId)) {
                rooms.set(roomId, []);
            }
            const roomUsers = rooms.get(roomId);
            const existingUser = roomUsers.find(user => user.id === socket.id);
            if (!existingUser) {
                roomUsers.push({
                    id: socket.id,
                    socketId: socket.id,
                    joinedAt: new Date().toISOString()
                });
            }

            console.log(`[${new Date().toISOString()}] User ${socket.id} joined room ${roomId}`);

            // 기존 사용자들에게 새 사용자 참여 알림
            socket.to(roomId).emit('peer-joined', { peerId: socket.id });

            // 조인 성공 로그
            console.log(`Join successful: ${socket.id} joined room ${roomId} (${roomUsers.length} users total)`);

            // 해당 룸의 사용자 목록 업데이트 브로드캐스트
            updateUserListForRoom(roomId);
        } catch (error) {
            console.error(`Error joining room ${roomId}:`, error);
        }
    });

    // Offer 전송 (private 통신)
    socket.on('offer', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`Offer failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId, sdp } = data;
            console.log(`[${new Date().toISOString()}] Offer from ${socket.id} to ${targetPeerId}`);

            // 특정 사용자에게만 offer 전송
            io.to(targetPeerId).emit('private-offer', {
                sdp: sdp,
                from: socket.id
            });
        } catch (error) {
            console.error('Error handling offer:', error);
        }
    });

    // Answer 전송 (private 통신)
    socket.on('answer', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`Answer failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId, sdp } = data;
            console.log(`[${new Date().toISOString()}] Answer from ${socket.id} to ${targetPeerId}`);

            // 특정 사용자에게만 answer 전송
            io.to(targetPeerId).emit('private-answer', {
                sdp: sdp,
                from: socket.id
            });
        } catch (error) {
            console.error('Error handling answer:', error);
        }
    });

    // ICE Candidate 전송
    socket.on('ice-candidate', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`ICE candidate failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId, candidate } = data;
            console.log(`[${new Date().toISOString()}] ICE candidate from ${socket.id} to ${targetPeerId}`);

            // 특정 사용자에게만 ICE candidate 전송
            io.to(targetPeerId).emit('private-ice-candidate', {
                candidate: candidate,
                from: socket.id
            });
        } catch (error) {
            console.error('Error handling ICE candidate:', error);
        }
    });

    // 제스처 및 조이스틱 신호 전송
    socket.on('signal', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`Signal failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId, signalData } = data;
            console.log(`[${new Date().toISOString()}] Signal from ${socket.id} to ${targetPeerId}:`, signalData?.type || 'unknown');

            // 특정 사용자에게만 신호 전송
            io.to(targetPeerId).emit('signal', {
                signalData: signalData,
                from: socket.id
            });
        } catch (error) {
            console.error('Error handling signal:', error);
        }
    });

    // hang-up 이벤트
    socket.on('hang-up', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`Hang-up failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId } = data;
            console.log(`[${new Date().toISOString()}] Hang up from ${socket.id} to ${targetPeerId}`);

            io.to(targetPeerId).emit('hang-up', { from: socket.id });
        } catch (error) {
            console.error('Error handling hang-up:', error);
        }
    });

    // 통화 거절 신호 처리
    socket.on('call-refusal', (data) => {
        try {
            if (!data || !data.targetPeerId) {
                console.error(`Call refusal failed: Target peer ID is required for ${socket.id}`);
                return;
            }
            const { targetPeerId, roomId } = data;
            console.log(`[${new Date().toISOString()}] Call refusal from ${socket.id} to ${targetPeerId} in room ${roomId}`);

            socket.to(targetPeerId).emit('call-refused', {
                from: socket.id,
                roomId: roomId
            });
        } catch (error) {
            console.error('Error handling call refusal:', error);
        }
    });

    // 연결 종료 시 처리
    socket.on('disconnect', (reason) => {
        console.log(`[${new Date().toISOString()}] User disconnected: ${socket.id}, reason: ${reason}`);

        try {
            // 사용자가 속한 모든 룸에서 제거
            const currentRoom = socket.currentRoom;
            if (currentRoom && rooms.has(currentRoom)) {
                const roomUsers = rooms.get(currentRoom);
                const updatedUsers = roomUsers.filter(user => user.id !== socket.id);

                if (updatedUsers.length === 0) {
                    rooms.delete(currentRoom);
                    console.log(`Room ${currentRoom} deleted (empty)`);
                } else {
                    rooms.set(currentRoom, updatedUsers);
                }

                // 해당 룸의 사용자 목록 업데이트
                updateUserListForRoom(currentRoom);

                // 룸의 다른 사용자들에게 연결 해제 알림
                socket.to(currentRoom).emit('peer-disconnected', { peerId: socket.id });
            }
        } catch (error) {
            console.error('Error handling disconnect:', error);
        }
    });

    // 에러 핸들링
    socket.on('error', (error) => {
        console.error(`Socket error for ${socket.id}:`, error);
    });
});

// 서버 에러 핸들링
server.on('error', (error) => {
    if (error.code === 'EADDRINUSE') {
        console.error(`Port ${PORT} is already in use. Please use a different port.`);
        process.exit(1);
    } else {
        console.error('Server error:', error);
    }
});

// Graceful shutdown
process.on('SIGTERM', () => {
    console.log('SIGTERM received, shutting down gracefully');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('SIGINT received, shutting down gracefully');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});

const PORT = process.env.PORT || 2607;
server.listen(PORT, '0.0.0.0', () => {
    console.log(`=== WebRTC Signaling Server ===`);
    console.log(`Server is running on port ${PORT}`);
    console.log(`Local access: http://localhost:${PORT}`);
    console.log(`Network access: http://0.0.0.0:${PORT}`);
    console.log(`Status API: http://localhost:${PORT}/status`);
    console.log(`================================`);
});