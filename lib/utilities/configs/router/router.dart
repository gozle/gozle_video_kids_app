import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/core/features/home/view/home_screen.dart';
import 'package:gozle_video_kids_v1/core/features/video/screen.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/splash_screens/spalsh_screen_v2.dart';

class AppRoutes {
  static const home = '/home';
  static const splashScreen = '/splashScreen';
  // static const introductionScreen = '/introduction';
  static const videoScreen = '/video';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen.toRouteName,
      builder: (context, state) {
        return SpalshScreenV2();
      },
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home.toRouteName,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    // GoRoute(
    //   path: AppRoutes.introductionScreen,
    //   name: AppRoutes.introductionScreen.toRouteName,
    //   builder: (context, state) {
    //     return IntroductionScreen();
    //   },
    // ),
    GoRoute(
      path: AppRoutes.videoScreen,
      name: AppRoutes.videoScreen.toRouteName,
      
      builder: (context, state) {
        final model = (state.extra as HomeVideoModel);
        return VideoScreen(model: model);
      },
      pageBuilder: (context, state) {
        final model = (state.extra as HomeVideoModel);

        return CupertinoPage(
          child: VideoScreen(model: model),
        );
      },
    ),
  ],
);
