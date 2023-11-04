import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class ParentAbilitiesScreen extends StatelessWidget {
  const ParentAbilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.textTheme;
    final l10n = context.l10n;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSpacing.vertical_60,
        Text(
          l10n.parentsAbility,
          style: theme.introductionTitle,
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical_30,
        ClipRRect(
          borderRadius: AppBorderRadiuses.border_15,
          child: Image.asset(
            AssetsPath.parentsAbilitiesImage,
            height: 131.h,
            fit: BoxFit.contain,
          ),
        ),
        AppSpacing.vertical_18,
        SizedBox(
          width: 298.w,
          child: Text(
            l10n.settingsPointer,
            style: theme.introductionSubTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
