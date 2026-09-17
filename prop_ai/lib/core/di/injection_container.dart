import 'package:get_it/get_it.dart';
import 'package:prop_ai/Features/location/data/datasources/location_local_data_source.dart';
import 'package:prop_ai/Features/location/data/repositories/location_repository_impl.dart';
import 'package:prop_ai/Features/location/domain/repositories/location_repository.dart';
import 'package:prop_ai/Features/location/presentation/cubit/location_cubit.dart';

import 'package:prop_ai/Features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:prop_ai/Features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:prop_ai/Features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:prop_ai/Features/onboarding/presentation/cubit/onboarding_cubit.dart';

import 'package:prop_ai/Features/home/data/datasources/home_local_data_source.dart';
import 'package:prop_ai/Features/home/data/repositories/home_repository_impl.dart';
import 'package:prop_ai/Features/home/domain/repositories/home_repository.dart';
import 'package:prop_ai/Features/home/domain/usecase/get_home_data.dart';
import 'package:prop_ai/Features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    OnboardingLocalDataSourceImpl.new,
  );

  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: getIt()),
  );

  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(repository: getIt<OnboardingRepository>()),
  );

  // =========================
  // Location
  // =========================

  // Data source
  getIt.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSource(),
  );

  // Repository
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      localDataSource: getIt<LocationLocalDataSource>(),
    ),
  );

  // Cubit
  getIt.registerFactory<LocationCubit>(
    () => LocationCubit(repository: getIt<LocationRepository>()),
  );

  // =========================
  // Home
  // =========================

  getIt.registerLazySingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl.new);

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: getIt<HomeLocalDataSource>()),
  );

  getIt.registerLazySingleton<GetHomeData>(
    () => GetHomeData(repository: getIt<HomeRepository>()),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getHomeData: getIt<GetHomeData>()),
  );
}
