import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/configs/theme/my_text_theme.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';

class AppTheme {
  final lightTheme = ThemeData(
    //!
    primaryColor: AppColors.appred,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.appred.withOpacity(0.2)),
        textStyle: MaterialStateTextStyle.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 23.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFFEE0000),
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
            AppPaddings.vertic_10.add(AppPaddings.horiz_10)),
        alignment: Alignment.center,
        backgroundColor: MaterialStatePropertyAll(AppColors.appred),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: AppBorderRadiuses.border_6,
          ),
        ),
      ),
    ),
    //!
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF6F6F6),
    fontFamily: GoogleFonts.inter().fontFamily,
    //!
    popupMenuTheme: PopupMenuThemeData(
      labelTextStyle: MaterialStatePropertyAll(
        GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
      color: AppColors.grey,
    ),
    extensions: [
      MyTextTheme.lightTheme(),
    ],
  );
}
