import 'package:flutter/services.dart';
import 'package:status_bar_control/status_bar_control.dart';

class SystemChromeHelper {
  static Future<void> changeStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );
  }

  static Future<void> setOrentationAll() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  static Future<void> setOrentationHoriz() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Future<void> switchOnOverlays() async {
    await StatusBarControl.setHidden(false);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }

  static Future<void> switchOffOverlays() async {
    await StatusBarControl.setHidden(true);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: List.empty());
  }
}
