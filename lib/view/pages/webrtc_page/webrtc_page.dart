// webrtc_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_state.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:provider/provider.dart';

import 'joystick.dart';

class WebrtcPage extends StatefulWidget {
  const WebrtcPage({super.key});

  @override
  State<WebrtcPage> createState() => _WebrtcPageState();
}

class _WebrtcPageState extends State<WebrtcPage> with WidgetsBindingObserver {
  late WebrtcPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel = context.read<WebrtcPageViewModel>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 앱이 백그라운드로 갈 때 통화 중이면 종료
    if (state == AppLifecycleState.paused) {
      if (_viewModel.state.screenState == AppScreenState.inCall) {
        _viewModel.hangUp();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebrtcPageViewModel>(
      builder: (context, viewModel, child) {
        final state = viewModel.state;

        return Scaffold(
          appBar: AppBar(
            title: Text(_getAppBarTitle(state)),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildBodyForState(state, viewModel),
          ),
        );
      },
    );
  }

  String _getAppBarTitle(WebrtcPageState state) {
    switch (state.screenState) {
      case AppScreenState.initial:
        return '연결 중...';
      case AppScreenState.lobby:
        final myId = state.myId;
        return myId != null
            ? '로비 (내 ID: ${myId.length > 8 ? myId.substring(0, 8) : myId})'
            : '로비 (연결 중...)';
      case AppScreenState.calling: // [추가]
        final remotePeer = state.remotePeerId;
        return remotePeer != null
            ? '${remotePeer.substring(0, 8)}에게 전화 거는 중...'
            : '전화 거는 중...';
      case AppScreenState.connecting:
        return '연결 준비 중';
      case AppScreenState.incomingCall:
        return '전화 수신 중';
      case AppScreenState.inCall:
        final remotePeer = state.remotePeerId;
        return remotePeer != null
            ? '통화 중: ${remotePeer.length > 8 ? remotePeer.substring(0, 8) : remotePeer}'
            : '통화 중';
      case AppScreenState.error:
        return '오류 발생';
    }
  }

  Widget _buildBodyForState(
    WebrtcPageState state,
    WebrtcPageViewModel viewModel,
  ) {
    switch (state.screenState) {
      case AppScreenState.initial:
        return const Center(
          key: ValueKey('initial'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('서버에 연결 중입니다...'),
            ],
          ),
        );

      case AppScreenState.lobby:
        return _buildLobbyView(state, viewModel);

      case AppScreenState.calling: // [추가]
        return Center(
          key: const ValueKey('calling'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                "${state.remotePeerId?.substring(0, 8) ?? '상대방'}에게 연결 중...",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // [선택사항] 통화 취소 버튼
              ElevatedButton.icon(
                onPressed: () => viewModel.hangUp(),
                icon: const Icon(Icons.call_end),
                label: const Text('취소'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        );

      case AppScreenState.connecting:
        return const Center(
          key: ValueKey('connecting'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("연결 준비 중입니다...", style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                "잠시만 기다려주세요.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        );

      case AppScreenState.incomingCall:
        return _buildIncomingCallView(state, viewModel);

      case AppScreenState.inCall:
        return _buildInCallView(viewModel);

      case AppScreenState.error:
        return _buildErrorView(state, viewModel);
    }
  }

  Widget _buildInCallView(WebrtcPageViewModel viewModel) {
    return Scaffold(
      key: const ValueKey('inCallView'), // AnimatedSwitcher를 위한 키
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          // onScaleStart, onScaleUpdate 등 제스처 로직은 필요 시 여기에 추가
          child: Stack(
            children: [
              // 상대방 비디오
              Positioned.fill(
                child: Transform(
                  transform: viewModel.remoteTransform,
                  alignment: FractionalOffset.center,
                  child: RTCVideoView(
                    viewModel.remoteRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                  ),
                ),
              ),
              // 내 비디오
              // Positioned(
              //   top: 20,
              //   right: 20,
              //   child: SizedBox(
              //     width: 120,
              //     height: 160,
              //     child: RTCVideoView(viewModel.localRenderer, mirror: true),
              //   ),
              // ),
              // 조이스틱
              Positioned(
                bottom: 40,
                left: 40,
                child: Joystick(
                  onDrag: (details) {
                    final screenSize = MediaQuery.of(context).size;
                    final relativeDx =
                    (details.globalPosition.dx / screenSize.width)
                        .clamp(0.0, 1.0);
                    final relativeDy =
                    (details.globalPosition.dy / screenSize.height)
                        .clamp(0.0, 1.0);
                    viewModel.sendJoystickData(Offset(relativeDx, relativeDy));
                  },
                ),
              ),
              // 상대방 조이스틱 시그널
              if (viewModel.remoteJoystickPosition != null)
                Builder(
                  builder: (context) {
                    final screenSize = MediaQuery.of(context).size;
                    final position = Offset(
                      viewModel.remoteJoystickPosition!.dx * screenSize.width,
                      viewModel.remoteJoystickPosition!.dy * screenSize.height,
                    );
                    return Positioned(
                      left: position.dx - 20,
                      top: position.dy - 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await viewModel.hangUp();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end, color: Colors.white),
      ),
    );
  }

  Widget _buildLobbyView(WebrtcPageState state, WebrtcPageViewModel viewModel) {
    if (state.onlineUsers.isEmpty) {
      return const Center(
        key: ValueKey('lobby_empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '다른 사용자가 없습니다.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              '다른 사용자가 접속할 때까지 기다려주세요.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      key: const ValueKey('lobby_users'),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '온라인 사용자 (${state.onlineUsers.length}명)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '통화하고 싶은 사용자를 선택하세요.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.onlineUsers.length,
            itemBuilder: (context, index) {
              final peerId = state.onlineUsers[index];
              final displayId = peerId.length > 12
                  ? '${peerId.substring(0, 12)}...'
                  : peerId;

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      displayId.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    displayId,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('온라인'),
                  trailing: IconButton.filled(
                    icon: const Icon(Icons.video_call),
                    onPressed: () =>
                        _showCallConfirmation(context, peerId, viewModel),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIncomingCallView(
    WebrtcPageState state,
    WebrtcPageViewModel viewModel,
  ) {
    final callerId = state.incomingCallerId ?? '알 수 없음';
    final displayCallerId = callerId.length > 12
        ? '${callerId.substring(0, 12)}...'
        : callerId;

    return Center(
      key: const ValueKey('incoming_call'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone_in_talk, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text(
            '전화 수신',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            displayCallerId,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '님이 화상통화를 요청했습니다.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 거절 버튼
              Column(
                children: [
                  IconButton.filled(
                    onPressed: viewModel.refuseIncomingCall,
                    icon: const Icon(Icons.call_end),
                    iconSize: 32,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(64, 64),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('거절', style: TextStyle(fontSize: 14)),
                ],
              ),
              // 수락 버튼
              Column(
                children: [
                  IconButton.filled(
                    onPressed: viewModel.acceptIncomingCall,
                    icon: const Icon(Icons.video_call),
                    iconSize: 32,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(64, 64),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('수락', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(WebrtcPageState state, WebrtcPageViewModel viewModel) {
    return Center(
      key: const ValueKey('error'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '오류가 발생했습니다',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage ??
                  "알 수 없는 오류가 발생했습니다. 서버 상태를 확인하거나 앱을 다시 시작해주세요.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // ViewModel을 리셋하여 재연결 시도
                viewModel.init();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCallConfirmation(
    BuildContext context,
    String peerId,
    WebrtcPageViewModel viewModel,
  ) {
    final displayId = peerId.length > 12
        ? '${peerId.substring(0, 12)}...'
        : peerId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('화상통화 시작'),
        content: Text('$displayId님에게 화상통화를 요청하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.callUser(peerId);
            },
            child: const Text('통화'),
          ),
        ],
      ),
    );
  }
}
