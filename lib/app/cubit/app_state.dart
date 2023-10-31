part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.lang = 'ru',
    this.themeMode = ThemeMode.system,
    required this.state,
  });
  final APIState state;
  final String lang;
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode, lang, state];
}
