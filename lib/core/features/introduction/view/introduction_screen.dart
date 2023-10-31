import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/app/injection/setup.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage_impl.dart';
import 'package:gozle_video_kids_v1/core/features/components/change_language_widget.dart';
import 'package:gozle_video_kids_v1/core/features/introduction/components/my_red_button.dart';
import 'package:gozle_video_kids_v1/core/features/introduction/view/get_birth_date/get_birth_date_screen.dart';
import 'package:gozle_video_kids_v1/core/features/introduction/view/parent_abilities_screen/parent_abilities_screen.dart';
import 'package:gozle_video_kids_v1/core/features/introduction/view/welcome_screen/welcome_screen.dart';
import 'package:gozle_video_kids_v1/utilities/constants/colors.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:gozle_video_kids_v1/utilities/services/system_chrome_helper/system_chrome_helper.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({
    super.key,
  });
  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    SystemChromeHelper.changeStatusBarColor(AppColors.transparent);
    super.initState();
  }

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    // final textTheme = context.textTheme;
    // final l10n = context.l10n;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appred,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 179.w, vertical: 144.h),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(35.r),
        ),
        padding: AppPaddings.bottom_35_top27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChangeLanguageWidget(),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    WelcomeScreen(),
                    GetBirthDateScreen(),
                    ParentAbilitiesScreen(),
                  ],
                ),
              ),
            ),
            MyRedButton(
              width: 385.w,
              onTap: () {
                controller.page..log();
                if (controller.page == 2) {
                  final localStorage =
                      getIt<LocalStorage>() as LocalStorageImpl;
                  localStorage.switchFirstTiem();
                  context.pushReplacement(AppRoutes.home);
                  'end'.log();
                  return;
                }
                controller.nextPage(
                  duration: AppDurations.duration_250ms,
                  curve: Curves.linear,
                );
                'tap'.log();
              },
            )
          ],
        ),
      ),
    );
  }
}
