// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage.dart'
    as _i5;
import 'package:gozle_video_kids_v1/core/data/local_data/local_storage_impl.dart'
    as _i6;
import 'package:gozle_video_kids_v1/core/repositories/home_repo/home_repo.dart'
    as _i3;
import 'package:gozle_video_kids_v1/core/repositories/home_repo/home_repo_impl.dart'
    as _i4;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.HomeRepo>(() => _i4.HomeRepoImpl());
    gh.factory<_i5.LocalStorage>(() => _i6.LocalStorageImpl());
    return this;
  }
}
