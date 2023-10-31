import '../enums/enums.dart';
import 'models.dart';

class WorldVideoPlayerValue {
  WorldVideoPlayerValue({
    this.aspectRatio = 16 / 9,
    this.autoPlay = true,
    this.isReady = false,
    this.controlsState = ControlsState.HIDDEN,
    this.isLive = false,
    this.isMooted = false,
    this.isLooping = false,
    this.videoType = VideoType.HLS,
    this.hasPlayed = false,
    this.position = const Duration(),
    this.totalDuration = const Duration(),
    this.buffered = const Duration(),
    this.volume = 100,
    this.playerState = PlayerState.unknown,
    this.playbackRate = PlaybackRate.normal,
    this.errorCode = 0,
    this.isDragging = false,
    this.title,
    this.thumbnail,
    this.videoTraks,
    this.audioTraks,
    this.currentVideoTrack,
    this.currentAudioTreack,
    this.fullScreenState = FullScreenState.DISABLED,
  });

  final bool autoPlay;

  final bool isReady;

  final bool hasPlayed;

  final VideoType videoType;

  final M3U8Data? currentVideoTrack;

  final AudioModel? currentAudioTreack;

  final Duration position;

  final Duration totalDuration;

  final Duration buffered;

  final FullScreenState fullScreenState;

  final bool isMooted;

  final int volume;

  final PlayerState playerState;

  final ControlsState controlsState;

  final double playbackRate;

  final double aspectRatio;

  /// See the onError Section.
  final int errorCode;

  /// Returns true is player has errors.
  bool get hasError => errorCode != 0;

  /// Returns true if [ProgressBar] is being dragged.
  final bool isDragging;
  //
  final bool isLooping;

  final bool isLive;

  // описание видео если имеется
  String? title;
// обложка видео
  String? thumbnail;

  // если видео hls то оно содержит traks и выбор audio
  List<M3U8Data>? videoTraks;

  List<AudioModel>? audioTraks;

  WorldVideoPlayerValue copyWith({
    bool? autoPlay,
    bool? isMooted,
    bool? isLoaded,
    bool? hasPlayed,
    Duration? position,
    Duration? buffered,
    int? volume,
    PlayerState? playerState,
    ControlsState? controlsState,
    double? playbackRate,
    double? aspectRatio,
    String? playbackQuality,
    int? errorCode,
    bool? isDragging,
    VideoType? videoType,
    String? title,
    String? thumbnail,
    List<M3U8Data>? videoTraks,
    List<AudioModel>? audioTraks,
    M3U8Data? currentVideoTrack,
    AudioModel? currentAudioTreack,
    bool? isLooping,
    bool? isLive,
    Duration? totalDuration,
    FullScreenState? fullScreenState,
  }) {
    return WorldVideoPlayerValue(
      autoPlay: autoPlay ?? this.autoPlay,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      hasPlayed: hasPlayed ?? this.hasPlayed,
      position: position ?? this.position,
      totalDuration: totalDuration ?? this.totalDuration,
      buffered: buffered ?? this.buffered,
      fullScreenState: fullScreenState ?? this.fullScreenState,
      volume: volume ?? this.volume,
      playerState: playerState ?? this.playerState,
      controlsState: controlsState ?? this.controlsState,
      playbackRate: playbackRate ?? this.playbackRate,
      errorCode: errorCode ?? this.errorCode,
      isDragging: isDragging ?? this.isDragging,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      videoType: videoType ?? this.videoType,
      videoTraks: videoTraks ?? this.videoTraks,
      audioTraks: audioTraks ?? this.audioTraks,
      isLooping: isLooping ?? this.isLooping,
      isLive: isLive ?? this.isLive,
      isMooted: isMooted ?? this.isMooted,
      currentVideoTrack: currentVideoTrack ?? this.currentVideoTrack,
      currentAudioTreack: currentAudioTreack ?? this.currentAudioTreack,
    );
  }

  @override
  String toString() {
    return '$runtimeType('
        'isReady: $isReady, '
        'position: ${position.inSeconds} sec. , '
        'buffered: $buffered, '
        'volume: $volume, '
        'playerState: $playerState, '
        'playbackRate: $playbackRate, '
        'errorCode: $errorCode)';
  }
}
