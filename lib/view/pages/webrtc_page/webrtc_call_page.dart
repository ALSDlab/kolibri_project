import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/control_signal_model.dart' as domain_cs;
import 'webrtc_page_state.dart'; // Import AppScreenState

class WebrtcCallPage extends StatefulWidget {
  const WebrtcCallPage({super.key});

  @override
  State<WebrtcCallPage> createState() => _WebrtcCallPageState();
}

class _WebrtcCallPageState extends State<WebrtcCallPage> {
  final ValueNotifier<bool> _showControlsNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<WebRTCViewModel>();
    viewModel.setCallViewContext(context);

    // Auto-hide controls after a few seconds if not interacted with
    _startHideControlsTimer();
  }

  void _startHideControlsTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      if (_showControlsNotifier.value) {
        _showControlsNotifier.value = false;
      }
    });
  }

  @override
  void dispose() {
    _showControlsNotifier.dispose();
    final viewModel = context.read<WebRTCViewModel>();
    viewModel.clearCallViewContext(); // Clear context when view is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WebRTCViewModel>();
    final state = viewModel.state;
    final isCallActive =
        state.screenState == AppScreenState.inCall ||
        state.screenState == AppScreenState.loading;

    // Ensure we are in a call state before rendering call-specific UI
    if (!isCallActive) {
      // If we are not in call state, return a placeholder or navigate back.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
      return const Scaffold(
        body: Center(child: Text("Not in a call. Redirecting...")),
      );
    }

    return PopScope(
      // Use PopScope instead of WillPopScope for newer Flutter versions
      canPop: false, // Prevent accidental back navigation
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        // Show confirmation dialog before hanging up or just hang up directly
        await viewModel.hangUp();
        // Allow pop after hanging up
        if (context.mounted) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              _showControlsNotifier.value = !_showControlsNotifier.value;
              _startHideControlsTimer(); // Reset timer on interaction
            },
            child: Stack(
              children: [
                // Remote video (full screen)
                Positioned.fill(child: _buildRemoteVideoView(viewModel, state)),
                // Local video (small preview)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildLocalVideoView(viewModel, state),
                  ),
                ),
                _buildControlSignalOverlay(viewModel),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _showControlsNotifier,
                    builder: (context, showControls, child) {
                      return showControls
                          ? Joystick(
                              mode: JoystickMode.all,
                              listener: (details) {
                                // Deadzone check for joystick input
                                if ((details.x.abs() > 0.05 ||
                                        details.y.abs() > 0.05) &&
                                    state.myId != null &&
                                    state.remotePeerId != null) {
                                  viewModel.sendControlSignal(
                                    domain_cs.ControlSignalModel(
                                      to: state.remotePeerId!,
                                      type:
                                          domain_cs.ControlSignalType.joystick,
                                      // You might use a specific type for joystick
                                      dx: details.x,
                                      dy: details.y,
                                    ),
                                  );
                                }
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                // Overlay controls (buttons)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "hangUpBtnCallView",
                        onPressed: () async {
                          await viewModel.hangUp();
                        },
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.call_end, color: Colors.white),
                      ),
                      FloatingActionButton(
                        heroTag: "micToggleBtnCallView",
                        onPressed: () async {
                          await viewModel.toggleMicrophone();
                        },
                        backgroundColor: Colors.white70,
                        child: Icon(
                          viewModel.localStream
                                      ?.getAudioTracks()
                                      .firstOrNull
                                      ?.enabled ==
                                  true
                              ? Icons.mic
                              : Icons.mic_off,
                          color: Colors.black87,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "camToggleBtnCallView",
                        onPressed: () async {
                          await viewModel.toggleCamera();
                        },
                        backgroundColor: Colors.white70,
                        child: Icon(
                          viewModel.localStream
                                      ?.getVideoTracks()
                                      .firstOrNull
                                      ?.enabled ==
                                  true
                              ? Icons.videocam
                              : Icons.videocam_off,
                          color: Colors.black87,
                        ),
                      ),
                      // Add more controls as needed (e.g., switch camera)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRemoteVideoView(
    WebRTCViewModel viewModel,
    WebrtcPageState state,
  ) {
    final hasRemoteVideo =
        viewModel.remoteRenderer.srcObject != null && state.remoteVideoVisible;

    debugPrint(
      '[UI] Remote video - srcObject: ${viewModel.remoteRenderer.srcObject != null}, visible: ${state.remoteVideoVisible}',
    );

    if (hasRemoteVideo) {
      return Container(
        color: Colors.black,
        child: RTCVideoView(
          viewModel.remoteRenderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          mirror: false, // 원격 비디오는 미러링하지 않음
          filterQuality: FilterQuality.medium,
        ),
      );
    } else {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                state.audioOnlyCall ? Icons.mic : Icons.person_off,
                color: Colors.blue,
                size: 100,
              ),
              const SizedBox(height: 16),
              Text(
                state.audioOnlyCall
                    ? 'Audio Only Call'
                    : 'Waiting for video...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // 로컬 비디오 뷰 개선
  Widget _buildLocalVideoView(
    WebRTCViewModel viewModel,
    WebrtcPageState state,
  ) {
    final hasLocalVideo =
        viewModel.localRenderer.srcObject != null && state.localVideoEnabled;

    return Container(
      width: 90,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: hasLocalVideo
            ? RTCVideoView(
                viewModel.localRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                mirror: true, // 로컬 비디오는 미러링
                filterQuality: FilterQuality.medium,
              )
            : Center(
                child: Icon(
                  state.audioOnlyCall ? Icons.mic : Icons.videocam_off,
                  color: Colors.white,
                  size: 40,
                ),
              ),
      ),
    );
  }

  Widget _buildControlSignalOverlay(WebRTCViewModel viewModel) {
    final signal = viewModel.state.lastReceivedControlSignal;
    if (signal == null) {
      return const SizedBox.shrink(); // 신호가 없으면 아무것도 표시하지 않음
    }

    String signalText = 'Received Signal:\n';
    signalText += 'Type: ${signal.type.toString().split('.').last}\n';
    if (signal.dx != null) {
      signalText += 'dx: ${signal.dx?.toStringAsFixed(2)}\n';
    }
    if (signal.dy != null) {
      signalText += 'dy: ${signal.dy?.toStringAsFixed(2)}\n';
    }
    if (signal.scale != null) {
      signalText += 'scale: ${signal.scale?.toStringAsFixed(2)}\n';
    }
    if (signal.angle != null) {
      signalText += 'angle: ${signal.angle?.toStringAsFixed(2)}\n';
    }
    if (signal.intensity != null) {
      signalText += 'intensity: ${signal.intensity?.toStringAsFixed(2)}';
    }

    return Positioned(
      top: 20.0,
      left: 20.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          signalText,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
