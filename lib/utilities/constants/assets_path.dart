import 'package:gozle_video_kids_v1/utilities/services/calculator.dart';

class AssetsPath {
  static const splashScreen = 'assets/images/splash.webp';
  static const gozleIcon = 'assets/icons/gozle_icon.svg';
  static const gozleIconRed = 'assets/icons/gozle_icon_red.svg';
  static const welcomeScreenImage = 'assets/images/welcome_image.png';
  static const parentsAbilitiesImage =
      'assets/images/parents_abilities_image.png';
  static const getBirthDateImage = 'assets/images/get_birth_date_image.png';
  static String get fullLogo {
    /// reversed cause names are wrong
    return !AppCalculator.isDarkMode()
        ? 'assets/images/full_logo_dark.svg'
        : 'assets/images/full_logo_light.svg';
  }

  static const searchIcon = 'assets/icons/search.svg';
  static const lockIcon = 'assets/icons/lock_icon.svg';
  static const unlockIcon = 'assets/icons/un_lock_icon.svg';

  static const popIcon = 'assets/icons/pop.svg';
  static const lockLottieIcon = 'assets/icons/lotties/lock_icon_white.json';
  static const noWiFi = 'assets/icons/errors/no_wi-fi.svg';

  //! Splash screen images
  static const splashWalpDisnay =
      'assets/images/splash_images/walp_disnay.webp';
  static const splashPixart = 'assets/images/splash_images/pixart.webp';
  static const splashMasha = 'assets/images/splash_images/masha_medved.webp';
  static const splashDreamWorks =
      'assets/images/splash_images/dream_works.webp';
  static const splashCheburashka =
      'assets/images/splash_images/cheburashka.webp';
  static const splashA4 = 'assets/images/splash_images/a4.webp';

  //! lotties
  static const lightThemeLottie = 'assets/icons/lotties/light_mode.json';
  static const darkThemeLottie = 'assets/icons/lotties/dark_mode.json';
}
