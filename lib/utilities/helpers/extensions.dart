import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gozle_video_kids_v1/app/cubit/app_cubit.dart';
import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';
import 'dart:developer' as devtools show log;

import 'package:gozle_video_kids_v1/utilities/configs/router/router.dart';
import 'package:gozle_video_kids_v1/utilities/configs/theme/my_text_theme.dart';

extension Log on Object? {
  void log({StackTrace? stackTrace, String? message}) => devtools.log(
        '${message != null ? message : ''} ${this.toString()}  ',
        time: DateTime.now(),
        stackTrace: stackTrace,
      );
}

extension Responsive on Object {}

extension SliverExtentions on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);
}

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  MyTextTheme get textTheme => Theme.of(this).extension<MyTextTheme>()!;

  // Widget responsiveResolve({required Widget phone, required Widget tablet}) {
  // switch (AppCalculator.deviceSize.width) {
  //   case <= 600:
  //     'this is phone'.log();
  //     return phone;
  //   case >= 600:
  //     'this is tablet'.log();
  //     return tablet;
  //   default:
  //     return tablet;
  // }
  // }
}

extension DurationExtensions on Duration {
  String get toTime {
    final formattedVal = this.toString().split('.').first;
    final data = formattedVal.split(':');
    if (data.first.toInt == 0) data.removeAt(0);

    return data.join(':');
  }
}

extension IntExtensions on int? {
  Duration get durationFromSeconds => Duration(seconds: this ?? 5 * 60);
}

extension ToInt on String {
  int get toInt => int.parse(this);
  String get toRouteName => replaceAll('/', '');
}

extension MaterialResolve on Color {
  MaterialStateColor get colorSolve =>
      MaterialStateColor.resolveWith((states) => this);
}

extension ToSliverBox on Widget {
  SliverToBoxAdapter get toSliverBox => SliverToBoxAdapter(child: this);
  SingleChildScrollView get toSingleChildScrollView => SingleChildScrollView(
        child: this,
      );
}

extension MapExtension on Map<String, dynamic>? {
  Map<String, dynamic>? addLang() {
    if (appRouter.routerDelegate.currentConfiguration.isEmpty) return this;

    final lang = appRouter.currentContext.read<AppCubit>().state.lang;
    this?.addAll({'lang': lang == 'tr' ? 'tk' : lang});

    return this;
  }
}

extension GetNavContext on GoRouter {
  BuildContext get currentContext =>
      routerDelegate.navigatorKey.currentContext!;
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

extension DynamicExtension on dynamic {
  dynamic get toMaterialStateProperty {
    final type = this.runtimeType;
    return MaterialStateProperty.resolveWith((states) => this);
  }
}
