import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/app/injection/setup.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage_impl.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/system_chrome_helper/system_chrome_helper.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChromeHelper.changeStatusBarColor(AppColors.statusBarBlue);
    Future.delayed(AppDurations.duration_2s, () {
      context.go(AppRoutes.home);
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChromeHelper.changeStatusBarColor(AppColors.transparent);
    super.dispose();
  }

  final localStorage = getIt<LocalStorage>() as LocalStorageImpl;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.logoStyle;
    final imageHeight =
        AppCalculator.getTextHeight(textStyle!.fontSize!) + 30.sp;
    return SafeArea(
      bottom: false,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPath.splashScreen),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.splashFilter,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.gozleIconRed,
                  height: imageHeight,
                  width: imageHeight,
                ),
                AppSpacing.horizontal_5,
                Text(
                  'Gozle Video Kids',
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
