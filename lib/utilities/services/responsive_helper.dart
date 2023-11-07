import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class ResponsiveHelper {
  static Devices? responsiveVal;

  static void init(BuildContext context) {
    if (responsiveVal != null) return;
    final size = MediaQuery.sizeOf(context)..log();
    if (size.height <= 600) {
      'itsPhone'.log();
      responsiveVal = Devices.phone;
    } else {
      responsiveVal = Devices.tablet;
    }
  }

  static T solve<T>(T phoneVal, T tabletVal) {
    return {
      Devices.phone: phoneVal,
      Devices.tablet: tabletVal,
    }[responsiveVal]!;
  }
}
