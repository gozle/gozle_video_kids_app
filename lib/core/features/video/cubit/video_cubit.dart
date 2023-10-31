import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoState.defState);

  int hiddingId = 0;
  bool isSkipTap = false;
  Future<void> hideIcons() async {
    hiddingId++;
    final myId = hiddingId;
    await Future.delayed(AppDurations.duration_2s);
    if (myId != hiddingId) {
      return;
    }
    emit(
      VideoState(
        currentVideoPk: state.currentVideoPk,
        isBuffering: state.isBuffering,
        isPlaying: state.isPlaying,
        isLocked: state.isLocked,
        isVisible: false,
      ),
    );
  }

  void switchVisibility({bool? dontHide}) {
    hiddingId++;
    emit(
      VideoState(
        currentVideoPk: state.currentVideoPk,
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
        currentVideoPk: state.currentVideoPk,
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
          currentVideoPk: state.currentVideoPk,
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
        currentVideoPk: state.currentVideoPk,
        isLocked: state.isLocked,
        isVisible: state.isVisible,
        isBuffering: val,
        isPlaying: state.isPlaying,
      ),
    );
  }

  void dispose() {
    emit(VideoState.defState);
  }
}
