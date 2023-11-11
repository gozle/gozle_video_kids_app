import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/ink_wrapper.dart';

class AutoPlayCheckBox extends StatefulWidget {
  const AutoPlayCheckBox({super.key});

  @override
  State<AutoPlayCheckBox> createState() => _AutoPlayCheckBoxState();
}

class _AutoPlayCheckBoxState extends State<AutoPlayCheckBox>
    with SingleTickerProviderStateMixin {
  late final animController = AnimationController(
    vsync: this,
    duration: AppDurations.duration_250ms,
  );
  @override
  void initState() {
    if (!appCubit.state.autoPlayEnable) {
      animController.forward();
    }
    super.initState();
  }

  late final appCubit = context.read<AppCubit>();
  @override
  Widget build(BuildContext context) {
    final isAutoPlayed = appCubit.state.autoPlayEnable;
    return InkWell(
      borderRadius: AppBorderRadiuses.border_10,
      onTap: () {
        final videoCubit = context.read<VideoCubit>();
        if (videoCubit.state.isLocked) return;
        if (!videoCubit.state.isVisible) {
          videoCubit.switchVisibility();
          return;
        }
        appCubit.changeAutoPlayEnable();
        if (!appCubit.state.autoPlayEnable) {
          animController.forward();
        } else {
          animController.reverse();
        }
        setState(() {});
      },
      child: Container(
        margin: AppPaddings.all_10,
        width: 47.w,
        height: 28.h,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadiuses.border_15,
                color: Color(0xFFD9D9D9),
              ),
            ),
            AnimatedAlign(
              alignment:
                  isAutoPlayed ? Alignment.centerRight : Alignment.centerLeft,
              duration: AppDurations.duration_250ms,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                height: double.infinity,
                padding: EdgeInsets.all(2.sp),
                child: FittedBox(
                  alignment: Alignment.center,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: animController,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
