import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'enums/enums.dart';
import 'models/models.dart';
import 'utils/hls_parser.dart';

class WorldVideoPlayerController extends ValueNotifier<WorldVideoPlayerValue> {
  // VALUE NOTIFIER
  void updateValue(WorldVideoPlayerValue newValue) {
    try {
      value = newValue;
    } catch (e) {
      log(e.toString());
    }
  }

  // главные контроллер
  late VideoPlayerController videoPlayerController;

  // иницилазизация видео по ссылке
  // принимает все типы видео m3u8, mp4 итд
  WorldVideoPlayerController.network({
    required String url,
    String? title,
    String? thumbnail,
    double? aspectRatio,
  }) : super(WorldVideoPlayerValue()) {
    //
    updateValue(value.copyWith(
      title: title,
      thumbnail: thumbnail,
      playerState: PlayerState.initing,
      aspectRatio: aspectRatio,
    ));

    final uri = Uri.parse(url);

    videoPlayerController = VideoPlayerController.networkUrl(uri);

    VideoType videoType;

    if (uri.pathSegments.last.endsWith("mkv")) {
      videoType = VideoType.MKV;
    } else if (uri.pathSegments.last.endsWith("mp4")) {
      videoType = VideoType.MP4;
    } else if (uri.pathSegments.last.endsWith('webm')) {
      videoType = VideoType.WEBM;
    } else if (uri.pathSegments.last.endsWith("m3u8")) {
      videoType = VideoType.HLS;
    } else {
      throw 'Неизвестный формат видео ${uri.pathSegments.last}';
    }

    updateValue(value.copyWith(videoType: videoType));

    if (videoType == VideoType.HLS) {
      // устанавливаю аудио и видео traks
      HlsParser.getTraks(videoUrl: url).then((traks) {
        final videoTraks = traks.$1;
        final audioTraks = traks.$2;

        updateValue(
          value.copyWith(
            videoTraks: videoTraks,
            audioTraks: audioTraks,
            currentVideoTrack: videoTraks.first,
            currentAudioTreack: audioTraks.first, // под вопросом
          ),
        );
      });
    }
  }

  // инициализация видео по файлу
  WorldVideoPlayerController.file({
    required String path,
    String? title,
    String? thumbnail,
    double? aspectRatio,
  }) : super(WorldVideoPlayerValue()) {
    updateValue(value.copyWith(
        title: title, thumbnail: thumbnail, aspectRatio: aspectRatio));

    updateValue(value.copyWith(videoType: VideoType.FILE));

    final file = File(path);

    // проверяем наличие видео по пути $path
    if (file.existsSync()) {
      videoPlayerController = VideoPlayerController.file(file);
    } else {
      throw 'Видео не найдено $path';
    }
  }
  WorldVideoPlayerController.asset({
    required String path,
    String? title,
    String? thumbnail,
    double? aspectRatio,
  }) : super(WorldVideoPlayerValue()) {
    updateValue(value.copyWith(
        title: title, thumbnail: thumbnail, aspectRatio: aspectRatio));

    updateValue(value.copyWith(videoType: VideoType.ASSET));

    // проверяем наличие видео по пути $path
    videoPlayerController = VideoPlayerController.asset(path);
  }

  // todo
  WorldVideoPlayerController.cashed({
    required String url,
    String? title,
    String? thumbnail,
    double? aspectRatio,
  }) : super(WorldVideoPlayerValue()) {
    updateValue(value.copyWith(
        title: title, thumbnail: thumbnail, aspectRatio: aspectRatio));

    updateValue(value.copyWith(videoType: VideoType.CASHED));
  }

  @override
  Future<void> dispose() async {
    videoPlayerController.removeListener(_listener);
    await videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> init() async {
    await videoPlayerController.initialize();

    updateValue(value.copyWith(
      playerState: PlayerState.inited,
    ));

    if (value.autoPlay) {
      await videoPlayerController.play();
    }

    videoPlayerController.addListener(_listener);
  }

  void _listener() {
    PlayerState? playerState;

    if (videoPlayerController.value.isPlaying) {
      playerState = PlayerState.playing;
    }
    if (videoPlayerController.value.isPlaying == false) {
      playerState = PlayerState.paused;
    }
    if (videoPlayerController.value.isBuffering) {
      playerState = PlayerState.buffering;
    }

    updateValue(
      value.copyWith(
        position: videoPlayerController.value.position,
        totalDuration: videoPlayerController.value.duration,
        buffered: videoPlayerController.value.buffered.lastOrNull?.end ??
            Duration.zero,
        hasPlayed: videoPlayerController.value.isCompleted,
        playerState: playerState,
      ),
    );
  }

  // ||| QUALITY CHANGING |||

  void changeVideoQuality({required M3U8Data m3u8data}) async {
    updateValue(
      value.copyWith(
        currentVideoTrack: m3u8data,
      ),
    );

    final lastPosition = value.position;

    videoPlayerController.removeListener(_listener);

    await videoPlayerController.dispose();

    updateValue(value.copyWith(
      playerState: PlayerState.initing,
    ));

    final newVideoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(m3u8data.dataURL!));

    videoPlayerController = newVideoPlayerController;

    await videoPlayerController.initialize();

    updateValue(value.copyWith(
      playerState: PlayerState.inited,
    ));

    await seekTo(lastPosition);

    videoPlayerController.addListener(_listener);
  }

  // ||| PLAY | PAUSE |||

  Future<void> pause() async {
    videoPlayerController.pause();
  }

  Future<void> resume() async {
    videoPlayerController.play();
  }

  // LOOPING |||  ENABLE | DISABLE |||

  Future<void> disableLooping() async {
    videoPlayerController.setLooping(false);
    updateValue(value.copyWith(
      isLooping: false,
    ));
  }

  Future<void> enableLooping() async {
    videoPlayerController.setLooping(true);
    updateValue(value.copyWith(
      isLooping: true,
    ));
  }

  // FULL SCREEN ||| ENABLE | DISABLE |||

  Future<void> enableFullScreen() async {
    updateValue(value.copyWith(
      fullScreenState: FullScreenState.ENTERING,
    ));

    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } catch (_) {}

    updateValue(value.copyWith(
      fullScreenState: FullScreenState.ENABLED,
    ));
  }

  Future<void> disableFullScreen() async {
    updateValue(value.copyWith(
      fullScreenState: FullScreenState.CLOSING,
      controlsState: ControlsState.HIDDEN,
    ));

    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } catch (_) {}

    updateValue(value.copyWith(
      fullScreenState: FullScreenState.DISABLED,
    ));
  }

  // CONTROLS ||| HIDE | SHOW | ENABLE | DISABLE |||

  Future<void> hideControls() async {
    updateValue(value.copyWith(
      controlsState: ControlsState.HIDDEN,
    ));
  }

  Future<void> showControls() async {
    if (value.controlsState == ControlsState.VISIBLE) return;
    updateValue(value.copyWith(
      controlsState: ControlsState.VISIBLE,
    ));
  }

  Future<void> setControlsAlwaysVisible() async {
    if (value.controlsState == ControlsState.ALWAYS_VISIBLE) return;

    updateValue(value.copyWith(
      controlsState: ControlsState.ALWAYS_VISIBLE,
    ));
  }

  Future<void> enableControls() async {
    if (value.controlsState == ControlsState.HIDDEN) return;

    updateValue(value.copyWith(
      controlsState: ControlsState.HIDDEN,
    ));
  }

  Future<void> disableControls() async {
    if (value.controlsState == ControlsState.DISABLED) return;
    updateValue(value.copyWith(
      controlsState: ControlsState.DISABLED,
    ));
  }

  // AUTOPLAY ||| ENABLE || DISABLE |||

  void enableAutoPlay() {
    updateValue(value.copyWith(autoPlay: true));
  }

  void disableAutoPlay() {
    updateValue(value.copyWith(autoPlay: false));
  }

  // SEEK VIDEO ||| TO || BACK || FRONT |||

  Future<void> seekTo(Duration duration) async {
    if (duration > value.totalDuration) {
      await videoPlayerController.seekTo(value.totalDuration);
      updateValue(value.copyWith(position: value.totalDuration));
    } else {
      await videoPlayerController.seekTo(duration);
      updateValue(value.copyWith(position: duration));
      videoPlayerController.play();
    }
  }

  Future<void> seekBack() async {
    final duration = Duration(seconds: (value.position.inSeconds - 10));
    if (duration > value.totalDuration) {
      await videoPlayerController.seekTo(value.totalDuration);
      updateValue(value.copyWith(position: value.totalDuration));
    } else {
      await videoPlayerController.seekTo(duration);
      updateValue(value.copyWith(position: duration));
      videoPlayerController.play();
    }
  }

  Future<void> seekFront() async {
    final duration = Duration(seconds: (value.position.inSeconds + 10));
    if (duration > value.totalDuration) {
      await videoPlayerController.seekTo(value.totalDuration);
      updateValue(value.copyWith(position: value.totalDuration));
    } else {
      await videoPlayerController.seekTo(duration);
      updateValue(value.copyWith(position: duration));
      videoPlayerController.play();
    }
  }

  Future<void> repeat() async {
    await seekTo(Duration.zero);
  }

  void changePlaybackRate({required double playbackRate}) {
    updateValue(value.copyWith(
      playbackRate: playbackRate,
    ));
    videoPlayerController.setPlaybackSpeed(playbackRate);
  }
}
