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
  @override
  void initState() {
    bloc = context.read<HomeBloc>()..log();
    scrollController.addListener(listener);
    super.initState();
  }

  late HomeBloc bloc;

  // для этих целей существует BlocListener
  void listener() {
    if (scrollController.position.pixels >=
            (scrollController.position.maxScrollExtent - 30.h) &&
        scrollController.position.isScrollingNotifier.value) {
      final state = bloc.state;
      if (state.apiState != HomeAPIState.succses || state.isLastPage) {
        return;
      }
      bloc.loadMore();
    }
  }

  final scrollController = ScrollController();
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
              HomeBody(controller: scrollController),
              const HomeAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
