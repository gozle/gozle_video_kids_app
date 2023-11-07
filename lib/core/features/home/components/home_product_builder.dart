import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gozle_video_kids_v1/core/features/home/components/home_widget_portrait.dart';
import 'package:gozle_video_kids_v1/core/models/home_video_model/home_video_model.dart';
import 'package:gozle_video_kids_v1/utilities/services/responsive_helper.dart';

class HomeProductBuilder extends StatelessWidget {
  const HomeProductBuilder({super.key, this.modelList});
  final List<HomeVideoModel>? modelList;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      sliver: SliverDynamicHeightGridView(
        crossAxisCount: ResponsiveHelper.solve(3, 4),
        itemCount: modelList?.length ?? 99,
        builder: (context, index) {
          return HomeVideoWidget(
            model: modelList?[index],
          );
        },
      ),
    );
  }
}
