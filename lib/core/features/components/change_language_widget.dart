import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({super.key});

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  final values = {
    'tr': 'Tm',
    'ru': 'Ru',
  };

  @override
  Widget build(BuildContext context) {
    final textStyle = context.theme.popupMenuTheme.textStyle;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          child: Container(
            height: 39.sp,
            width: 39.sp,
            padding: AppPaddings.all_10,
            margin: AppPaddings.horiz_37,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.theme.popupMenuTheme.color!,
                width: 2.sp,
              ),
              borderRadius: AppBorderRadiuses.border_15,
            ),
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                values[state.lang]!,
                style: textStyle,
              ),
            ),
          ),
          itemBuilder: (context) {
            return values.entries.map((item) {
              final isSelected = item.key == state.lang;
              return PopupMenuItem(
                height: double.minPositive,
                padding: AppPaddings.all_12,
                child: Text(
                  item.value,
                  style: textStyle!.copyWith(
                    // todo dark theme flexibility
                    color: isSelected ? AppColors.appred : Colors.black,
                  ),
                ),
                onTap: () {
                  if (isSelected) return;
                  context.read<AppCubit>().changeLang(item.key);
                },
              );
            }).toList();
          },
        );
      },
    );
  }
}
