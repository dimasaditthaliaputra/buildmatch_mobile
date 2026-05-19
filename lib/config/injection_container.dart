import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Profile Feature Clean Architecture Imports
import '../features/profile/data/datasources/profile_local_data_source.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/setup_profile_usecase.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';

import '../core/network/network_info.dart';

import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

// Roles Feature Clean Architecture Imports
import '../features/auth/data/datasources/roles_local_data_source.dart';
import '../features/auth/data/repositories/roles_repository_impl.dart';
import '../features/auth/domain/repositories/roles_repository.dart';
import '../features/auth/domain/usecases/getdata_roles_usecase.dart';
import '../features/auth/presentation/bloc/roles_bloc.dart';

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

import '../features/contractor/data/datasources/rating_client_local_data_source.dart';
import '../features/contractor/data/repositories/rating_client_repository_impl.dart';
import '../features/contractor/domain/repositories/rating_client_repository.dart';
import '../features/contractor/domain/usecases/get_submit_rating_client.dart';
import '../features/contractor/presentation/bloc/rating_client_bloc.dart';

import '../features/contractor/data/datasources/portofolio_local_data_source.dart';
import '../features/contractor/data/repositories/portofolio_repository_impl.dart';
import '../features/contractor/domain/repositories/portofolio_repository.dart';
import '../features/contractor/domain/usecases/get_portofolio_usecase.dart';
import '../features/contractor/presentation/bloc/portofolio_bloc.dart';

import '../features/contractor/data/datasources/project_contractor_list_datasource.dart';
import '../features/contractor/data/repositories/project_contractor_list_impl.dart';
import '../features/contractor/domain/repositories/project_contractor_list_repository.dart';
import '../features/contractor/domain/usecases/get_all_project.dart';
import '../features/contractor/domain/usecases/get_project_by_status.dart';
import '../features/contractor/presentation/bloc/project_contractor_list_bloc.dart';

import '../features/waiting_approval/data/datasources/waiting_approval_local_data_source.dart';
import '../features/waiting_approval/data/repositories/waiting_approval_repository_impl.dart';
import '../features/waiting_approval/domain/repositories/waiting_approval_repository.dart';
import '../features/waiting_approval/domain/usecases/get_verification_status_usecase.dart';
import '../features/waiting_approval/presentation/bloc/waiting_approval_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Roles Feature
  sl.registerFactory(() => RolesBloc(getRolesDataUseCase: sl()));
  sl.registerLazySingleton(() => GetRolesDataUseCase(sl()));
  sl.registerLazySingleton<RolesRepository>(
    () => RolesRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<RolesLocalDataSource>(
    () => RolesLocalDataSourceImpl(),
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
  initRatingClient();
  initDetailPortofolio();
  initProjectContractorList();
  initProfileSetup();
  initWaitingApproval();
}

void initContractorDashboard() {
  sl.registerFactory(() => ContractorDashboardBloc(getDashboardUseCase: sl()));
  sl.registerLazySingleton(
    () => GetContractorDashboardUseCase(repository: sl()),
  );
  sl.registerLazySingleton<ContractorDashboardRepository>(
    () => ContractorDashboardRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContractorDashboardRemoteDataSource>(
    () => ContractorDashboardRemoteDataSourceImpl(),
  );
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
  sl.registerLazySingleton<PenawaranRepository>(
    () => PenawaranRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<PenawaranRemoteDataSource>(
    () => PenawaranRemoteDataSourceImpl(),
  );
}

void initRatingClient() {
  sl.registerFactory(() => RatingClientBloc(submitRatingClient: sl()));
  sl.registerLazySingleton(() => SubmitRatingClient(sl()));
  sl.registerLazySingleton<RatingClientRepository>(
    () => RatingClientRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RatingClientLocalDataSource>(
    () => RatingClientLocalDataSourceImpl(),
  );
}

void initDetailPortofolio() {
  sl.registerFactory(() => PortofolioBloc(tambahPortofolioUsecase: sl()));
  sl.registerLazySingleton(() => TambahPortofolioUsecase(sl()));
  sl.registerLazySingleton<PortofolioRepository>(
    () => PortofolioRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<PortofolioLocalDataSource>(
    () => PortofolioLocalDataSourceImpl(),
  );
}

void initProjectContractorList() {
  sl.registerFactory(() => ProjectContractorListBloc(getAllProjects: sl(), getProjectsByStatus: sl()));
  sl.registerLazySingleton(() => GetAllProjects(sl()));
  sl.registerLazySingleton(() => GetProjectsByStatus(sl()));
  sl.registerLazySingleton<ProjectContractorListRepository>(
    () => ContractorProjectRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContractorProjectRemoteDataSource>(
    () => ContractorProjectRemoteDataSourceImpl(), 
  );
}

void initProfileSetup() {
  sl.registerFactory(() => ProfileBloc(setupProfileUseCase: sl()));
  sl.registerLazySingleton(() => SetupProfileUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );
}

void initWaitingApproval() {
  sl.registerFactory(
    () => WaitingApprovalBloc(
      getVerificationStatus: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetVerificationStatusUseCase(sl()));
  sl.registerLazySingleton<WaitingApprovalRepository>(
    () => WaitingApprovalRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WaitingApprovalLocalDataSource>(
    () => WaitingApprovalLocalDataSourceImpl(),
  );
}

