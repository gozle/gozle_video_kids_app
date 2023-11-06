import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class AppCalculator {
  static double getTextHeight(num size) {
    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: 'h',
        style: TextStyle(
          fontSize: size.toDouble(),
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    renderParagraph.layout(BoxConstraints());
    final textHeight = renderParagraph.size.height;
    return textHeight;
  }

  static double getTextWidth(num size, String text) {
    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size.toDouble(),
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    renderParagraph.layout(BoxConstraints());
    final val = renderParagraph.size.width;
    return val;
  }

  static double myFontSizeResolver(num size, ScreenUtil instance) {
    final num = (1.h + 1.w) / 2;
    return num * size;
  }

  static bool isPhone(BuildContext context, {bool? byHeight}) {
    final orientation = MediaQuery.orientationOf(context);

    final size = MediaQuery.sizeOf(context);
    if (orientation == Orientation.landscape) {
      return size.height <= 600;
    }
    return size.width <= 600;
  }

  static bool isPortrait(BuildContext context) {
    final orentation = MediaQuery.orientationOf(context);
    final orentationValue = orentation == Orientation.portrait;
    return orentationValue;
  }

  ///both sizes are in roatated version
  static const phoneDesingeSize = Size(932, 430);
  static const tabletDesingeSize = Size(1194, 834);
  static double? topPad;

  static void init(BuildContext context) {
    if (topPad != null && topPad != 0.0) {
      return;
    }
    'TopPad init'.log();
    final padding = MediaQuery.paddingOf(context).top;
    topPad = padding;
  }
}
