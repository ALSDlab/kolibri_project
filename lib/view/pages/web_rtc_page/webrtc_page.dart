import 'package:flutter/material.dart';
import 'package:kolibri_project/view/pages/web_rtc_page/webrtc_call_page.dart';
import 'package:kolibri_project/view/pages/web_rtc_page/webrtc_page_state.dart';
import 'package:kolibri_project/view/pages/web_rtc_page/webrtc_page_view_model.dart';

import 'package:provider/provider.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart'; // For RTCVideoView

class WebrtcPage extends StatefulWidget {
  const WebrtcPage({Key? key}) : super(key: key);

  @override
  State<WebrtcPage> createState() => _WebrtcPageState();
}

class _WebrtcPageState extends State<WebrtcPage> {
  late WebRTCViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access viewModel here if it's the first time or if dependencies change
    // For simplicity, assuming it's already provided by Provider correctly
    _viewModel = Provider.of<WebRTCViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer for parts of the UI that need to rebuild when ViewModel notifies listeners
    return Consumer<WebRTCViewModel>(
      builder: (context, viewModel, child) {
        final screenState = viewModel.state.screenState;
        final myId = viewModel.state.myId;
        final selectedUser = viewModel.state.selectedUserForCall;

        Widget body;
        String appBarTitle = "WebRTC Demo";
        bool showFab = false;

        switch (screenState) {
          case AppScreenState.initial:
          case AppScreenState.loading:
            body = const Center(child: CircularProgressIndicator());
            appBarTitle = "Connecting...";
            break;
          case AppScreenState.lobby:
            body = _buildLobby(viewModel);
            appBarTitle = "Online Users (My ID: ${myId ?? 'N/A'})";
            showFab = selectedUser != null;
            break;
          case AppScreenState.incomingCall:
            body = _buildIncomingCallScreen(viewModel, context);
            appBarTitle = "Incoming Call"; // Title managed within the screen
            break;
          case AppScreenState.inCall:
          // This case should ideally not be directly built here.
          // Navigation to CallView happens when state transitions to inCall.
          // If we somehow land here, it's likely a state issue or post-navigation.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (ModalRoute.of(context)?.isCurrent ?? false) {
                _navigateToCallView(context, viewModel);
              }
            });
            body = const Center(child: Text("Navigating to call..."));
            break;
          case AppScreenState.error:
            body = Center(child: Text("Error: ${viewModel.state.errorMessage ?? 'Unknown error'}"));
            appBarTitle = "Error";
            break;
        }

        // Show error messages if any, regardless of screen state (optional)
        if (viewModel.state.errorMessage != null && screenState != AppScreenState.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) { // Ensure widget is still in the tree
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(viewModel.state.errorMessage!), duration: const Duration(seconds: 3))
              );
              // Consider clearing the error message in viewModel after showing it
              // viewModel.clearErrorMessage();
            }
          });
        }


        return Scaffold(
          appBar: (screenState == AppScreenState.lobby || screenState == AppScreenState.error || screenState == AppScreenState.loading)
              ? AppBar(title: Text(appBarTitle))
              : null, // No AppBar for incoming call or during call setup
          body: body,
          floatingActionButton: showFab && screenState == AppScreenState.lobby
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.small(
                heroTag: 'videoCallBtn',
                onPressed: () async {
                  await viewModel.initiateCall(audioOnly: false);
                  // Navigation is handled by state change or can be explicit
                  if (viewModel.state.screenState == AppScreenState.inCall) {
                    _navigateToCallView(context, viewModel);
                  }
                },
                tooltip: "Video Call",
                child: const Icon(Icons.videocam),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: 'audioCallBtn',
                onPressed: () async {
                  await viewModel.initiateCall(audioOnly: true);
                  if (viewModel.state.screenState == AppScreenState.inCall) {
                    _navigateToCallView(context, viewModel);
                  }
                },
                tooltip: "Audio Call",
                child: const Icon(Icons.call),
              ),
            ],
          )
              : null,
        );
      },
    );
  }

  Widget _buildLobby(WebRTCViewModel viewModel) {
    final users = viewModel.state.onlineUsers;
    final selectedUser = viewModel.state.selectedUserForCall;

    if (users.isEmpty) {
      return const Center(child: Text("No other users online."));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
            title: Text(user.id),
            // subtitle: Text(user.name ?? 'Unknown Name'), // If you add name to PeerUserModel
            selected: selectedUser?.id == user.id,
            selectedTileColor: Colors.blue.withOpacity(0.2),
            onTap: () {
              viewModel.selectUserForCall(user);
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.videocam, color: selectedUser?.id == user.id ? Theme.of(context).colorScheme.primary : Colors.grey),
                  tooltip: "Video call ${user.id}",
                  onPressed: () async {
                    viewModel.selectUserForCall(user); // Ensure user is selected
                    await viewModel.initiateCall(audioOnly: false);
                    if (viewModel.state.screenState == AppScreenState.inCall) {
                      // ignore: use_build_context_synchronously
                      _navigateToCallView(context, viewModel);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call, color: selectedUser?.id == user.id ? Theme.of(context).colorScheme.secondary : Colors.grey),
                  tooltip: "Audio call ${user.id}",
                  onPressed: () async {
                    viewModel.selectUserForCall(user); // Ensure user is selected
                    await viewModel.initiateCall(audioOnly: true);
                    if (viewModel.state.screenState == AppScreenState.inCall) {
                      // ignore: use_build_context_synchronously
                      _navigateToCallView(context, viewModel);
                    }
                  },
                ),
              ],
            )
        );
      },
    );
  }

  Widget _buildIncomingCallScreen(WebRTCViewModel viewModel, BuildContext context) {
    final incomingOffer = viewModel.state.incomingOffer;
    if (incomingOffer == null) {
      // This should not happen if screenState is incomingCall
      return const Center(child: Text("Error: No incoming call data."));
    }
    return Center(
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        margin: const EdgeInsets.all(24.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Incoming ${viewModel.state.audioOnlyCall ? "Audio" : "Video"} Call from',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(incomingOffer.fromId,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              // Optionally show a small preview of local camera if on
              if (viewModel.state.localVideoEnabled && viewModel.localRenderer.textureId != null && !viewModel.state.audioOnlyCall)
                SizedBox(
                  height: 100, width: 75,
                  child: RTCVideoView(viewModel.localRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover, mirror: true),
                )
              else if (!viewModel.state.audioOnlyCall)
                const Icon(Icons.videocam_off, size: 50, color: Colors.grey)
              else
                const Icon(Icons.call_received, size: 50, color: Colors.blue),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'rejectCallBtnMain',
                    onPressed: viewModel.rejectCall,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                  FloatingActionButton(
                    heroTag: 'answerCallBtnMain',
                    onPressed: () async {
                      await viewModel.answerCall();
                      if (viewModel.state.screenState == AppScreenState.inCall) {
                        // ignore: use_build_context_synchronously
                        _navigateToCallView(context, viewModel);
                      }
                    },
                    backgroundColor: Colors.green,
                    child: Icon(viewModel.state.audioOnlyCall ? Icons.call : Icons.videocam, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCallView(BuildContext context, WebRTCViewModel viewModel) {
    if (ModalRoute.of(context)?.isCurrent ?? false) { // Ensure current view is active
      Navigator.push(
        context,
        MaterialPageRoute(
          // Pass the existing ViewModel instance
          builder: (_) => WebrtcCallPage(viewModel: viewModel),
        ),
      ).then((_) {
        // This block executes when WebRTCCallView is popped.
        // ViewModel's endCall should have reset the state.
        // If somehow the state is still inCall, force it back to lobby.
        if (viewModel.state.screenState == AppScreenState.inCall) {
          debugPrint("[WebRTCMainView] Returned from CallView but state is still inCall. Forcing endCall.");
          viewModel.endCall(isRemoteHangup: true); // Assume it was a remote hangup or error
        }
      });
    }
  }
}