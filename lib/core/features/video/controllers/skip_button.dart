import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/core/features/video/video_service.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/ink_wrapper.dart';

class VideoSkipButton extends StatefulWidget {
  const VideoSkipButton({
    super.key,
    required this.forNext,
  });
  final bool forNext;

  @override
  State<VideoSkipButton> createState() => _VideoSkipButtonState();
}

class _VideoSkipButtonState extends State<VideoSkipButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool skipped = false;
  late var index = VideoService.findIndex(context)..log(message: 'index');
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();
    final state = cubit.state;
    final homeState = context.read<HomeBloc>().state;
    final isNotVisibleAndLocked = state.isVisible && !state.isLocked;
    final isDisabled =
        widget.forNext && index == (homeState.videos.length - 1) ||
            !widget.forNext && index == 0;
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
                cubit.switchVisibility();
                return;
              }
              if (isDisabled) return;
              cubit.isSkipTap = true;
              if (widget.forNext) {
                index++;
              } else {
                index--;
              }
              'before pop$skipped'.log();

              context.pop();
              'afetr pop$skipped'.log();

              context.push(AppRoutes.videoScreen,
                  extra: homeState.videos[index]);
            },
            child: Icon(
              widget.forNext
                  ? Icons.skip_next_sharp
                  : Icons.skip_previous_sharp,
              color: isDisabled ? Colors.black38 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
