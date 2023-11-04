import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/app/app.dart';
import 'package:gozle_video_kids_v1/app/injection/setup.dart';
import 'package:gozle_video_kids_v1/utilities/services/system_chrome_helper/system_chrome_helper.dart';

Future<void> main() async {
  configureDependencies(getIt);
  await WidgetsFlutterBinding.ensureInitialized();
  SystemChromeHelper.setOrentationHoriz();
  runApp(const GozleVideoKidsApp());

}