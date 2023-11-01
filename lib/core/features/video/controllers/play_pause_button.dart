import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/ink_wrapper.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.onTap,
    required this.animController,
  });
  final VoidCallback onTap;
  final AnimationController animController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        final state = context.read<VideoCubit>().state;
        final isNotVisibleAndLocked = state.isVisible && !state.isLocked;
        return Container(
          height: 75.sp,
          width: 75.sp,
          margin: EdgeInsets.symmetric(horizontal: 60.w),
          child: FittedBox(
            alignment: Alignment.center,
            child: state.isBuffering
                ? Padding(
                    padding: AppPaddings.all_6,
                    child: CircularProgressIndicator(
                      color: AppColors.appBlue,
                    ),
                  )
                : AnimatedOpacity(
                    duration: AppDurations.duration_150ms,
                    opacity: isNotVisibleAndLocked ? 1 : 0,
                    child: InkWrapper(
                      borderRadius: AppBorderRadiuses.border_50,
                      onTap: onTap,
                      child: AnimatedIcon(
                        progress: animController,
                        icon: AnimatedIcons.pause_play,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
