import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage.dart';
import 'package:gozle_video_kids_v1/utilities/constants/enums.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocalStorage)
class LocalStorageImpl extends LocalStorage {
  final client = new FlutterSecureStorage();

  Future<String> getLang() async {
    return await client.read(key: LocalKeys.lang.name) ?? 'ru';
  }

  Future<ThemeMode> getThemeMode() async {
    final theme = await client.read(key: LocalKeys.themeMode.name);
    if (theme != null) {
      return ThemeMode.values.firstWhere((element) => element.name == theme);
    }
    return ThemeMode.system;
  }

  void saveLang(String lang) async {
    await client.write(key: LocalKeys.lang.name, value: lang);
  }

  void saveThemeMode(ThemeMode mode) async {
    await client.write(key: LocalKeys.themeMode.name, value: mode.name);
  }

  Future<bool> isFirstTime() async {
    final val = await client
        .read(key: LocalKeys.isFirstTime.name)
        .then((value) => bool.parse(value ?? 'true'));
    return val;
  }

  Future<void> switchFirstTiem() async {
    await client.write(key: LocalKeys.isFirstTime.name, value: 'false');
  }
}
