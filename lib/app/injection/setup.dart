import 'package:get_it/get_it.dart';
import 'package:gozle_video_kids_v1/app/injection/setup.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

// @InjectableInit()
// GetIt configureDependencies(GetIt getIt) => $initGetIt(getIt);

@InjectableInit()
GetIt configureDependencies(GetIt getIt) => getIt.init();
