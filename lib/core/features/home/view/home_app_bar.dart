import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';

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
    final topPad = AppCalculator.topPad ?? 0;
    return Container(
      // margin: EdgeInsets.only(),
      padding: EdgeInsets.only(
        left: 39.w,
        right: 39.w,
        top: (topPad..log()) ?? 0,
      ),
      width: double.infinity,
      height: 65.h + (topPad),
      color: theme.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.fullLogo,
            height: 42.h,
            alignment: Alignment.centerLeft,
          ),
          // Container(
          //   margin: AppPaddings.vertic_16,
          //   padding: AppPaddings.all_6,
          //   decoration: BoxDecoration(
          //     color: AppColors.black28,
          //     shape: BoxShape.circle,
          //   ),
          //   child: FittedBox(
          //     child: Icon(
          //       Icons.light_mode_outlined,
          //       color: Colors.white,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
