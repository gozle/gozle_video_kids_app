part of 'video_cubit.dart';

class VideoState extends Equatable {
  VideoState({
    required this.isLocked,
    required this.isVisible,
    required this.isBuffering,
    required this.isPlaying,
    required this.currentVideo,
  });
  final bool isVisible;
  final bool isLocked;
  final bool isPlaying;
  final bool isBuffering;
  final HomeVideoModel? currentVideo;

  static VideoState defState(HomeVideoModel model) => VideoState(
        currentVideo: model,
        isBuffering: true,
        isLocked: false,
        isVisible: true,
        isPlaying: false,
      );

  @override
  List<Object?> get props => [
        isVisible,
        isLocked,
        isPlaying,
        isBuffering,
        currentVideo,
      ];
}
