// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:event_planr/data/disk/auth/auth_storage.dart' as _i4;
import 'package:event_planr/di/di_module.dart' as _i9;
import 'package:event_planr/domain/auth/auth.dart' as _i7;
import 'package:event_planr/domain/auth/auth_repository.dart' as _i5;
import 'package:event_planr/ui/auth/cubit/auth_cubit.dart' as _i8;
import 'package:event_planr/ui/main/profile/cubit/profile_cubit.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DiModule();
    await gh.singletonAsync<_i3.SharedPreferences>(
      () => diModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.AuthStorage>(
        _i4.AuthStorage(preferences: gh<_i3.SharedPreferences>()));
    gh.singleton<_i5.AuthRepository>(
        _i5.AuthRepository(storage: gh<_i4.AuthStorage>()));
    gh.factory<_i6.ProfileCubit>(
        () => _i6.ProfileCubit(authRepository: gh<_i7.AuthRepository>()));
    gh.factory<_i8.AuthCubit>(
        () => _i8.AuthCubit(authRepository: gh<_i7.AuthRepository>()));
    return this;
  }
}

class _$DiModule extends _i9.DiModule {}
