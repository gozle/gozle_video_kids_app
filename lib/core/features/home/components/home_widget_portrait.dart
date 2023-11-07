import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/configs/theme/my_text_theme.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/spacer.dart';
import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/shimmer.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';
import 'package:gozle_video_kids_v1/utilities/services/responsive_helper.dart';

class HomeVideoWidget extends StatefulWidget {
  const HomeVideoWidget({
    super.key,
    this.model,
  });
  final HomeVideoModel? model;

  static final _errorImages = [
    AssetsPath.splashA4,
    AssetsPath.splashDreamWorks,
    AssetsPath.splashMasha,
    AssetsPath.splashPixart,
    AssetsPath.splashWalpDisnay,
  ];
  @override
  State<HomeVideoWidget> createState() => _HomeVideoWidgetState();
}

class _HomeVideoWidgetState extends State<HomeVideoWidget> {
  @override
  void initState() {
    context.read<AppCubit>().stream.listen((event) {
      textTheme = AppCalculator.isDarkMode()
          ? MyTextTheme.darkTheme()
          : MyTextTheme.lightTheme();
      setState(() {});
    });
    super.initState();
  }

  late MyTextTheme textTheme = context.textTheme;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final isLoading = model == null;
    return GestureDetector(
      onTap: () {
        if (isLoading || appRouter.location == AppRoutes.videoScreen) return;
        context.push(AppRoutes.videoScreen, extra: model);
      },
      child: Padding(
        padding: AppPaddings.horiz_6.copyWith(top: 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: AppBorderRadiuses.border_15,
                      child: isLoading
                          ? MyShimerPlaceHolder(
                              height: double.infinity,
                              width: double.infinity,
                            )
                          : CachedNetworkImage(
                              imageUrl: model.image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  HomeVideoWidget
                                      ._errorImages[Random().nextInt(5)],
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) {
                                return MyShimerPlaceHolder();
                              },
                            ),
                    ),
                  ),
                ),
                if (!isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.black28,
                          borderRadius: AppBorderRadiuses.border_5,
                        ),
                        margin: ResponsiveHelper.solve(
                            EdgeInsets.only(bottom: 11.h, right: 15.w),
                            EdgeInsets.only(bottom: 5.h, right: 10.w)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 11.w, vertical: 4.h),
                        child: Text(
                          model!.duration.durationFromSeconds.toTime,
                          style: textTheme.homeVideoWigetDuration,
                        ),
                      ),
                    ],
                  )
              ],
            ),
            AppSpacing.vertical_12,
            isLoading
                ? MyShimerPlaceHolder(
                    radius: AppBorderRadiuses.border_6,
                    width: double.infinity,
                    margin: AppPaddings.bottom_4,
                    height: AppCalculator.getTextHeight(
                      textTheme.homeVideoWidgetLabel.fontSize!,
                    ),
                  )
                : Text(
                    model!.title,
                    style: textTheme.homeVideoWidgetLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ],
        ),
      ),
    );
  }
}
