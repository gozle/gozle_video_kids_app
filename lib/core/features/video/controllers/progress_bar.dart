import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/world_video_player.dart';

class MyVideoProggresBar extends StatefulWidget {
  const MyVideoProggresBar({
    super.key,
  });

  @override
  State<MyVideoProggresBar> createState() => My_VideoProggresBarState();
}

class My_VideoProggresBarState extends State<MyVideoProggresBar> {
  @override
  void initState() {
    cubit = context.read<VideoCubit>();
    videoController = cubit.videoController!;
    videoController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    videoController.removeListener(listener);
    super.dispose();
  }

  void listener() {
    position.value = videoController.value.position;
    final val = videoController.videoPlayerController.value;
    cubit.setPlaying(val.isPlaying);
    cubit.setBuffering(val.isBuffering..log());
  }

  final position = ValueNotifier<Duration>(Duration.zero);
  late final VideoCubit cubit;
  late final WorldVideoPlayerController videoController;
  @override
  Widget build(BuildContext context) {
    final state = cubit.state;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 32),
      child: BlocBuilder<VideoCubit, VideoState>(
        bloc: cubit,
        builder: (context, state) {
          final isNotVisibleAndLocked = state.isVisible && !state.isLocked;
          return AnimatedOpacity(
            duration: AppDurations.duration_150ms,
            opacity: isNotVisibleAndLocked ? 1 : 0,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ValueListenableBuilder(
                valueListenable: position,
                builder: (context, val, __) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${videoController.value.position.toTime} / ${videoController.value.totalDuration.toTime}',
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      AppSpacing.vertical_8,
                      ProgressBar(
                        timeLabelTextStyle: TextStyle(fontSize: 0.sp),
                        onDragEnd: () {
                          cubit.hideIcons();
                        },
                        onSeek: (value) {
                          videoController.seekTo(value);
                        },
                        onDragStart: (details) {
                          cubit.hiddingId++;
                        },
                        onDragUpdate: (details) {
                          if (state.isLocked ||
                              !videoController.value.isReady) {
                            return;
                          }
                          if (!state.isVisible) {
                            cubit.switchVisibility(dontHide: true);
                            return;
                          }
                          'seek Update'.log();
                          videoController.seekTo(details.timeStamp);
                        },
                        thumbRadius: 12.sp,
                        thumbColor: Colors.transparent,
                        progress: val,
                        total: videoController.value.totalDuration,
                        buffered: videoController.value.buffered,
                        barCapShape: BarCapShape.round,
                        thumbGlowRadius: 0,
                        bufferedBarColor: Colors.grey.shade100,
                        baseBarColor: Colors.grey.shade400,
                        progressBarColor: AppColors.appBlue,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
