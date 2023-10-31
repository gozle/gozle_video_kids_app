// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     SystemOverlayUiHelper.setBlueStatusBar();
//     Future.delayed(AppDurations.duration_2s, () {
//       localStorage.isFirstTime().then((value) {
//         if (value) {
//           context.go(AppRoutes.introductionScreen);
//           return;
//         }
//         context.go(AppRoutes.home);
//       });
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   final localStorage = getIt<LocalStorage>() as LocalStorageImpl;

//   @override
//   Widget build(BuildContext context) {
//     final size = AppSpacing.deviceSize..log();
//     final textStyle = context.theme.textTheme.bodyMedium!
//         .copyWith(fontSize: size.width > 600 ? 35.sp : null);
//     final imageHeight = AppSpacing.getTextHeight(textStyle.fontSize!) + 30.sp;
//     return SafeArea(
//       bottom: false,
//       child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AssetsPath.splashScreen),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: AppColors.splashFilter,
//           body: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   AssetsPath.gozleIconRed,
//                   height: imageHeight,
//                   width: imageHeight,
//                 ),
//                 AppSpacing.horizontal_5,
//                 Text(
//                   'Gozle Video Kids',
//                   style: textStyle,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
