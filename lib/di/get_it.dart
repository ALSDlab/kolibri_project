import 'package:get_it/get_it.dart';
import 'package:kolibri_project/data/data_source/remote/socket_data_source.dart';
import 'package:kolibri_project/data/repository/webrtc_repository_impl.dart';
import 'package:kolibri_project/domain/repository/webrtc_repository.dart';
import 'package:kolibri_project/domain/use_case/webrtc/signaling/close_peer_connection_use_case.dart';
import 'package:kolibri_project/domain/use_case/webrtc/signaling/listen_for_hang_up_use_case.dart';

import '../data/data_source/remote/webrtc_data_source.dart';
import '../domain/use_case/webrtc/media_peer_connection/add_ice_candidate_to_peer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/add_track_to_peer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_peer_connection_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_sdp_answer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_sdp_offer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/set_local_description_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/set_remote_description_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/turn_off_media_stream_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/turn_on_local_media_stream_use_case.dart';
import '../domain/use_case/webrtc/signaling/accept_incoming_call_use_case.dart';
import '../domain/use_case/webrtc/signaling/call_peer_use_case.dart';
import '../domain/use_case/webrtc/signaling/connect_signaling_use_case.dart';
import '../domain/use_case/webrtc/signaling/decline_incoming_call_use_case.dart';
import '../domain/use_case/webrtc/signaling/disconnect_signaling_use_case.dart';
import '../domain/use_case/webrtc/signaling/hang_up_call_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_call_answer_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_call_offers_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_control_signal_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_ice_candidates_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_refused_call_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_for_user_list_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_control_signal_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_ice_candidate_use_case.dart';
import '../view/navigation/navigation_bar_page_view_model.dart';
import '../view/pages/webrtc_page/webrtc_page_view_model.dart';

// import '../view/navigation/navigation_bar_page_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // DataSources
  getIt
    ..registerSingleton<SocketDataSource>(SocketDataSource())
    ..registerSingleton<WebRTCDataSource>(WebRTCDataSource());

  // Repository
  getIt.registerSingleton<WebRTCRepository>(
    WebRTCRepositoryImpl(getIt<SocketDataSource>(), getIt<WebRTCDataSource>()),
  );

  // UseCases - Signaling
  getIt
    ..registerSingleton<AcceptIncomingCallUseCase>(
      AcceptIncomingCallUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<CallPeerUseCase>(
      CallPeerUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ClosePeerConnectionUseCase>(
      ClosePeerConnectionUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ConnectSignalingUseCase>(
      ConnectSignalingUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<DeclineIncomingCallUseCase>(
      DeclineIncomingCallUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<DisconnectSignalingUseCase>(
      DisconnectSignalingUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<HangUpCallUseCase>(
      HangUpCallUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForCallAnswerUseCase>(
      ListenForCallAnswerUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForCallOffersUseCase>(
      ListenForCallOffersUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForControlSignalUseCase>(
      ListenForControlSignalUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForHangUpUseCase>(
      ListenForHangUpUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForIceCandidatesUseCase>(
      ListenForIceCandidatesUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForRefusedCallUseCase>(
      ListenForRefusedCallUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<ListenForUserListUseCase>(
      ListenForUserListUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<SendControlSignalUseCase>(
      SendControlSignalUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<SendIceCandidateUseCase>(
      SendIceCandidateUseCase(getIt<WebRTCRepository>()),
    );

  // UseCases - Media & Peer Connection
  getIt
    ..registerSingleton<AddIceCandidateToPeerUseCase>(
      AddIceCandidateToPeerUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<AddTrackToPeerUseCase>(
      AddTrackToPeerUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<CreatePeerConnectionUseCase>(
      CreatePeerConnectionUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<CreateSdpAnswerUseCase>(
      CreateSdpAnswerUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<CreateSdpOfferUseCase>(
      CreateSdpOfferUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<SetLocalDescriptionUseCase>(
      SetLocalDescriptionUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<SetRemoteDescriptionUseCase>(
      SetRemoteDescriptionUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<TurnOffMediaStreamUseCase>(
      TurnOffMediaStreamUseCase(getIt<WebRTCRepository>()),
    )
    ..registerSingleton<TurnOnLocalMediaStreamUseCase>(
      TurnOnLocalMediaStreamUseCase(getIt<WebRTCRepository>()),
    );
  // ViewModel
  getIt
    ..registerFactory<NavigationBarPageViewModel>(
      () => NavigationBarPageViewModel(),
    )
    ..registerFactory<WebRTCViewModel>(
      () => WebRTCViewModel(
        webRTCRepository: getIt<WebRTCRepository>(),
        callPeerUseCase: getIt<CallPeerUseCase>(),
        listenForUserListUseCase: getIt<ListenForUserListUseCase>(),
        listenForCallOffersUseCase: getIt<ListenForCallOffersUseCase>(),
        acceptIncomingCallUseCase: getIt<AcceptIncomingCallUseCase>(),
        declineIncomingCallUseCase: getIt<DeclineIncomingCallUseCase>(),
        hangUpCallUseCase: getIt<HangUpCallUseCase>(),
        createPeerConnectionUseCase: getIt<CreatePeerConnectionUseCase>(),
        turnOnLocalMediaStreamUseCase: getIt<TurnOnLocalMediaStreamUseCase>(),
        turnOffMediaStreamUseCase: getIt<TurnOffMediaStreamUseCase>(),
        createSdpOfferUseCase: getIt<CreateSdpOfferUseCase>(),
        setLocalDescriptionUseCase: getIt<SetLocalDescriptionUseCase>(),
        listenForCallAnswerUseCase: getIt<ListenForCallAnswerUseCase>(),
        setRemoteDescriptionUseCase: getIt<SetRemoteDescriptionUseCase>(),
        addTrackToPeerUseCase: getIt<AddTrackToPeerUseCase>(),
        listenForIceCandidatesUseCase: getIt<ListenForIceCandidatesUseCase>(),
        sendIceCandidateUseCase: getIt<SendIceCandidateUseCase>(),
        addIceCandidateToPeerUseCase: getIt<AddIceCandidateToPeerUseCase>(),
        createSdpAnswerUseCase: getIt<CreateSdpAnswerUseCase>(),
        listenForRefusedCallUseCase: getIt<ListenForRefusedCallUseCase>(),
        listenForControlSignalUseCase: getIt<ListenForControlSignalUseCase>(),
        sendControlSignalUseCase: getIt<SendControlSignalUseCase>(),
        disconnectSignalingUseCase: getIt<DisconnectSignalingUseCase>(),
        connectSignalingUseCase: getIt<ConnectSignalingUseCase>(),
        listenForHangUpUseCase: getIt<ListenForHangUpUseCase>(),
        closePeerConnectionUseCase: getIt<ClosePeerConnectionUseCase>(),
      ),
    );
}
