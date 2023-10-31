import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls/controls.dart';
import 'controls/player_controls.dart';
import 'enums/fullscreen_state.dart';
import 'enums/player_state.dart';
import 'helpers/world_video_value_provider.dart';
import 'player_controller.dart';

class WorldVideoPlayer extends StatefulWidget {
  final WorldVideoPlayerController controller;
  final ControlsType controlsType;
  final Widget? customControls;
  final Size? size;
  final double expansionHeight;
  final double expansionWidth;

  const WorldVideoPlayer({
    super.key,
    this.size,
    this.customControls,
    required this.controller,
    required this.controlsType,
    this.expansionHeight = 9,
    this.expansionWidth = 16,
  });

  @override
  State<WorldVideoPlayer> createState() => _WorldVideoPlayerState();
}

class _WorldVideoPlayerState extends State<WorldVideoPlayer> {
  FullScreenState fullScreenState = FullScreenState.DISABLED;

  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    widget.controller.removeListener(_listener);
    widget.controller.addListener(_listener);
    super.didChangeDependencies();
  }

  void _listener() {
    if (widget.controller.value.playerState == PlayerState.inited) {
      if (mounted) {
        setState(() {});
      }
    }
    if (widget.controller.value.fullScreenState != fullScreenState) {
      setState(() {
        fullScreenState = widget.controller.value.fullScreenState;
      });

      if (fullScreenState == FullScreenState.ENTERING) {
        try {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => FullScreen(
                controller: widget.controller,
                controlsType: widget.controlsType,
                customControls: widget.customControls,
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        } catch (e) {
          widget.controller.disableFullScreen();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.size != null) {
      return SizedBox(
        height: widget.size?.height,
        width: widget.size?.width,
        child: Stack(
          children: [
            ClipRect(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: double.parse('${widget.expansionWidth}'),
                    height: double.parse('${widget.expansionHeight}'),
                    child: VideoPlayer(widget.controller.videoPlayerController),
                  ),
                ),
              ),
            ),
            WorldVideoPlayerControllerProvider(
              controller: widget.controller,
              child: PlayerControlls(
                controlsType: widget.controlsType,
                customControls: widget.customControls,
              ),
            ),
          ],
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: widget.expansionWidth / widget.expansionHeight,
        child: Stack(
          children: [
            VideoPlayer(widget.controller.videoPlayerController),
            WorldVideoPlayerControllerProvider(
              controller: widget.controller,
              child: PlayerControlls(
                controlsType: widget.controlsType,
                customControls: widget.customControls,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class FullScreen extends StatefulWidget {
  final WorldVideoPlayerController controller;
  final ControlsType controlsType;
  final Widget? customControls;
  final double expansionHeight;
  final double expansionWidth;

  const FullScreen({
    super.key,
    required this.controller,
    required this.controlsType,
    this.customControls,
    this.expansionHeight = 9,
    this.expansionWidth = 16,
  });

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  FullScreenState fullScreenState = FullScreenState.ENABLED;

  @override
  void initState() {
    widget.controller.addListener(_fullScreenListener);

    super.initState();
  }

  void _fullScreenListener() {
    if (widget.controller.value.playerState == PlayerState.inited) {
      if (mounted) {
        setState(() {});
      }
    }

    if (widget.controller.value.fullScreenState != fullScreenState) {
      setState(() {
        fullScreenState = widget.controller.value.fullScreenState;
        widget.controller.value.copyWith(fullScreenState: fullScreenState);
      });

      if (fullScreenState == FullScreenState.CLOSING) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_fullScreenListener);
    widget.controller.value.copyWith(fullScreenState: FullScreenState.DISABLED);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.controller.disableFullScreen();
        return false;
      },
      child: Material(
        color: Colors.black,
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: widget.expansionWidth / widget.expansionHeight,
                child: VideoPlayer(widget.controller.videoPlayerController),
              ),
              WorldVideoPlayerControllerProvider(
                controller: widget.controller,
                child: PlayerControlls(
                  controlsType: widget.controlsType,
                  customControls: widget.customControls,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
