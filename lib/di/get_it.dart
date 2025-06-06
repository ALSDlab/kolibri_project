import 'package:get_it/get_it.dart';
import 'package:kolibri_project/data/data_source/remote/socket_data_source.dart';
import 'package:kolibri_project/data/repository/webrtc_repository_impl.dart';
import 'package:kolibri_project/domain/repository/webrtc_repository.dart';

import '../data/data_source/remote/webrtc_data_source.dart';
import '../domain/use_case/webrtc/media_peer_connection/add_ice_candidate_to_peer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/add_track_to_peer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_peer_connection_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_sdp_answer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/create_sdp_offer_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/dispose_peer_connection_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/dispose_renderers_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/get_local_user_media_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/initialize_renderers_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/listen_connection_state_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/listen_on_ice_candidate_generated_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/listen_on_track_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/set_local_description_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/set_remote_description_use_case.dart';
import '../domain/use_case/webrtc/media_peer_connection/turn_off_local_media_use_case.dart';
import '../domain/use_case/webrtc/signaling/connect_signaling_use_case.dart';
import '../domain/use_case/webrtc/signaling/disconnect_signaling_use_case.dart';
import '../domain/use_case/webrtc/signaling/get_user_list_stream_usecase.dart';
import '../domain/use_case/webrtc/signaling/listen_answer_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_control_signal_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_hang_up_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_ice_candidate_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_offer_use_case.dart';
import '../domain/use_case/webrtc/signaling/listen_refusal_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_answer_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_control_signal_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_hang_up_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_ice_candidate_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_offer_use_case.dart';
import '../domain/use_case/webrtc/signaling/send_refusal_use_case.dart';
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
  getIt.registerSingleton<WebrtcRepository>(
    WebRTCRepositoryImpl(getIt<SocketDataSource>(), getIt<WebRTCDataSource>()),
  );

  // UseCases - Signaling
  getIt
    ..registerSingleton<ConnectSignalingUseCase>(
      ConnectSignalingUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<DisconnectSignalingUseCase>(
      DisconnectSignalingUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<GetUserListStreamUseCase>(
      GetUserListStreamUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendOfferUseCase>(
      SendOfferUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenOfferUseCase>(
      ListenOfferUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendAnswerUseCase>(
      SendAnswerUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenAnswerUseCase>(
      ListenAnswerUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendIceCandidateUseCase>(
      SendIceCandidateUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenIceCandidateUseCase>(
      ListenIceCandidateUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendRefusalUseCase>(
      SendRefusalUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenRefusalUseCase>(
      ListenRefusalUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendHangUpUseCase>(
      SendHangUpUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenHangUpUseCase>(
      ListenHangUpUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SendControlSignalUseCase>(
      SendControlSignalUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenControlSignalUseCase>(
      ListenControlSignalUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    );

  // UseCases - Media & Peer Connection
  getIt
    ..registerSingleton<InitializeRenderersUseCase>(
      InitializeRenderersUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<GetLocalUserMediaUseCase>(
      GetLocalUserMediaUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<TurnOffLocalMediaUseCase>(
      TurnOffLocalMediaUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<CreatePeerConnectionUseCase>(
      CreatePeerConnectionUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<AddTrackToPeerUseCase>(
      AddTrackToPeerUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SetLocalDescriptionUseCase>(
      SetLocalDescriptionUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<SetRemoteDescriptionUseCase>(
      SetRemoteDescriptionUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<AddIceCandidateToPeerUseCase>(
      AddIceCandidateToPeerUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<DisposePeerConnectionUseCase>(
      DisposePeerConnectionUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<ListenOnTrackUseCase>(
      ListenOnTrackUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<ListenOnIceCandidateGeneratedUseCase>(
      ListenOnIceCandidateGeneratedUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<ListenConnectionStateUseCase>(
      ListenConnectionStateUseCase(
        chatDataRepository: getIt<WebrtcRepository>(),
      ),
    )
    ..registerSingleton<CreateSdpOfferUseCase>(
      CreateSdpOfferUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<CreateSdpAnswerUseCase>(
      CreateSdpAnswerUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    )
    ..registerSingleton<DisposeRenderersUseCase>(
      DisposeRenderersUseCase(chatDataRepository: getIt<WebrtcRepository>()),
    );

  // ViewModel
  getIt
    ..registerFactory<NavigationBarPageViewModel>(
      () => NavigationBarPageViewModel(),
    )
    ..registerFactory<WebRTCViewModel>(
      () => WebRTCViewModel(
        getIt<WebrtcRepository>(),
        connectSignalingUseCase: getIt<ConnectSignalingUseCase>(),
        disconnectSignalingUseCase: getIt<DisconnectSignalingUseCase>(),
        getUserListStreamUseCase: getIt<GetUserListStreamUseCase>(),
        sendOfferUseCase: getIt<SendOfferUseCase>(),
        listenOfferUseCase: getIt<ListenOfferUseCase>(),
        sendAnswerUseCase: getIt<SendAnswerUseCase>(),
        listenAnswerUseCase: getIt<ListenAnswerUseCase>(),
        sendIceCandidateUseCase: getIt<SendIceCandidateUseCase>(),
        listenIceCandidateUseCase: getIt<ListenIceCandidateUseCase>(),
        sendRefusalUseCase: getIt<SendRefusalUseCase>(),
        listenRefusalUseCase: getIt<ListenRefusalUseCase>(),
        sendHangUpUseCase: getIt<SendHangUpUseCase>(),
        listenHangUpUseCase: getIt<ListenHangUpUseCase>(),
        sendControlSignalUseCase: getIt<SendControlSignalUseCase>(),
        listenControlSignalUseCase: getIt<ListenControlSignalUseCase>(),
        initializeRenderersUseCase: getIt<InitializeRenderersUseCase>(),
        getLocalUserMediaUseCase: getIt<GetLocalUserMediaUseCase>(),
        turnOffLocalMediaUseCase: getIt<TurnOffLocalMediaUseCase>(),
        createPeerConnectionUseCase: getIt<CreatePeerConnectionUseCase>(),
        addTrackToPeerUseCase: getIt<AddTrackToPeerUseCase>(),
        setLocalDescriptionUseCase: getIt<SetLocalDescriptionUseCase>(),
        setRemoteDescriptionUseCase: getIt<SetRemoteDescriptionUseCase>(),
        addIceCandidateToPeerUseCase: getIt<AddIceCandidateToPeerUseCase>(),
        disposePeerConnectionUseCase: getIt<DisposePeerConnectionUseCase>(),
        listenOnTrackUseCase: getIt<ListenOnTrackUseCase>(),
        listenOnIceCandidateGeneratedUseCase:
            getIt<ListenOnIceCandidateGeneratedUseCase>(),
        listenConnectionStateUseCase: getIt<ListenConnectionStateUseCase>(),
        createSdpOfferUseCase: getIt<CreateSdpOfferUseCase>(),
        createSdpAnswerUseCase: getIt<CreateSdpAnswerUseCase>(),
        disposeRenderersUseCase: getIt<DisposeRenderersUseCase>(),
      ),
    );
}
