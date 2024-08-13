

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:skin_care/src/features/auth/domain/usecase/update_user.dart';
import 'package:skin_care/src/features/auth/presentation/providers/user_provider.dart';
import 'package:skin_care/src/features/skincare/data/data_source/remote/skincare_remote_data_source.dart';
import 'package:skin_care/src/features/skincare/data/repo_impl/skincare_repo_impl.dart';
import 'package:skin_care/src/features/skincare/domain/usecase/add_streak.dart';
import 'package:skin_care/src/features/skincare/domain/usecase/get_streak.dart';
import 'package:skin_care/src/features/skincare/domain/usecase/get_streaks.dart';
import 'package:skin_care/src/features/skincare/domain/usecase/update_streak.dart';
import 'package:skin_care/src/features/skincare/domain/usecase/upload_photos.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/get_skincare_provider.dart';
import 'package:skin_care/src/features/skincare/presentation/providers/add_skincare_provider.dart';

import '../features/auth/data/data_source/remote/auth_remote_data_source.dart';
import '../features/auth/data/repository_impl/auth_repo_impl.dart';
import '../features/auth/domain/usecase/get_user.dart';
import '../features/auth/domain/usecase/login.dart';
import '../features/auth/domain/usecase/signup.dart';
import '../features/auth/presentation/providers/auth_provider.dart';

final GetIt locator = GetIt.instance;

void initDependency() {
  FirebaseAuth instance = FirebaseAuth.instance;

  locator.registerLazySingleton(() => instance);
  _initAuth();
  _initSkinCare();
}

void _initAuth() {
  locator.registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<AuthRepositoryImpl>(
          () => (AuthRepositoryImpl(locator<AuthRemoteDataSource>())));
  locator.registerLazySingleton<LoginUseCase>(
          () => LoginUseCase(locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<SignUpUseCase>(
          () => SignUpUseCase(locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<GetUserUseCase>(
          () => GetUserUseCase(locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<UpdateUserUseCase>(()=>UpdateUserUseCase(locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<AuthNotifier>(
          () => AuthNotifier(locator<LoginUseCase>(), locator<SignUpUseCase>(), locator<GetUserUseCase>()));
  locator.registerLazySingleton<UserNotifier>(
      () => UserNotifier(locator<GetUserUseCase>())
  );

}

_initSkinCare() {
  locator.registerFactory<StreakRemoteDataSource>(
      () => StreakRemoteDataSourceImpl()
  );
  locator.registerLazySingleton<SkinCareRepoImpl>(
      () => SkinCareRepoImpl(locator<StreakRemoteDataSource>())
  );
  locator.registerLazySingleton(()=>AddStreakUseCase(locator<SkinCareRepoImpl>()));
  locator.registerLazySingleton(()=>GetStreakUseCase(locator<SkinCareRepoImpl>()));
  locator.registerLazySingleton(()=>GetStreaksUseCase(locator<SkinCareRepoImpl>()));
  locator.registerLazySingleton(()=>UpdateStreakUseCase(locator<SkinCareRepoImpl>()));
  locator.registerLazySingleton(()=>UploadPhotosUseCase(locator<SkinCareRepoImpl>()));

  locator.registerLazySingleton<AddSkincareStreakStateNotifier>(
      () => AddSkincareStreakStateNotifier(addStreakUseCase: locator(), getStreakUseCase: locator<GetStreakUseCase>(), updateStreakUseCase: locator(), uploadPhotosUseCase: locator(),updateUserUseCase: locator())
  );

  locator.registerLazySingleton<GetStreakStateNotifier>(
      () => GetStreakStateNotifier(locator<GetStreakUseCase>())
  );

}

