import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/core/features/video/video_service.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/ink_wrapper.dart';

class VideoSkipButton extends StatelessWidget {
  VideoSkipButton({
    super.key,
    required this.forNext,
  });
  final bool forNext;

  @override
  Widget build(BuildContext context) {
    final videoCubit = context.read<VideoCubit>();
    final state = videoCubit.state;
    final homeState = context.read<HomeBloc>().state;
    final isNotVisibleAndLocked = state.isVisible && !state.isLocked;
    int index = VideoService.findIndex(context)..log(message: 'index');
    final isDisabled = forNext && index == (homeState.videos.length - 1) ||
        !forNext && index == 0;
    return SizedBox.square(
      dimension: 50.sp,
      child: FittedBox(
        alignment: Alignment.center,
        child: AnimatedOpacity(
          duration: AppDurations.duration_150ms,
          opacity: isNotVisibleAndLocked ? 1 : 0,
          child: InkWrapper(
            borderRadius: AppBorderRadiuses.border_50,
            onTap: () async {
              if (!state.isVisible) {
                videoCubit.switchVisibility();
                return;
              }
              if (isDisabled) return;
              if (forNext) {
                index++;
              } else {
                index--;
              }
              final nextVideo = homeState.videos[index];
              videoCubit.reInit(nextVideo);
            },
            child: Icon(
              forNext ? Icons.skip_next_sharp : Icons.skip_previous_sharp,
              color: isDisabled ? Colors.black38 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
