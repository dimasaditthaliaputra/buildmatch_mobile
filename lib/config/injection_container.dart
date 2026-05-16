import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../core/network/network_info.dart';

import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

import '../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../features/onboarding/domain/usecases/get_onboarding_pages.dart';
import '../features/onboarding/presentation/bloc/onboarding_bloc.dart';

import '../features/contractor/data/datasources/project_datasource.dart';
import '../features/contractor/data/repositories/project_repository_impl.dart';
import '../features/contractor/domain/repositories/project_repository.dart';
import '../features/contractor/domain/usecases/get_projects.dart';
import '../features/contractor/presentation/bloc/project_bloc.dart';
import '../features/contractor/data/repositories/contractor_dashboard_repository_impl.dart';
import '../features/contractor/domain/repositories/contractor_dashboard_repository.dart';
import '../features/contractor/domain/usecases/get_contractor_dashboard_usecase.dart';
import '../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';
import '../features/contractor/data/datasources/contractor_dashboard_remote_datasource.dart';

import '../features/contractor/domain/usecases/get_penawaran_usecase.dart';
import '../features/contractor/domain/repositories/penawaran_repository.dart';
import '../features/contractor/data/repositories/penawaran_repository_impl.dart';
import '../features/contractor/presentation/bloc/penawaran_bloc.dart';
import '../features/contractor/data/datasources/penawaran_remote_datasource.dart';

import '../features/contractor/data/datasources/project_detail_local_data_source.dart';
import '../features/contractor/data/repositories/project_detail_repository_impl.dart';
import '../features/contractor/domain/repositories/project_detail_repository.dart';
import '../features/contractor/domain/usecases/get_project_detail.dart';
import '../features/contractor/presentation/bloc/project_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerFactory(() => OnboardingBloc(sl()));
  sl.registerLazySingleton(() => GetOnboardingPages(sl()));
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());

  initContractorDashboard();
  initContractorProjectDetail();
  initContractorProject();
}

void initContractorDashboard() {
  sl.registerFactory(() => ContractorDashboardBloc(getDashboardUseCase: sl()));
  sl.registerLazySingleton(() => GetContractorDashboardUseCase(repository: sl()));
  sl.registerLazySingleton<ContractorDashboardRepository>(() => ContractorDashboardRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ContractorDashboardRemoteDataSource>(() => ContractorDashboardRemoteDataSourceImpl());
}

void initContractorProjectDetail() {
  sl.registerFactory(() => ProjectDetailBloc(sl()));
  sl.registerLazySingleton(() => GetProjectDetail(sl()));
  sl.registerLazySingleton<ProjectDetailRepository>(
    () => ProjectDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProjectDetailLocalDataSource>(
    () => ProjectDetailLocalDataSourceImpl(),
  );
}

void initContractorProject() {
  sl.registerFactory(() => ProjectBloc(sl()));
  sl.registerLazySingleton(() => GetProjects(sl()));
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProjectLocalDataSource>(
    () => ProjectLocalDataSourceImpl(),
  );

  initPenawaran();
}

void initPenawaran() {
  sl.registerFactory(() => PenawaranBloc(getPenawaranUseCase: sl()));
  sl.registerLazySingleton(() => GetPenawaranUsecase(sl()));
  sl.registerLazySingleton<PenawaranRepository>(() => PenawaranRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));
  sl.registerLazySingleton<PenawaranRemoteDataSource>(() => PenawaranRemoteDataSourceImpl());
}
