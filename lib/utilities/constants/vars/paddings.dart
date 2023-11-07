import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPaddings {
  static EdgeInsets get left_12 => EdgeInsets.only(left: 12.w);
  static EdgeInsets get left_16 => EdgeInsets.only(left: 16.w);
  static EdgeInsets get left_18 => EdgeInsets.only(left: 18.w);
  static EdgeInsets get left_24 => EdgeInsets.only(left: 24.w);
  static EdgeInsets get left_28 => EdgeInsets.only(left: 28.w);
  static EdgeInsets get left_6 => EdgeInsets.only(left: 6.w);

  static EdgeInsets get right_12 => EdgeInsets.only(right: 12.w);
  static EdgeInsets get right_10 => EdgeInsets.only(right: 10.w);
  static EdgeInsets get right_16 => EdgeInsets.only(right: 16.w);
  static EdgeInsets get right_24 => EdgeInsets.only(right: 24.w);
  static EdgeInsets get right_28 => EdgeInsets.only(right: 28.w);
  static EdgeInsets get right_7 => EdgeInsets.only(right: 7.w);
  static EdgeInsets get right_6 => EdgeInsets.only(right: 6.w);
  static EdgeInsets get right_5 => EdgeInsets.only(right: 5.w);
  static EdgeInsets get right_14 => EdgeInsets.only(right: 14.w);

  static EdgeInsets get top_12 => EdgeInsets.only(top: 12.h);
  static EdgeInsets get top_16 => EdgeInsets.only(top: 16.h);
  static EdgeInsets get top_24 => EdgeInsets.only(top: 24.h);
  static EdgeInsets get top_20 => EdgeInsets.only(top: 20.h);
  static EdgeInsets get top_28 => EdgeInsets.only(top: 28.h);
  static EdgeInsets get top_2 => EdgeInsets.only(top: 2.h);
  static EdgeInsets get top_6 => EdgeInsets.only(top: 6.h);

  static EdgeInsets get bottom_24 => EdgeInsets.only(bottom: 24.h);
  static EdgeInsets get bottom_28 => EdgeInsets.only(bottom: 28.h);
  static EdgeInsets get bottom_15 => EdgeInsets.only(bottom: 15.h);
  static EdgeInsets get bottom_16 => EdgeInsets.only(bottom: 16.h);
  static EdgeInsets get bottom_12 => EdgeInsets.only(bottom: 12.h);
  static EdgeInsets get bottom_10 => EdgeInsets.only(bottom: 10.h);
  static EdgeInsets get bottom_2 => EdgeInsets.only(bottom: 2.h);
  static EdgeInsets get bottom_4 => EdgeInsets.only(bottom: 4.h);

  static EdgeInsets get all_12 => EdgeInsets.all(12.sp);
  static EdgeInsets get all_10 => EdgeInsets.all(10.sp);
  static EdgeInsets get all_16 => EdgeInsets.all(16.sp);
  static EdgeInsets get all_24 => EdgeInsets.all(24.sp);
  static EdgeInsets get all_28 => EdgeInsets.all(28.sp);
  static EdgeInsets get all_2 => EdgeInsets.all(2.sp);
  static EdgeInsets get all_4 => EdgeInsets.all(4.sp);
  static EdgeInsets get all_5 => EdgeInsets.all(5.sp);
  static EdgeInsets get all_6 => EdgeInsets.all(6.sp);
  static EdgeInsets get all_8 => EdgeInsets.all(8.sp);

  static EdgeInsets get horiz_37 => EdgeInsets.symmetric(horizontal: 27.w);
  static EdgeInsets get horiz_12 => EdgeInsets.symmetric(horizontal: 12.w);
  static EdgeInsets get horiz_10 => EdgeInsets.symmetric(horizontal: 10.w);
  static EdgeInsets get horiz_10half =>
      EdgeInsets.symmetric(horizontal: 10.5.w);
  static EdgeInsets get horiz_16 => EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get horiz_39 => EdgeInsets.symmetric(horizontal: 39.w);
  static EdgeInsets get horiz_24 => EdgeInsets.symmetric(horizontal: 24.w);
  static EdgeInsets get horiz_21 => EdgeInsets.symmetric(horizontal: 21.w);
  static EdgeInsets get horiz_28 => EdgeInsets.symmetric(horizontal: 28.h);
  static EdgeInsets get horiz_8 => EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets get horiz_6 => EdgeInsets.symmetric(horizontal: 6.w);
  static EdgeInsets get horiz_2 => EdgeInsets.symmetric(horizontal: 2.w);
  static EdgeInsets get horiz_3 => EdgeInsets.symmetric(horizontal: 3.w);
  static EdgeInsets get horiz_32 => EdgeInsets.symmetric(horizontal: 32.w);
  static EdgeInsets get horiz_4 => EdgeInsets.symmetric(horizontal: 4.w);
  static EdgeInsets get horiz_20 => EdgeInsets.symmetric(horizontal: 20.w);

  static EdgeInsets get vertic_35 => EdgeInsets.symmetric(vertical: 35.h);
  static EdgeInsets get vertic_10 => EdgeInsets.symmetric(vertical: 10.h);
  static EdgeInsets get vertic_20 => EdgeInsets.symmetric(vertical: 20.h);
  static EdgeInsets get vertic_12 => EdgeInsets.symmetric(vertical: 12.h);
  static EdgeInsets get vertic_16 => EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets get vertic_15 => EdgeInsets.symmetric(vertical: 15.h);
  static EdgeInsets get vertic_24 => EdgeInsets.symmetric(vertical: 24.h);
  static EdgeInsets get vertic_28 => EdgeInsets.symmetric(vertical: 28.h);
  static EdgeInsets get vertic_29 => EdgeInsets.symmetric(vertical: 29.h);
  static EdgeInsets get vertic_8 => EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets get vertic_6 => EdgeInsets.symmetric(vertical: 6.h);
  static EdgeInsets get vertic_4 => EdgeInsets.symmetric(vertical: 4.h);
  static EdgeInsets get vertic_2 => EdgeInsets.symmetric(vertical: 2.h);

  //! speciffics
  static EdgeInsets get horiz16_vertic12 =>
      horiz_16.copyWith(bottom: 12.h, top: 12.h);
  static EdgeInsets get horiz16_vertic18 =>
      horiz_16.copyWith(bottom: 18.h, top: 18.h);
  static EdgeInsets get horiz16_vertic24 =>
      horiz_16.copyWith(bottom: 24.h, top: 24.h);
  static EdgeInsets get horiz16_botto10 => horiz_16.copyWith(bottom: 10.h);
  static EdgeInsets get horiz16_botto20 => horiz_16.copyWith(bottom: 20.h);
  static EdgeInsets get horiz10_vertic5 =>
      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h);
  static EdgeInsets get horiz56_vertic70 =>
      EdgeInsets.symmetric(horizontal: 56.w, vertical: 70.h);
  static EdgeInsets get horiz12_vertic17 =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h);
  static EdgeInsets get top16_bottom24 => vertic_16.copyWith(bottom: 24.h);
  static EdgeInsets get top15_bottom19 =>
      EdgeInsets.only(top: 15.h, bottom: 19.h);
  static EdgeInsets get bottom24_top16 =>
      EdgeInsets.only(bottom: 24.h, top: 16.h);
  static EdgeInsets get left20_right12 =>
      EdgeInsets.only(left: 20.w, right: 12.w);
  static EdgeInsets get bottom12_top20 =>
      EdgeInsets.only(top: 20.h, bottom: 12.h);
  static EdgeInsets get horiz6_vertic3 =>
      EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h);
  static EdgeInsets get horiz_12_vertic17 =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h);
  static EdgeInsets get bottom_35_top27 =>
      EdgeInsets.only(top: 27.h, bottom: 35.h);
  static EdgeInsets get homeVideoTablet => EdgeInsets.only(
        top: 19.h,
        left: 20.w,
        right: 20.w,
      );
  static EdgeInsets get homeVideoMobile => EdgeInsets.only(
        top: 14.h,
        left: 10.w,
        right: 10.w,
      );
}
