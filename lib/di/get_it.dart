import 'package:get_it/get_it.dart';
import 'package:kolibri_project/data/data_source/video_call_data_source.dart';
import 'package:kolibri_project/data/repository/video_call_repository_impl.dart';
import 'package:kolibri_project/domain/repository/video_call_repository.dart';
import 'package:kolibri_project/domain/use_case/connect_use_case.dart';
import 'package:kolibri_project/env/env.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../view/navigation/navigation_bar_page_view_model.dart';

// import '../view/navigation/navigation_bar_page_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<io.Socket>(
    io.io(Env.kolibriServerAddress, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    }),
  );

  // DataSources
  getIt.registerSingleton<VideoCallDataSource>(
    VideoCallDataSource()..socket = getIt<io.Socket>(),
  );
  // Repository
  getIt.registerSingleton<VideoCallRepository>(
    VideoCallRepositoryImpl(getIt<VideoCallDataSource>()),
  );

  // UseCases - Signaling
  getIt.registerSingleton<ConnectUseCase>(
    ConnectUseCase(getIt<VideoCallRepository>()),
  );

  // ViewModel
  getIt
    ..registerFactory<NavigationBarPageViewModel>(
      () => NavigationBarPageViewModel(),
    )
    ..registerFactory<WebrtcPageViewModel>(
      () => WebrtcPageViewModel(
        videoCallRepository: getIt<VideoCallRepository>(),
      ),
    );
}
