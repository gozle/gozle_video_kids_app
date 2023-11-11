import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// не забывай удалять ненужные импорты
import 'package:gozle_video_kids_v1/app/injection/setup.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage_impl.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';

part 'app_state.dart';

// друг посмотри пожалуйста clean code архитектуру
// как и что в папках должно лежать

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(AppState(
          state: APIState.init,
        ));
  final _localStorage = getIt<LocalStorage>() as LocalStorageImpl;

  void changeLang(String lang) {
    if (lang == state.lang) return;
    emit(
      AppState(
        state: APIState.succses,
        lang: lang,
        themeMode: state.themeMode,
      ),
    );
    _localStorage.saveLang(lang);
  }

  void changeThemeMode(ThemeMode mode) {
    if (mode == state.themeMode) return;
    emit(
      AppState(
        state: APIState.succses,
        lang: state.lang,
        themeMode: mode,
      ),
    );
    _localStorage.saveThemeMode(mode);
  }

  Future<void> init() async {
    emit(AppState(state: APIState.loading));
    final lang = await _localStorage.getLang();
    final themeMode = await _localStorage.getThemeMode();
    final autoPlay = await _localStorage.getAutoPlay();
    emit(
      AppState(
        lang: lang,
        themeMode: (themeMode)..log(message: 'Current theme mode'),
        state: APIState.succses,
        autoPlayEnable: autoPlay,
      ),
    );
  }

  Future<void> changeAutoPlayEnable() async {
    final isEnable = !state.autoPlayEnable;
    emit(
      AppState(
        state: APIState.succses,
        lang: state.lang,
        themeMode: state.themeMode,
        autoPlayEnable: isEnable,
      ),
    );
    _localStorage.saveAutoPlayEnable(isEnable);
  }
}

// dart run build_runner build --delete-conflicting-outputs
