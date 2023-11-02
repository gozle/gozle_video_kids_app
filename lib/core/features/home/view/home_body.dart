import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/core/features/home/components/home_product_builder.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.controller,
  });
  // зачем ты передаешь этот контроллер
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    // так не делают
    final bloc = context.read<HomeBloc>();

    var previouseState = HomeAPIState.init;

    final topPad = MediaQuery.paddingOf(context).top;

    return Padding(
      padding: EdgeInsets.only(top: topPad + 65.h),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          previouseState = previous.apiState;
          return true;
        },
        builder: (context, state) {
          if (state.apiState == HomeAPIState.error)
            return HomeErrorWidget(
              onTap: () {
                bloc.init();
              },
            );
          // посмотри freezedbloc и не мучайся с этим
          if (state.apiState == HomeAPIState.init) return SizedBox();
          if (state.apiState == HomeAPIState.loading)
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.appred,
            ));
          return RefreshIndicator(
            onRefresh: () async {
              bloc.init(forRefresh: true);
            },
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  HomeProductBuilder(
                    modelList: state.videos,
                  ),
                  AppSpacing.vertical_20.toSliverBox,
                  if (state.apiState == HomeAPIState.loadingMore)
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appred,
                      ),
                    ).toSliver(),
                  if (previouseState == HomeAPIState.errorMore && state.apiState == HomeAPIState.loadingMore)
                    SizedBox(
                      height: 200.h,
                    ).toSliverBox,
                  if (state.apiState == HomeAPIState.errorMore)
                    HomeErrorWidget(onTap: () {
                      bloc.loadMore();
                    }).toSliverBox,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 303.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          SvgPicture.asset(
            AssetsPath.noWiFi,
            height: 92.h,
          ),
          Text(
            // локализация
            'Связь с сервером устанавливалась слишком долго, время ожидания истекло.',
            style: textTheme.tryAgainTitle,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: onTap,
            style: theme.textButtonTheme.style,
            child: Text(
              // локализация
              'Повторить',
              style: TextStyle(
                color: Color(0xFFEE0000),
              ),
            ),
          )
        ],
      ),
    );
  }
}
