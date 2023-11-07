import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/app/test_screen.dart';
import 'package:gozle_video_kids_v1/core/features/home/bloc/home_bloc.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';
import 'package:gozle_video_kids_v1/utilities/configs/theme/theme.dart';
import 'package:gozle_video_kids_v1/utilities/services/responsive_helper.dart';

class GozleVideoKidsApp extends StatefulWidget {
  const GozleVideoKidsApp({super.key});

  @override
  State<GozleVideoKidsApp> createState() => _GozleVideoKidsAppState();
}

class _GozleVideoKidsAppState extends State<GozleVideoKidsApp> {
  //! Refactoring, dark theme
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: AppCalculator.phoneDesingeSize,
      fontSizeResolver: (fontSize, instance) =>
          AppCalculator.myFontSizeResolver(fontSize, instance),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..init()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final themeInstance = AppTheme();
          return MaterialApp.router(
            title: 'Gozle Video Kids',
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: appRouter,
            locale: Locale(state.lang),
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: themeInstance.lightTheme,
            darkTheme: themeInstance.darkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            builder: (context, child) {
              return Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) {
                      AppCalculator.init(context);
                      ResponsiveHelper.init(context);
                      // return TestScreen();
                      return child!;
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
