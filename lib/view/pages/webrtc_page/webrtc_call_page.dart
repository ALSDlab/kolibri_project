import 'dart:math';

import 'package:flutter/material.dart';
// Assuming flutter_joystick is in pubspec.yaml
// dependencies:
//   flutter_joystick: ^latest_version
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:provider/provider.dart'; // If using Provider to access ViewModel

import '../../../domain/model/control_signal_model.dart' as domain_cs;

class WebrtcCallPage extends StatefulWidget {
  const WebrtcCallPage({super.key});

  @override
  State<WebrtcCallPage> createState() => _WebrtcCallPageState();
}

class _WebrtcCallPageState extends State<WebrtcCallPage> {
  final ValueNotifier<bool> _showControlsNotifier = ValueNotifier<bool>(true);

  // For gesture handling if needed for advanced controls, not just basic signals
  // double _currentZoom = 1.0;
  // Offset _currentPan = Offset.zero;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<WebRTCViewModel>();
    viewModel.setCallViewContext(context); // For programmatic pop
    // Auto-hide controls after a few seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _showControlsNotifier.value = false;
    });
  }

  @override
  void dispose() {
    _showControlsNotifier.dispose();
    final viewModel = context.read<WebRTCViewModel>();
    viewModel.clearCallViewContext();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WebRTCViewModel>();
    // Using Consumer to react to ViewModel state changes
    return WillPopScope(
      onWillPop: () async {
        await viewModel
            .endCall(); // ViewModel's endCall will pop if context is set
        return false; // Let ViewModel handle pop, or return true if it doesn't.
        // Since endCall handles pop, returning false prevents double pop.
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Usually call screens are dark
        body: GestureDetector(
          onTap: () {
            _showControlsNotifier.value = !_showControlsNotifier.value;
          },
          onScaleUpdate: (details) {
            // For Zoom and Pan gestures
            if (details.scale != 1.0) {
              // Zoom
              viewModel.sendControlSignal(
                domain_cs.ControlSignalModel(
                  to: viewModel.state.remotePeerId ?? '',
                  type: domain_cs.ControlSignalType.zoom,
                  scale: details.scale,
                ),
              );
            } else if (details.focalPointDelta.distanceSquared > 0) {
              // Pan/Drag
              viewModel.sendControlSignal(
                domain_cs.ControlSignalModel(
                  to: viewModel.state.remotePeerId ?? '',
                  type: domain_cs.ControlSignalType.drag,
                  dx: details.focalPointDelta.dx,
                  dy: details.focalPointDelta.dy,
                ),
              );
            }
          },
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                // Remote Video (Full Screen)
                if (viewModel.state.remoteVideoVisible &&
                    viewModel.remoteRenderer.textureId != null)
                  Positioned.fill(
                    child: RTCVideoView(
                      viewModel.remoteRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      mirror: false,
                    ),
                  )
                else if (!viewModel
                    .state
                    .audioOnlyCall) // Show placeholder if video call & no remote video
                  Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Waiting for peer's video...",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),

                // If Audio only call, show an avatar or indicator
                if (viewModel.state.audioOnlyCall)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white54,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Audio Call with ${viewModel.state.remotePeerId ?? 'peer'}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Local Video (Small PiP)
                if (viewModel.state.localVideoEnabled &&
                    viewModel.localRenderer.textureId != null &&
                    !viewModel.state.audioOnlyCall)
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: SizedBox(
                      width: 100,
                      height: 150,
                      child: RTCVideoView(
                        viewModel.localRenderer,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        mirror: true,
                      ),
                    ),
                  )
                else if (!viewModel
                    .state
                    .audioOnlyCall) // Placeholder if local video is off
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Container(
                      width: 100,
                      height: 150,
                      color: Colors.black54,
                      child: const Center(
                        child: Icon(
                          Icons.videocam_off,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                // Joystick (bottom-left)
                ValueListenableBuilder<bool>(
                  valueListenable: _showControlsNotifier,
                  builder: (_, show, __) => show
                      ? Positioned(
                          bottom: 100.0, // Adjust based on other controls
                          left: 30.0,
                          child: Joystick(
                            mode: JoystickMode.all,
                            listener: (details) {
                              if ((details.x.abs() > 0.05 ||
                                      details.y.abs() > 0.05) &&
                                  viewModel.state.myId != null &&
                                  viewModel.state.remotePeerId != null) {
                                // Deadzone
                                viewModel.sendControlSignal(
                                  domain_cs.ControlSignalModel(
                                    to: viewModel.state.remotePeerId!,
                                    type: domain_cs.ControlSignalType.joystick,
                                    angle: atan2(
                                      details.y.abs(),
                                      details.x.abs(),
                                    ),
                                    // Radians
                                    intensity: sqrt(
                                      pow(details.x.abs(), 2) +
                                          pow(details.y.abs(), 2),
                                    ), // 0.0 to 1.0
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Call Control Buttons (Bottom Center)
                ValueListenableBuilder<bool>(
                  valueListenable: _showControlsNotifier,
                  builder: (_, show, __) => show
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                if (!viewModel
                                    .state
                                    .audioOnlyCall) // Show video toggle only for video calls
                                  FloatingActionButton(
                                    heroTag: "videoToggleBtnCallView",
                                    onPressed: viewModel.toggleLocalMedia,
                                    backgroundColor: Colors.white70,
                                    child: Icon(
                                      viewModel.state.localVideoEnabled
                                          ? Icons.videocam
                                          : Icons.videocam_off,
                                      color: Colors.black87,
                                    ),
                                  ),
                                FloatingActionButton(
                                  heroTag: "endCallBtnCallView",
                                  onPressed: () async {
                                    await viewModel.endCall();
                                    // Pop should be handled by endCall via context
                                  },
                                  backgroundColor: Colors.red,
                                  child: const Icon(
                                    Icons.call_end,
                                    color: Colors.white,
                                  ),
                                ),
                                FloatingActionButton(
                                  // Example: Mic mute
                                  heroTag: "micToggleBtnCallView",
                                  onPressed: () {
                                    // TODO: Implement mic mute/unmute in ViewModel & Repository
                                    // viewModel.toggleMicrophone();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Mic Toggle TBD"),
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.white70,
                                  child: const Icon(
                                    Icons.mic,
                                    color: Colors.black87,
                                  ), // Update based on mic state
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
