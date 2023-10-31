import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final firstTheme = context.textTheme.logoStyle;
    final secondTheme = textTheme.logoStyle
        .copyWith(fontFamily: GoogleFonts.ubuntu().fontFamily);
    final third = GoogleFonts.urbanist(
      fontSize: 40.sp,
      color: Colors.white,
    );
    final fourth = TextStyle(
      fontSize: 40.sp,
      color: Colors.white,
    );
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppCalculator.topPad,
            ),
            AppSpacing.vertical_10,
            Text(
              'it self: ${firstTheme} \nfirt:$firstTheme',
              style: firstTheme,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
            ),
            Text(
              'copy: $secondTheme',
              style: secondTheme,
            ),
            AppSpacing.vertical_30,
            Text(
              'JustText with gf: ${third} ',
              style: third,
            ),
            AppSpacing.vertical_30,
            Text(
              'JustText ${fourth} ',
              style: fourth,
            ),
            Text(
              'firstParams: ${firstTheme.fontSize} ${firstTheme.fontFamily} ',
              style: fourth,
            )
          ],
        ),
      ),
    );
  }
}
