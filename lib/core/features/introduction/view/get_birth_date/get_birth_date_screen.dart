import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class GetBirthDateScreen extends StatelessWidget {
  const GetBirthDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;
    final l10n = context.l10n;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AssetsPath.getBirthDateImage,
          height: 154.h,
          fit: BoxFit.contain,
        ),
        AppSpacing.vertical_35,
        Text(
          '${l10n.hello}!',
          style: theme.introductionTitle,
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical_12,
        SizedBox(
          width: 298.w,
          child: Text(
            l10n.getBirthDate,
            style: theme.introductionSubTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(flex: 6, child: SizedBox()),
      ],
    );
  }
}
