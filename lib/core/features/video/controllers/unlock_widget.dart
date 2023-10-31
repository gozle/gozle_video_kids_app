import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class UnlockWidget extends StatelessWidget {
  const UnlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();
    return AnimatedOpacity(
      duration: AppDurations.duration_150ms,
      opacity: cubit.state.isVisible ? 1 : 0,
      child: GestureDetector(
        onTap: () {
          'somr'.log();
          cubit.switchVisibility();
        },
        child: Container(
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              GestureDetector(
                onDoubleTap: () {
                  cubit.hiddingId++;
                  cubit.switchLock();
                  cubit.hideIcons();
                },
                child: SvgPicture.asset(
                  AssetsPath.unlockIcon,
                  width: 43.w,
                ),
              ),
              AppSpacing.vertical_12,
              SizedBox(
                width: 404.w,
                child: Text(
                  'Дважды нажмите,  чтобы разблокировать',
                  style: GoogleFonts.inter(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
