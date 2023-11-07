import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';

class ResponsiveHelper {
  static Devices? responsiveVal;
  static void init(BuildContext context) {
    if (responsiveVal != null) return;
    final orentation = MediaQuery.orientationOf(context);
    final size = MediaQuery.sizeOf(context);
    if (orentation == Orientation.portrait) {
      if (size.width <= 600) {
        responsiveVal = Devices.phone;
      } else {
        responsiveVal = Devices.tablet;
      }
      return;
    }
    if (size.height <= 600) {
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
