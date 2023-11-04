import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/system_chrome_helper/system_chrome_helper.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/world_video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this.model) : super(VideoState.defState(model));
  final HomeVideoModel model;
  int hiddingId = 0;
  bool isSkipTap = false;
  final position = ValueNotifier<Duration>(Duration.zero);

  late WorldVideoPlayerController videoController =
      WorldVideoPlayerController.network(
    url: model.videoUrl,
    aspectRatio: 16 / 9,
    thumbnail: model.image,
    title: model.title,
  )
        ..init()
        ..videoPlayerController.addListener(listener);

  Future<void> hideIcons() async {
    hiddingId++;
    final myId = hiddingId;
    await Future.delayed(AppDurations.duration_2s);
    if (myId != hiddingId) {
      return;
    }
    if (isClosed) return;
    myEmit(
      VideoState(
        currentVideo: state.currentVideo,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        isLocked: state.isLocked,
        isVisible: false,
      ),
    );
  }

  void switchVisibility({bool? dontHide}) {
    hiddingId++;
    if (!state.isVisible) {
      SystemChromeHelper.switchOffOverlays();
    }
    myEmit(
      VideoState(
        currentVideo: state.currentVideo,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        isLocked: state.isLocked,
        isVisible: !state.isVisible,
      ),
    );
    if (dontHide ?? false) return;
    hideIcons();
  }

  void switchLock() {
    myEmit(
      VideoState(
        currentVideo: state.currentVideo,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        isLocked: (!state.isLocked)..log(message: 'switching lock '),
        isVisible: state.isVisible,
      ),
    );
  }

  void setPlaying() {
    final videoConVal = videoController.videoPlayerController.value;
    final isPlaying = videoConVal.isInitialized &&
        !videoConVal.isBuffering &&
        videoConVal.isPlaying;
    return myEmit(
      VideoState(
        currentVideo: state.currentVideo,
        isBuffering: state.isBuffering,
        isPlaying: isPlaying,
        isLocked: state.isLocked,
        isVisible: state.isVisible,
      ),
    );
  }

  void setBuffering(bool val) {
    if (val == state.isBuffering) return;
    myEmit(
      VideoState(
        currentVideo: state.currentVideo,
        isLocked: state.isLocked,
        isVisible: state.isVisible,
        isBuffering: val,
        isPlaying: state.isPlaying,
      ),
    );
  }

  Future<void> dispose() async {
    'Idsposing'.log();
    videoController.removeListener(listener);
    await videoController.pause();
    await videoController.dispose();
    // this.close();
  }

  Future<void> reInit(HomeVideoModel nextVideo) async {
    videoController.videoPlayerController.removeListener(listener);
    videoController.dispose();
    // videoController = null;
    videoController = WorldVideoPlayerController.network(
      url: nextVideo.videoUrl,
      aspectRatio: 16 / 9,
      thumbnail: nextVideo.image,
      title: nextVideo.title,
    )..init();
    videoController.videoPlayerController.addListener(listener);
    myEmit(
      VideoState(
        isLocked: state.isLocked,
        isVisible: state.isVisible,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        currentVideo: nextVideo,
      ),
    );
  }

  void listener() {
    final mainVideoCon = videoController.videoPlayerController;
    final val = mainVideoCon.value;
    position.value = mainVideoCon.value.position;
    this.setPlaying();
    this.setBuffering(val.isBuffering..log());
  }

  void myEmit(VideoState state) {
    if (isClosed) return;
    emit(state);
  }
}
