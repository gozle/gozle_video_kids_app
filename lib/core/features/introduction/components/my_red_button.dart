import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class MyRedButton extends StatelessWidget {
  const MyRedButton({
    super.key,
    required this.onTap,
    this.width,
  });

  final double? width;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return Material(
      color: AppColors.appred,
      borderRadius: AppBorderRadiuses.border_10,
      child: InkWell(
        borderRadius: AppBorderRadiuses.border_10,
        onTap: onTap,
        child: Container(
          width: width,
          //385.w
          padding: AppPaddings.vertic_12,
          alignment: Alignment.center,
          child: Text(
            l10n.start,
            //! implement it
            style: textTheme.myRedButton,
          ),
        ),
      ),
    );
  }
}
