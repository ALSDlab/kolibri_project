import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kolibri_project/view/navigation/navigation_bar_page.dart';
import 'package:kolibri_project/view/navigation/navigation_bar_page_view_model.dart';
import 'package:kolibri_project/view/pages/splash_page/splash_page.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_view_model.dart';
import 'package:provider/provider.dart';

import 'di/get_it.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/splash_page',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/splash_page',
      builder: (context, state) => const SplashPage(),
    ),
    // GoRoute(
    //     path: '/login_page',
    //     builder: (context, state) {
    //       return ChangeNotifierProvider(
    //           create: (_) => getIt<LoginPageViewModel>(),
    //           child: const LoginPage());
    //     },
    //     routes: [
    //       GoRoute(
    //         path: 'signup_page',
    //         builder: (context, state) => ChangeNotifierProvider(
    //             create: (_) => getIt<SignupPageViewModel>(),
    //             child: const SignupPage()),
    //       ),
    //       GoRoute(
    //         path: 'change_password_page',
    //         builder: (context, state) => const LoginPage(),
    //       ),
    //     ]),
    // GoRoute(
    //   path: '/webrtc_call_page',
    //   builder: (context, state) {
    //     return ChangeNotifierProvider(
    //       create: (context) => getIt<WebrtcPageViewModel>(),
    //       child: WebrtcCallPage(),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/selected_wg_data_page',
    //   builder: (context, state) {
    //     final extra = state.extra! as Map<String, dynamic>;
    //     return ChangeNotifierProvider(
    //       create: (_) => getIt<FindWGPageViewModel>(),
    //       child: SelectedWgDataPage(
    //         selectedWgData: extra['wgData'],
    //         resetNavigation: extra['resetNavigation'],
    //         resetChatList: extra['resetChatList'],
    //       ),
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/edit_profile_page',
    //   builder: (context, state) {
    //     return ChangeNotifierProvider(
    //       create: (_) => getIt<EditProfilePageViewModel>(),
    //       child: const EditProfilePage(),
    //     );
    //   },
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => getIt<NavigationBarPageViewModel>(),
              ),
              // ChangeNotifierProvider(
              //   create: (_) => getIt<ChatPageViewModel>(),
              //   lazy: false,
              // ),
              // ChangeNotifierProvider(
              //   create: (_) => getIt<ChatListPageViewModel>(),
              // ),
            ],
            child: NavigationBarPage(
              location: state.matchedLocation,
              child: child,
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/webrtc_page',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => getIt<WebrtcPageViewModel>(),
            child: WebrtcPage(),
          ),
        ),
        // GoRoute(
        //   path: '/upload_WG_page',
        //   builder: (context, state) {
        //     // final navigationViewModel =
        //     //     Provider.of<NavigationBarPageViewModel>(context,
        //     //         listen: false);
        //     return ChangeNotifierProvider(
        //       create: (_) => getIt<UploadWGPageViewModel>(),
        //       child: const UploadWGPage(
        //         // resetNavigation: navigationViewModel.resetNavigation,
        //       ),
        //     );
        //   },
        // ),
        // GoRoute(
        //   path: '/history_page',
        //   builder: (context, state) {
        //     final navigationViewModel =
        //     Provider.of<NavigationBarPageViewModel>(context,
        //         listen: false);
        //     return ChangeNotifierProvider(
        //       create: (_) => getIt<MyHistoryPageViewModel>(),
        //       child: MyHistoryPage(
        //         resetNavigation: navigationViewModel.resetNavigation,
        //       ),
        //     );
        //   },
        // ),
        // GoRoute(
        //   path: '/chat_list_page',
        //   builder: (context, state) {
        //     final extra = state.extra! as Map<String, dynamic>;
        //     return MultiProvider(
        //       providers: [
        //         ChangeNotifierProvider.value(
        //           // 기존 ViewModel 인스턴스 유지
        //           value: context.read<NavigationBarPageViewModel>(),
        //         ),
        //         ChangeNotifierProvider(
        //           create: (_) => getIt<ChatListPageViewModel>(),
        //         ),
        //       ],
        //       child: ChatListPage(
        //         resetNavigation: extra['resetNavigation'],
        //         resetChatList: extra['resetChatList'],
        //       ),
        //     );
        //   },
        // ),
        // GoRoute(
        //   path: '/setting_page',
        //   builder: (context, state) {
        //     final navigationViewModel =
        //     Provider.of<NavigationBarPageViewModel>(context,
        //         listen: false);
        //     return ChangeNotifierProvider(
        //       create: (_) {
        //         return getIt<SettingPageViewModel>();
        //       },
        //       child: SettingPage(
        //         resetNavigation: navigationViewModel.resetNavigation,
        //       ),
        //     );
        //   },
        // ),
      ],
    ),
  ],
);
