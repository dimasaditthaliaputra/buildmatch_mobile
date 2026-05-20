// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../../../core/error/exceptions.dart';
import '../../domain/entities/contractor_project_list_entity.dart';
import '../models/contractor_project_list_model.dart';

abstract class ContractorProjectListRemoteDataSource {
  Future<List<ContractorProjectListEntity>> getProjects();
  Future<List<ContractorProjectListEntity>> getProjectsByStatus(ProjectStatus status);
}

class ContractorProjectRemoteDataSourceImpl
    implements ContractorProjectListRemoteDataSource {
  // final SupabaseClient supabaseClient;

  // ContractorProjectRemoteDataSourceImpl({required this.supabaseClient});

  ContractorProjectRemoteDataSourceImpl();

  final List<ContractorProjectListModel> _dummyProjects = [
    ContractorProjectListModel(
      id: '1',
      name: 'Renovasi Ruang LPY 4',
      location: 'Polinema, Malang',
      startDate: DateTime(2024, 7, 18),
      clientName: 'Billie Eilish',
      status: ProjectStatus.berjalan,
    ),
    ContractorProjectListModel(
      id: '2',
      name: 'Proyek Pembangunan PT. Indah',
      location: 'Lowokwaru, Malang',
      startDate: DateTime(2026, 4, 18),
      clientName: 'Diana Maghfiroh',
      status: ProjectStatus.berjalan,
    ),
    
    ContractorProjectListModel(
      id: '3',
      name: 'Ruang Tidur Anak Kecil',
      location: 'Polinema, Malang',
      startDate: DateTime(2024, 7, 18),
      clientName: 'Ramon Simon',
      status: ProjectStatus.selesai,
    ),
    ContractorProjectListModel(
      id: '4',
      name: 'Rumah Grand Heaven',
      location: 'Lowokwaru, Malang',
      startDate: DateTime(2026, 1, 3),
      clientName: 'Albert Einsten',
      status: ProjectStatus.selesai,
    ),
  ];

  @override
  Future<List<ContractorProjectListModel>> getProjects() async {
    // try {
    //   final response = await supabaseClient
    //       .from('projects')
    //       .select()
    //       .order('start_date', ascending: false);

    //   return (response as List)
    //       .map((json) => ProjectContractorListModel.fromJson(json as Map<String, dynamic>))
    //       .toList();
    // } on PostgrestException catch (e) {
    //   throw ServerException(e.message); 
    // } catch (e) {
    //   throw ServerException(e.toString()); 
    // }
    await Future.delayed(const Duration(seconds: 1));
    return _dummyProjects;
  }

  @override
  Future<List<ContractorProjectListModel>> getProjectsByStatus(
    ProjectStatus status,
  ) async {
    // try {
    //   final statusStr = status.name; 
      
    //   final response = await supabaseClient
    //       .from('projects')
    //       .select()
    //       .eq('status', statusStr)
    //       .order('start_date', ascending: false);

    //   return (response as List)
    //       .map((json) => ProjectContractorListModel.fromJson(json as Map<String, dynamic>))
    //       .toList();
    // } on PostgrestException catch (e) {
    //   // PERBAIKAN: Tambahkan throw
    //   throw ServerException(e.message); 
    // } catch (e) {
    //   // PERBAIKAN: Tambahkan throw
    //   throw ServerException(e.toString()); 
    // }
    await Future.delayed(const Duration(seconds: 1));
    final filteredProjects = _dummyProjects.where((project) {
      return project.status == status;
    }).toList();

    return filteredProjects;
  }
}