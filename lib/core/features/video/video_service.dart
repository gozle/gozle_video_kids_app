import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/world_video_player.dart';

class VideoService {
  static void playPause(
      VideoState state,
      WorldVideoPlayerController videoController,
      VideoCubit cubit,
      AnimationController animController) async {
    if (state.isLocked ||
        !videoController.videoPlayerController.value.isInitialized) {
      return;
    }
    if (!state.isVisible) {
      cubit.switchVisibility();
      return;
    }
    bool newIsPplaying = false;
    if (videoController.videoPlayerController.value.isPlaying) {
      await videoController.pause();
      animController.forward();
    } else {
      await videoController.resume();
      animController.reverse();
      newIsPplaying = true;
    }
    cubit.setPlaying(newIsPplaying);
  }

  static int findIndex(BuildContext context) {
    final videoState = context.read<VideoCubit>().state;
    final homeState = context.read<HomeBloc>().state;
    final pkies = homeState.videos.map((e) => e.pk).toList();
    return pkies.indexOf(videoState.currentVideo.pk);
  }
}
