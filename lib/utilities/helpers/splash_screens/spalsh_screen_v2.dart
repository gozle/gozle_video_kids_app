import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'package:status_bar_control/status_bar_control.dart';

class SpalshScreenV2 extends StatefulWidget {
  const SpalshScreenV2({super.key});

  @override
  State<SpalshScreenV2> createState() => _SpalshScreenV2State();
}

class _SpalshScreenV2State extends State<SpalshScreenV2> {
  @override
  void initState() {
    context.read<HomeBloc>().init();
    Future.delayed(AppDurations.duration_2s, () {
      context.go(AppRoutes.home);
    });
    super.initState();
  }

  @override
  void dispose() {
    StatusBarControl.setHidden(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final betaTheme = context.textTheme.splashBeta;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: double.infinity,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  _ImageSquare(
                    imgPath: AssetsPath.splashMasha,
                    deegree: -30,
                    padding: EdgeInsets.only(
                      top: 24.h,
                      left: 93.w,
                    ),
                  ),
                  _ImageSquare(
                    imgPath: AssetsPath.splashA4,
                    deegree: 45,
                    padding: EdgeInsets.only(
                      top: 128.h,
                      // right: 51.w,
                    ),
                  ),
                  _ImageSquare(
                    imgPath: AssetsPath.splashCheburashka,
                    deegree: -30,
                    padding: EdgeInsets.only(
                      top: 295.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppPaddings.vertic_24,
            child: Center(
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.loose,
                children: [
                  Padding(
                    padding: AppPaddings.top_6,
                    child: SvgPicture.asset(
                      AssetsPath.fullLogo,
                      width: 289.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      /// 289.w its width of the logo widget. 16.5 textPadding, and + text it self width
                      left: AppCalculator.getTextWidth(12.sp, 'BETA') +
                          289.w +
                          (16.5 * 2).w,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.5.w,
                      vertical: 4.5.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.appred,
                      borderRadius: AppBorderRadiuses.border_8,
                    ),
                    child: Text(
                      'BETA',
                      style: betaTheme,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: double.infinity,
              width: 166.w,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  _ImageSquare(
                    imgPath: AssetsPath.splashWalpDisnay,
                    deegree: 28,
                    padding: EdgeInsets.only(
                      top: 47.h,
                    ),
                  ),
                  _ImageSquare(
                    imgPath: AssetsPath.splashPixart,
                    deegree: -45,
                    padding: EdgeInsets.only(
                      top: 197.h,
                      right: 51.w,
                    ),
                  ),
                  _ImageSquare(
                    imgPath: AssetsPath.splashDreamWorks,
                    deegree: -15,
                    padding: EdgeInsets.only(
                      top: 315.h,
                      right: 6.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSquare extends StatelessWidget {
  const _ImageSquare({
    required this.imgPath,
    required this.deegree,
    required this.padding,
  });
  final String imgPath;
  final int deegree;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: new Matrix4.identity()..rotateZ(deegree * 3.1415927 / 180),
        child: ClipRRect(
          borderRadius: AppBorderRadiuses.border_15,
          child: SizedBox.square(
            dimension: 89.sp,
            child: Image.asset(
              imgPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
