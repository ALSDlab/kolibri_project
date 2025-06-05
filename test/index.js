const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: "*", // 개발 중에는 모든 출처를 허용합니다. 프로덕션에서는 특정 도메인으로 제한하세요.
    methods: ["GET", "POST"]
  }
});

let userList = [];

io.on('connection', (socket) => {
  console.log('User connected:', socket.id);

  // 유저 리스트에 추가
  if (!userList.includes(socket.id)) {
    userList.push(socket.id);
  }

  // 모든 클라이언트에게 업데이트된 유저 리스트 전송
  io.emit('updateUserlist', { userList });

  // Offer 처리 (클라이언트가 from, to 포함해서 전송)
  socket.on('offer', (data) => {
    // data should be CallOfferDto: { from: string, to: string, sdp: any }
    console.log('Offer from', data.fromId, 'to', data.toId);
    if (data.toId) {
      socket.to(data.toId).emit('offer', data);
    } else {
      console.warn('Offer event received without "to" field:', data);
    }
  });

  // Answer 처리 (클라이언트가 from, to 포함해서 전송)
  socket.on('answer', (data) => {
    // data should be CallAnswerDto: { from: string, to: string, sdp: any }
    console.log('Answer from', data.fromId, 'to', data.toId);
    if (data.toId) {
      socket.to(data.toId).emit('answer', data);
    } else {
      console.warn('Answer event received without "to" field:', data);
    }
  });

  // ICE Candidate 처리 (클라이언트가 from, to 포함해서 전송)
  socket.on('remoteIceCandidate', (data) => {
    // data should be IceCandidateDto: { from: string, to: string, candidate: any }
    console.log('ICE candidate from', data.from, 'to', data.to);
    if (data.to) {
      // 클라이언트 측 리스너 이름이 'remoteIceCandidate'이므로 이에 맞춤
      socket.to(data.to).emit('remoteIceCandidate', data);
    } else {
      console.warn('iceCandidate event received without "to" field:', data);
    }
  });

  // 통화 거절 처리
  socket.on('refuse', (data) => {
    // data from client should contain 'to' and optionally other info like 'reason'
    console.log('User', socket.id, 'is refusing call to/from', data.to); // data.to는 통화 상대방 ID
    if (data.to) {
      // 거절을 알리는 대상에게 'from'을 현재 사용자의 socket.id로 설정하여 전달
      socket.to(data.to).emit('refuse', { from: socket.id, reason: data.reason });
    } else {
      console.warn('Refuse event received without "to" field from user:', socket.id, data);
    }
  });

  // 연결 종료 처리 (상대방에게 알림)
  socket.on('disconnectPeer', (data) => {
    // data from client should contain 'to' (the peer to notify)
    console.log('User', socket.id, 'is disconnecting peer', data.to);
    if (data.to) {
      // 연결 종료를 알리는 대상에게 'from'을 현재 사용자의 socket.id로 설정하여 전달
      socket.to(data.to).emit('disconnectPeer', { from: socket.id });
    } else {
      console.warn('disconnectPeer event received without "to" field from user:', socket.id, data);
    }
  });

  // Control Signal 처리 (클라이언트가 from, to 포함해서 전송)
  socket.on('controlSignal', (data) => {
    // data should be ControlSignalDto: { from: string, to: string, signal: any }
    console.log('Control signal to', data.to, 'signal:', data.signal);
    if (data.to) {
      socket.to(data.to).emit('controlSignal', data);
    } else {
      console.warn('Control signal event received without "to" field:', data);
    }
  });

  // 유저 연결 해제
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
    userList = userList.filter(user => user !== socket.id);
    // 모든 클라이언트에게 업데이트된 유저 리스트 전송
    io.emit('updateUserlist', { userList });
    // (선택사항) 연결된 다른 피어들에게 이 사용자가 연결을 끊었다고 알릴 수 있습니다.
    // 이 경우, 해당 사용자와 연결된 모든 피어를 추적하는 로직이 필요합니다.
    // 예: io.emit('generalDisconnect', { userId: socket.id });
  });
});

const PORT = process.env.PORT || 2607;
// 서버가 0.0.0.0으로 리슨하면 모든 네트워크 인터페이스에서 접속 가능합니다.
// 클라이언트에서 접속 시에는 서버 PC의 실제 로컬 IP 주소를 사용해야 합니다.
server.listen(PORT,  '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
  console.log('Server accessible from other devices on the network using the machine\'s local IP address.');
});