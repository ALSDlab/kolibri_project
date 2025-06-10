import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_state.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:provider/provider.dart';

class WebrtcPage extends StatefulWidget {
  const WebrtcPage({super.key});

  @override
  State<WebrtcPage> createState() => _WebrtcPageState();
}

class _WebrtcPageState extends State<WebrtcPage> {
  @override
  void initState() {
    super.initState();

    // ViewModel 상태 변화를 감지하여 자동으로 화면 전환
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WebRTCViewModel>();
      viewModel.addListener(_onViewModelStateChanged);
    });
  }

  void _onViewModelStateChanged() {
    final viewModel = context.read<WebRTCViewModel>();
    final state = viewModel.state;

    // inCall 상태가 되면 자동으로 call 화면으로 이동
    if (state.screenState == AppScreenState.inCall &&
        ModalRoute.of(context)?.settings.name != '/webrtc_call_page') {
      debugPrint('[UI] Auto-navigating to call view due to state change');
      _navigateToCallView(context, viewModel);
    }
  }

  @override
  void dispose() {
    final viewModel = context.read<WebRTCViewModel>();
    viewModel.removeListener(_onViewModelStateChanged);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // Use Consumer for parts of the UI that need to rebuild when ViewModel notifies listeners
    final viewModel = context.watch<WebRTCViewModel>();
    final state = viewModel.state;
    Widget body;
    String appBarTitle = "WebRTC Demo";

    switch (state.screenState) {
      case AppScreenState.initial:
      case AppScreenState.loading:
        appBarTitle = "Connecting to Signaling Server...";
        body = const Center(child: CircularProgressIndicator());
        break;
      case AppScreenState.lobby:
        appBarTitle = "Lobby (${state.myId ?? 'N/A'})";
        body = Column(
          children: [
            if (state.errorMessage != null)
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.withOpacity(0.7),
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            Expanded(
              child: state.onlineUsers.isEmpty
                  ? const Center(
                      child: Text(
                        "No other users online. Open another instance to call.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.onlineUsers.length,
                      itemBuilder: (context, index) {
                        final user = state.onlineUsers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: ListTile(
                            title: Text(user.id),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onPressed: () async {
                                    await viewModel.callUser(
                                      user,
                                      audioOnly: true,
                                    );
                                  },
                                  tooltip: 'Audio Call',
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.video_call,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    await viewModel.callUser(
                                      user,
                                      audioOnly: false,
                                    );
                                  },
                                  tooltip: 'Video Call',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
        break;
      case AppScreenState.incomingCall:
        appBarTitle = "Incoming Call";
        body = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Incoming ${state.audioOnlyCall ? 'Audio' : 'Video'} Call from:",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                state.incomingOffer?.fromId ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "refuseCallBtn",
                    onPressed: () async {
                      await viewModel.refuseIncomingCall();
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                  FloatingActionButton(
                    heroTag: "acceptCallBtn",
                    onPressed: () async {
                      await viewModel.acceptIncomingCall();
                    },
                    backgroundColor: Colors.green,
                    child: Icon(
                      viewModel.state.audioOnlyCall
                          ? Icons.call
                          : Icons.videocam,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case AppScreenState.inCall:
        appBarTitle = "In Call with ${state.remotePeerId ?? 'N/A'}";
        body = const Center(child: Text("Call in progress..."));
        break;
      case AppScreenState.error:
        appBarTitle = "Error";
        body = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              Text(
                state.errorMessage ?? "An unknown error occurred.",
                style: const TextStyle(color: Colors.red, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  viewModel.init(); // Retry connection
                },
                child: const Text("Reconnect"),
              ),
            ],
          ),
        );
        break;
    }

    return PopScope(
      // Use PopScope instead of WillPopScope
      canPop: true, // Allow popping from lobby/error states
      onPopInvoked: (didPop) async {
        if (didPop && state.screenState == AppScreenState.inCall) {
          // If we are in call, prevent pop and handle it.
          // This should ideally not happen if navigation is handled correctly.
          await viewModel.hangUp(); // Force hang up if tried to pop during call
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: [
            if (state.screenState == AppScreenState.lobby)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => viewModel.init(),
              ),
          ],
        ),
        body: body,
      ),
    );
  }

  void _navigateToCallView(BuildContext context, WebRTCViewModel viewModel) {
    // Check if the current route is not already WebrtcCallPage
    // This prevents pushing the same route multiple times
    if (ModalRoute.of(context)?.settings.name != '/webrtc_call_page') {
      context.push('/webrtc_call_page', extra: viewModel).then((_) async {
        // This block executes when WebRTCCallView is popped.
        // ViewModel's endCall should have reset the state if call ended gracefully.
        // If somehow the state is still inCall, force it back to lobby/initial.
        if (viewModel.state.screenState == AppScreenState.inCall) {
          debugPrint(
            "[WebRTCMainView] Returned from CallView but state is still inCall. Forcing hangUp.",
          );
          await viewModel.hangUp(); // Assume it was a remote hangup or error
        }
      });
    }
  }
}
