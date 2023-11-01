import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/progress_bar.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/video_controller.dart';
import 'package:gozle_video_kids_v1/core/features/video/controllers/visibility_detector.dart';
import 'package:gozle_video_kids_v1/core/features/video/cubit/video_cubit.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/src/controls/controls.dart';
import 'package:gozle_video_kids_v1/utilities/world_video_player/world_video_player.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:wakelock/wakelock.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
    required this.model,
  });

  final HomeVideoModel model;

  static final val = ValueNotifier<HomeVideoModel?>(null);
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    VideoScreen.val.value = widget.model;
    StatusBarControl.setHidden(true);
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    cubit.dispose();
    super.dispose();
  }

  late final model = widget.model;
  late VideoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoCubit(model),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          cubit = context.read<VideoCubit>();
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              alignment: Alignment.center,
              children: [
                WorldVideoPlayer(
                  expansionHeight: 9,
                  expansionWidth: 16,
                  controller: cubit.videoController,
                  controlsType: ControlsType.CUSTOM,
                  customControls: SizedBox(),
                ),
                VisibilityDetector(),
                GozleVideoKidsControllers(),
                MyVideoProggresBar(),
              ],
            ),
          );
        },
      ),
    );
  }
}
