// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
// import 'package:gozle_video_kids_v1/utilities/constants/assets_path.dart';
// import 'package:gozle_video_kids_v1/utilities/constants/vars/borders.dart';
// import 'package:gozle_video_kids_v1/utilities/constants/vars/durations.dart';
// import 'package:gozle_video_kids_v1/utilities/constants/vars/paddings.dart';
// import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
// import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
// import 'package:lottie/lottie.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen>
//     with SingleTickerProviderStateMixin {
//   late final animController = AnimationController(
//     vsync: this,
//     duration: AppDurations.duration_500ms,
//   );

//   bool isDarkTheme = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 148, 201, 245),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: double.infinity),
//           InkWell(
//             borderRadius: AppBorderRadiuses.border_50,
//             overlayColor:
//                 MaterialStateColor.resolveWith((states) => Colors.black38),
//             splashColor: Colors.black38,
//             onTap: () {
//               setState(() {
//                 isDarkTheme = !isDarkTheme;
//               });
//             },
//             child: ToggleThemeIcon(),
//           ),
//           SizedBox(
//             width: double.infinity,
//           ),
//         ],
//       ),
//     );
//   }
// }

