import 'package:flutter/material.dart';
import 'controls.dart';

class PlayerControlls extends StatelessWidget {
  final ControlsType controlsType;
  final Widget? customControls;

  const PlayerControlls({
    super.key,
    required this.controlsType,
    this.customControls,
  });

  @override
  Widget build(BuildContext context) {
    if (controlsType == ControlsType.CUSTOM) {
      // CUSTOM
      if (customControls != null) {
        return customControls!;
      } else {
        throw '''
            Если выбран ControlsType - Custom то нужно ставить в параметры CustomPlayer widget customPlayer: 
            ```
              CustomVideoPlayer(
                controller: worldVideoPlayerController,
                controlsType: ControlsType.DEFAULT,
                // тот самый виджет
                customControls: Container(),
              ),
            ```
        ''';
      }
    } else {
      // DEFAULT
      return const DefaultContols();
    }
  }
}
