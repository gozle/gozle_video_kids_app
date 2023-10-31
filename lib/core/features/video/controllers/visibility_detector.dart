import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';

class VisibilityDetector extends StatelessWidget {
  const VisibilityDetector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();
    return GestureDetector(
      onTap: () {
        cubit.switchVisibility();
      },
      child: BlocBuilder<VideoCubit, VideoState>(
        bloc: cubit,
        builder: (context, state) {
          return AnimatedOpacity(
            duration: AppDurations.duration_150ms,
            opacity: state.isVisible && !state.isLocked ? 1 : 0,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
            ),
          );
        },
      ),
    );
  }
}
