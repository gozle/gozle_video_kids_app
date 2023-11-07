import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/app/test_screen.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'package:lottie/lottie.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  Size get preferredSize => Size.fromHeight(65.h);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme.appBarTheme;
    return Container(
      padding: EdgeInsets.only(
        left: 39.w,
        right: 39.w,
      ),
      width: double.infinity,
      height: 65.h,
      color: theme.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.fullLogo,
            height: 42.h,
            alignment: Alignment.centerLeft,
          ),
          ToggleThemeIcon(),
        ],
      ),
    );
  }
}

class ToggleThemeIcon extends StatefulWidget {
  const ToggleThemeIcon({super.key});

  @override
  State<ToggleThemeIcon> createState() => _ToggleThemeIconState();
}

class _ToggleThemeIconState extends State<ToggleThemeIcon>
    with SingleTickerProviderStateMixin {
  late final animController = AnimationController(
    vsync: this,
    duration: AppDurations.duration_500ms,
  );

  void toggleAnim() {
    if (AppCalculator.isDarkMode()) {
      animController.forward();
    } else {
      animController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    toggleAnim();
    return InkWell(
      onTap: () {
        (context.read<AppCubit>().changeThemeMode(
            AppCalculator.isDarkMode() ? ThemeMode.light : ThemeMode.dark));
        'tap ${AppCalculator.isDarkMode()}'.log();
      },
      child: AnimatedContainer(
        padding:
            AppCalculator.isDarkMode() ? EdgeInsets.zero : AppPaddings.all_8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppCalculator.isDarkMode() ? Colors.white : Colors.black87,
        ),
        margin: AppPaddings.all_10,
        width: 50.sp,
        height: 50.sp,
        alignment: Alignment.center,
        duration: AppDurations.duration_500ms,
        child: Lottie.asset(
          AppCalculator.isDarkMode()
              ? AssetsPath.darkThemeLottie
              : AssetsPath.lightThemeLottie,
          controller: animController,
        ),
      ),
    );
  }
}
