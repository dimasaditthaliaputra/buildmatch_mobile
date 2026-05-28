import 'package:buildmatch_mobile/features/architect/data/datasources/architect_milestone_local_data_source.dart';
import 'package:buildmatch_mobile/features/architect/data/datasources/architect_project_detail_local_data_source.dart';
import 'package:buildmatch_mobile/features/architect/data/datasources/architect_project_list_datasource.dart';
import 'package:buildmatch_mobile/features/architect/data/datasources/architect_project_offer_remote_datasource.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_milestone_repository_impl.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_project_detail_repository_impl.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_project_list_impl.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_project_offer_repository_impl.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/Architect_project_detail_repository.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_milestone_repository.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_project_list_repository.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_project_offer_repository.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_all_project.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_project_by_status.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_project_detail.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_project_offer_usecase.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_publikasi_milestone_usecase.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_system_milestones_usecase.dart';
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_project_detail_bloc.dart';
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_project_list_bloc.dart';
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_project_offer_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Profile Feature Clean Architecture Imports
import '../features/contractor/data/datasources/contractor_milestone_local_data_source.dart';
import '../features/contractor/data/repositories/contractor_milestone_repository_impl.dart';
import '../features/contractor/domain/repositories/contractor_milestone_repository.dart';
import '../features/contractor/domain/usecases/contractor_get_system_milestones_usecase.dart';
import '../features/contractor/domain/usecases/contractor_publikasi_milestone_usecase.dart';

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

import '../features/contractor/data/datasources/contractor_project_request_local_datasource.dart';
import '../features/contractor/domain/usecases/get_contractor_project_requests.dart';
import '../features/contractor/data/repositories/contractor_project_request_repository_impl.dart.dart';
import '../features/contractor/domain/repositories/contractor_project_request_repository.dart';
import '../features/contractor/presentation/bloc/contractor_project_request_bloc.dart';

import '../features/contractor/data/repositories/contractor_dashboard_repository_impl.dart';
import '../features/contractor/domain/repositories/contractor_dashboard_repository.dart';
import '../features/contractor/domain/usecases/get_contractor_dashboard_usecase.dart';
import '../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';
import '../features/contractor/data/datasources/contractor_dashboard_remote_datasource.dart';

import '../features/contractor/domain/usecases/get_contractor_project_offer_usecase.dart';
import '../features/contractor/domain/repositories/contractor_project_offer_repository.dart';
import '../features/contractor/data/repositories/contractor_project_offer_repository_impl.dart';
import '../features/contractor/presentation/bloc/contractor_project_offer_bloc.dart';
import '../features/contractor/data/datasources/contractor_project_offer_remote_datasource.dart';

import '../features/contractor/data/datasources/contractor_project_detail_data_source.dart';
import '../features/contractor/data/repositories/contractor_project_detail_repository_impl.dart';
import '../features/contractor/domain/repositories/contractor_project_detail_repository.dart';
import '../features/contractor/domain/usecases/get_contractor_project_detail.dart';
import '../features/contractor/presentation/bloc/contractor_project_detail_bloc.dart';

import '../features/contractor/data/datasources/contractor_project_list_datasource.dart';
import '../features/contractor/data/repositories/contractor_project_list_impl.dart';
import '../features/contractor/domain/repositories/contractor_project_list_repository.dart';
import '../features/contractor/domain/usecases/get_all_project.dart';
import '../features/contractor/domain/usecases/get_project_by_status.dart';
import '../features/contractor/presentation/bloc/contractor_project_list_bloc.dart';

import '../features/rating/data/datasources/rating_client_local_data_source.dart';
import '../features/rating/data/repositories/rating_client_repository_impl.dart';
import '../features/rating/domain/repositories/rating_client_repository.dart';
import '../features/rating/domain/usecases/get_submit_rating_client.dart';
import '../features/rating/presentation/bloc/rating_client_bloc.dart';

import '../features/waiting_approval/data/datasources/waiting_approval_local_data_source.dart';
import '../features/waiting_approval/data/repositories/waiting_approval_repository_impl.dart';
import '../features/waiting_approval/domain/repositories/waiting_approval_repository.dart';
import '../features/waiting_approval/domain/usecases/get_verification_status_usecase.dart';
import '../features/waiting_approval/presentation/bloc/waiting_approval_bloc.dart';

import '../features/detail_portofolio/data/datasources/portofolio_local_data_source.dart';
import '../features/detail_portofolio/data/repositories/portofolio_repository_impl.dart';
import '../features/detail_portofolio/domain/repositories/portofolio_repository.dart';
import '../features/detail_portofolio/domain/usecases/get_portofolio_usecase.dart';
import '../features/detail_portofolio/presentation/bloc/portofolio_bloc.dart';

import '../features/contractor/data/datasources/contractor_progres_local_data_source.dart';
import '../features/contractor/data/repositories/contractor_progres_repository_impl.dart';
import '../features/contractor/domain/repositories/contractor_progres_repository.dart';
import '../features/contractor/domain/usecases/get_contractor_progres_usecases.dart';
import '../features/contractor/presentation/bloc/contractor_add_progres_bloc.dart';

// Architect Dashboard Feature
import 'package:buildmatch_mobile/features/architect/presentation/pages/architect_dashboard_page.dart';
import 'package:buildmatch_mobile/features/architect/data/datasources/architect_dashboard_remote_datasource.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_dashboard_repository_impl.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_dashboard_repository.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_dashboard_usecase.dart';
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_dashboard_bloc.dart';
// Architect Project List Feature
import '../features/architect/presentation/pages/architect_project_detail_page.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_all_project.dart';
import 'package:buildmatch_mobile/features/architect/domain/usecases/get_project_by_status.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_project_list_repository.dart';
import 'package:buildmatch_mobile/features/architect/data/datasources/architect_project_list_datasource.dart';
import 'package:buildmatch_mobile/features/architect/data/repositories/architect_project_list_impl.dart';
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_project_list_bloc.dart';

// Client Dashboard Feature
import '../features/client/data/datasources/client_dashboard_local_data_source.dart';
import '../features/client/data/repositories/client_dashboard_repository_impl.dart';
import '../features/client/domain/repositories/client_dashboard_repository.dart';
import '../features/client/domain/usecases/get_client_dashboard_usecase.dart';
import '../features/client/presentation/bloc/client_dashboard_bloc.dart';

// Client Project Feature
import '../features/client/data/datasources/client_project_local_data_source.dart';
import '../features/client/data/repositories/client_project_repository_impl.dart';
import '../features/client/domain/repositories/client_project_repository.dart';
import '../features/client/domain/usecases/get_client_projects_usecase.dart';
import '../features/client/presentation/bloc/client_project_bloc.dart';

// milestone contractor
import '../features/milestone/presentation/pages/milestone_contractor_page.dart';
import '../features/milestone/data/datasources/milestone_contractor_local_data_source.dart';
import '../features/milestone/data/repositories/milestone_contractor_repository_impl.dart';
import '../features/milestone/domain/repositories/milestone_contractor_repository.dart';
import '../features/milestone/domain/usecases/get_milestones_contractor_usecase.dart';
import '../features/milestone/presentation/bloc/milestone_contractor_bloc.dart';

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
  initContractorProjectRequest();
  initRatingClient();
  initDetailPortofolio();
  initProjectContractorList();
  initContractorMilestone();
  initMilestoneContractorPage();

  initProfileSetup();
  initWaitingApproval();
  initClientDashboard();
  initClientProject();
  initContractorProgres();
  initContractorProjectOffer();

  initArchitectDashboard();
  initArchitectProjectList();
  initArchitectProjectDetail();
  initArchitectProjectOffer();
  initArchitectMilestone();
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
  sl.registerFactory(() => ContractorProjectDetailBloc(sl()));
  sl.registerLazySingleton(() => GetContractorProjectDetail(sl()));
  sl.registerLazySingleton<ContractorProjectDetailRepository>(
    () => ContractorProjectDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ContractorProjectRequestDetailLocalDataSource>(
    () => ContractorProjectRequestDetailLocalDataSourceImpl(),
  );
}

void initContractorProjectRequest() {
  sl.registerFactory(() => ContractorProjectRequestBloc(sl()));
  sl.registerLazySingleton(() => GetContractorProjectRequests(sl()));
  sl.registerLazySingleton<ContractorProjectRequestRepository>(
    () => ContractorProjectRequestRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ContractorProjectRequestLocalDataSource>(
    () => ContractorProjectRequestLocalDataSourceImpl(),
  );
}

void initContractorProjectOffer() {
  sl.registerFactory(
    () => ContractorProjectOfferBloc(getPenawaranUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetContractorProjectOfferUsecase(sl()));
  sl.registerLazySingleton<ContractorProjectOfferRepository>(
    () => ContractorProjectOfferRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ContractorProjectOfferRemoteDataSource>(
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
  sl.registerFactory(
    () => ContractorProjectListBloc(
      getAllProjects: sl(),
      getProjectsByStatus: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetAllProjects(sl()));
  sl.registerLazySingleton(() => GetProjectsByStatus(sl()));
  sl.registerLazySingleton<ContractorProjectListRepository>(
    () => ContractorProjectListRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ContractorProjectListRemoteDataSource>(
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
  sl.registerFactory(() => WaitingApprovalBloc(getVerificationStatus: sl()));
  sl.registerLazySingleton(() => GetVerificationStatusUseCase(sl()));
  sl.registerLazySingleton<WaitingApprovalRepository>(
    () => WaitingApprovalRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WaitingApprovalLocalDataSource>(
    () => WaitingApprovalLocalDataSourceImpl(),
  );
}

void initArchitectProjectDetail() {
  sl.registerFactory(() => ArchitectProjectDetailBloc(sl()));
  sl.registerLazySingleton(() => GetArchitectProjectDetail(sl()));
  sl.registerLazySingleton<ArchitectProjectDetailRepository>(
    () => ArchitectProjectDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ArchitectProjectDetailLocalDataSource>(
    () => ArchitectProjectDetailLocalDataSourceImpl(),
  );
}

void initArchitectProjectOffer() {
  sl.registerFactory(
    () => ArchitectProjectOfferBloc(getPenawaranUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetArchitectProjectOfferUsecase(sl()));
  sl.registerLazySingleton<ArchitectProjectOfferRepository>(
    () => ArchitectProjectOfferRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ArchitectProjectOfferRemoteDataSource>(
    () => ArchitectPenawaranRemoteDataSourceImpl(),
  );
}

void initArchitectProjectList() {
  sl.registerFactory(
    () => ArchitectProjectListBloc(
      getAllProjects: sl(),
      getProjectsByStatus: sl(),
    ),
  );
  sl.registerLazySingleton(() => ArchitectGetAllProjects(sl()));
  sl.registerLazySingleton(() => ArchitectGetProjectsByStatus(sl()));
  sl.registerLazySingleton<ArchitectProjectListRepository>(
    () => ArchitectProjectListRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ArchitectProjectListRemoteDataSource>(
    () => ArchitectProjectRemoteDataSourceImpl(),
  );
}

void initArchitectMilestone() {
  sl.registerLazySingleton<ArchitectMilestoneLocalDataSource>(
    () => ArchitectMilestoneLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ArchitectMilestoneRepository>(
    () => ArchitectMilestoneRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => ArchitectGetSystemMilestonesUseCase(
      sl<ArchitectMilestoneRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => ArchitectPublikasiMilestoneUseCase(
      sl<ArchitectMilestoneRepository>(),
    ),
  );
}

void initClientDashboard() {
  sl.registerFactory(() => ClientDashboardBloc(getDashboardUseCase: sl()));
  sl.registerLazySingleton(() => GetClientDashboardUseCase(repository: sl()));
  sl.registerLazySingleton<ClientDashboardRepository>(
    () => ClientDashboardRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ClientDashboardLocalDataSource>(
    () => ClientDashboardLocalDataSourceImpl(),
  );
}

void initClientProject() {
  sl.registerFactory(
    () => ClientProjectBloc(
      getPenawaranUseCase: sl(),
      getAllProjectsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetClientPenawaranUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetClientAllProjectsUseCase(repository: sl()));
  sl.registerLazySingleton<ClientProjectRepository>(
    () => ClientProjectRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ClientProjectLocalDataSource>(
    () => ClientProjectLocalDataSourceImpl(),
  );
}

void initContractorProgres() {
  sl.registerFactory(
    () => ContractorAddProgresBloc(
      getJenisPekerjaanUseCase: sl(),
      simpanProgresUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetJenisPekerjaanUseCase(sl()));
  sl.registerLazySingleton(() => SimpanProgresUseCase(sl()));
  sl.registerLazySingleton<ContractorProgressRepository>(
    () => ContractorProgresRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ContractorProgresLocalDataSource>(
    () => ProgresLocalDataSourceImpl(),
  );
}

void initContractorMilestone() {
  sl.registerLazySingleton<ContractorMilestoneLocalDataSource>(
    () => ContractorMilestoneLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ContractorMilestoneRepository>(
    () => ContractorMilestoneRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => ContractorGetSystemMilestonesUseCase(
      sl<ContractorMilestoneRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => ContractorPublikasiMilestoneUseCase(
      sl<ContractorMilestoneRepository>(),
    ),
  );
}

void initArchitectDashboard() {
  sl.registerFactory(() => ArchitectDashboardBloc(getDashboardUseCase: sl()));
  sl.registerLazySingleton(
    () => GetArchitectDashboardUseCase(repository: sl()),
  );
  sl.registerLazySingleton<ArchitectDashboardRepository>(
    () => ArchitectDashboardRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ArchitectDashboardRemoteDataSource>(
    () => ArchitectDashboardRemoteDataSourceImpl(),
  );
}

void initMilestoneContractorPage() {
  sl.registerFactory(() => MilestoneContractorBloc(getMilestonesUseCase: sl()));
  sl.registerLazySingleton(() => GetMilestonesUseCase(sl()));
  sl.registerLazySingleton<MilestoneContractorRepository>(
    () => MilestoneContractorRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<MilestoneContractorLocalDataSource>(
    () => MilestoneContractorLocalDataSourceImpl(),
  );
}
