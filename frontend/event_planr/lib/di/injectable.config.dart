// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:event_planr/data/disk/auth/auth_storage.dart' as _i7;
import 'package:event_planr/di/di_module.dart' as _i13;
import 'package:event_planr/domain/auth/auth.dart' as _i11;
import 'package:event_planr/domain/auth/auth_repository.dart' as _i9;
import 'package:event_planr/domain/event/event.dart' as _i5;
import 'package:event_planr/domain/event/event_repository.dart' as _i3;
import 'package:event_planr/ui/auth/cubit/auth_cubit.dart' as _i12;
import 'package:event_planr/ui/main/event/cubit/event_cubit.dart' as _i8;
import 'package:event_planr/ui/main/explore/cubit/explore_cubit.dart' as _i4;
import 'package:event_planr/ui/main/profile/cubit/profile_cubit.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

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
    gh.singleton<_i3.EventRepository>(_i3.EventRepository());
    gh.factory<_i4.ExploreCubit>(
        () => _i4.ExploreCubit(eventRepository: gh<_i5.EventRepository>()));
    await gh.singletonAsync<_i6.SharedPreferences>(
      () => diModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i7.AuthStorage>(
        _i7.AuthStorage(preferences: gh<_i6.SharedPreferences>()));
    gh.factory<_i8.EventCubit>(
        () => _i8.EventCubit(eventRepository: gh<_i5.EventRepository>()));
    gh.singleton<_i9.AuthRepository>(
        _i9.AuthRepository(storage: gh<_i7.AuthStorage>()));
    gh.factory<_i10.ProfileCubit>(
        () => _i10.ProfileCubit(authRepository: gh<_i11.AuthRepository>()));
    gh.factory<_i12.AuthCubit>(
        () => _i12.AuthCubit(authRepository: gh<_i11.AuthRepository>()));
    return this;
  }
}

class _$DiModule extends _i13.DiModule {}
