import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';

class ResponsiveHelper {
  static late final Devices responsiveVal;
  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.height < 600) {
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
