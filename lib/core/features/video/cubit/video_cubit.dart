import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/world_video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this.model) : super(VideoState.defState(model));
  final HomeVideoModel model;
  int hiddingId = 0;
  bool isSkipTap = false;
  late WorldVideoPlayerController videoController =
      WorldVideoPlayerController.network(
    url: model.videoUrl,
    aspectRatio: 16 / 9,
    thumbnail: model.image,
    title: model.title,
  )..init();

  Future<void> hideIcons() async {
    hiddingId++;
    final myId = hiddingId;
    await Future.delayed(AppDurations.duration_2s);
    if (myId != hiddingId) {
      return;
    }
    if (isClosed) return;
    emit(
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
    if (isClosed) return;
    hiddingId++;
    emit(
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
    emit(
      VideoState(
        currentVideo: state.currentVideo,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        isLocked: (!state.isLocked)..log(message: 'switching lock '),
        isVisible: state.isVisible,
      ),
    );
  }

  void setPlaying(bool isPlaying) {
    if (isPlaying == state.isPlaying)
      return emit(
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
    emit(
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
    await videoController.pause();
    await videoController.dispose();
    // this.close();
  }
}
