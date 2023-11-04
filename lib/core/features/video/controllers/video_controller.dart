import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/play_pause_button.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/skip_button.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/unlock_widget.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/ink_wrapper.dart';
import 'package:status_bar_control/status_bar_control.dart';

class GozleVideoKidsControllers extends StatelessWidget {
  const GozleVideoKidsControllers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();
    return BlocBuilder<VideoCubit, VideoState>(
      bloc: cubit,
      builder: (context, state) {
        final isNotVisibleAndLocked = state.isVisible && !state.isLocked;
        if (state.isLocked) {
          return UnlockWidget();
        }
        return Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 23.h,
            left: 32.w,
            right: 32.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    duration: AppDurations.duration_150ms,
                    opacity: isNotVisibleAndLocked ? 1 : 0,
                    child: InkWrapper(
                      borderRadius: AppBorderRadiuses.border_50,
                      onTap: () async {
                        if (state.isLocked) return;
                        if (!state.isVisible) {
                          cubit.switchVisibility();
                          return;
                        }
                        await StatusBarControl.setHidden(false);
                        context.pop();
                      },
                      child: Container(
                        height: 30.sp,
                        width: 30.sp,
                        margin: AppPaddings.all_16,
                        child: FittedBox(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.horizontal_12,
                  Expanded(
                    child: AnimatedOpacity(
                      duration: AppDurations.duration_150ms,
                      opacity: isNotVisibleAndLocked ? 1 : 0,
                      child: Text(
                        state.currentVideo.title,
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFE7E7E7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  AppSpacing.horizontal_20,
                  AnimatedOpacity(
                    duration: AppDurations.duration_150ms,
                    opacity: isNotVisibleAndLocked ? 1 : 0,
                    child: InkWrapper(
                      borderRadius: AppBorderRadiuses.border_50,
                      onTap: state.isVisible
                          ? null
                          : () {
                              if (!state.isVisible) {
                                cubit.switchVisibility();
                                return;
                              }
                            },
                      onDoubleTap: !state.isVisible
                          ? null
                          : () {
                              cubit.hiddingId++;
                              cubit.switchLock();
                              cubit.hideIcons();
                            },
                      child: Padding(
                        padding: AppPaddings.all_16,
                        child: SizedBox.square(
                          dimension: 30.sp,
                          child: FittedBox(
                            child: SvgPicture.asset(
                              color: Colors.white,
                              AssetsPath.lockIcon,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VideoSkipButton(
                    forNext: false,
                  ),
                  PlayPauseButton(),
                  VideoSkipButton(
                    forNext: true,
                  ),
                ],
              ),
              AppSpacing.vertical_40
            ],
          ),
        );
      },
    );
  }
}
