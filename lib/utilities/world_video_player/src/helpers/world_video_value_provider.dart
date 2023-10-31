import 'package:flutter/material.dart';

import '../player_controller.dart';

class WorldVideoPlayerControllerProvider extends InheritedWidget {
  final WorldVideoPlayerController controller;

  const WorldVideoPlayerControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static WorldVideoPlayerController of(BuildContext context) {
    final controllerProvider =
        context.dependOnInheritedWidgetOfExactType<WorldVideoPlayerControllerProvider>();
    assert(
      controllerProvider != null,
      'Cannot find WorldVideoPlayerControllerProvider above. Please wrap parent widget with WorldVideoPlayerControllerProvider.',
    );
    return controllerProvider!.controller;
  }

  static WorldVideoPlayerController? maybeOf(BuildContext context) {
    final controllerProvider =
        context.dependOnInheritedWidgetOfExactType<WorldVideoPlayerControllerProvider>();

    return controllerProvider?.controller;
  }

  @override
  bool updateShouldNotify(WorldVideoPlayerControllerProvider old) {
    return old.controller.hashCode != controller.hashCode;
  }
}
