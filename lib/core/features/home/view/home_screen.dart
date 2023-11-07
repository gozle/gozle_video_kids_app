import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/home/view/home_app_bar.dart';
import 'package:gozle_video_kids_v1/core/features/home/view/home_body.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final topPad = MediaQuery.paddingOf(context).top;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: topPad),
      // safe are
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          // this cuose of after "VideoScreen" dispose status bar height constantly changes
          body: Stack(
            children: [
              const HomeBody(),
              const HomeAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
