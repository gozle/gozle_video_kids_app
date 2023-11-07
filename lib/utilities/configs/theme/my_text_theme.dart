import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/utilities/services/responsive_helper.dart';

class MyTextTheme extends ThemeExtension<MyTextTheme> {
  MyTextTheme({
    required this.homeVideoWidgetLabel,
    required this.homeVideoWigetDuration,
    required this.introductionTitle,
    required this.introductionSubTitle,
    required this.logoStyle,
    required this.myRedButton,
    required this.splashBeta,
    required this.tryAgainTitle,
  });

  late final TextStyle homeVideoWidgetLabel;
  late final TextStyle homeVideoWigetDuration;
  late final TextStyle introductionTitle;
  late final TextStyle introductionSubTitle;
  late final TextStyle logoStyle;
  late final TextStyle myRedButton;
  late final TextStyle splashBeta;
  late final TextStyle tryAgainTitle;

  factory MyTextTheme.lightTheme() => MyTextTheme(
        tryAgainTitle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        splashBeta: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        homeVideoWigetDuration: GoogleFonts.inter(
          fontSize: ResponsiveHelper.solve(12.sp, 10.sp),
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        homeVideoWidgetLabel: GoogleFonts.inter(
          fontSize: ResponsiveHelper.solve(15.sp, 12.sp),
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000),
        ),
        introductionSubTitle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        logoStyle: GoogleFonts.luckiestGuy(
          fontSize: 36.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        introductionTitle: GoogleFonts.inter(
          fontSize: 30.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        myRedButton: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      );

  //! dark theme
  factory MyTextTheme.darkTheme() => MyTextTheme(
        tryAgainTitle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        splashBeta: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        homeVideoWigetDuration: GoogleFonts.inter(
          fontSize: ResponsiveHelper.solve(12.sp, 10.sp),
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
        homeVideoWidgetLabel: GoogleFonts.inter(
          fontSize: ResponsiveHelper.solve(15.sp, 12.sp),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        //todo impl
        introductionSubTitle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        logoStyle: GoogleFonts.luckiestGuy(
          fontSize: 36.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        introductionTitle: GoogleFonts.inter(
          fontSize: 30.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        myRedButton: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      );

  @override
  MyTextTheme lerp(MyTextTheme? other, double t) {
    return MyTextTheme.lightTheme();
  }

  @override
  MyTextTheme copyWith() {
    return MyTextTheme.lightTheme();
  }

  @override
  String toString() => 'MyTextTheme:('
      'hoemVideoWidgetLabel:$homeVideoWidgetLabel\n'
      'homeVideoWigetDuration:$homeVideoWigetDuration\n'
      'introductionSubTitle:$introductionSubTitle\n'
      'introductionTitle:$introductionTitle\n'
      'logoStyle:$logoStyle'
      'myRedButton:$myRedButton';
}
