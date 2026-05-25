// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../../../core/error/exceptions.dart';
import '../../domain/entities/architect_project_list_entity.dart';
import '../models/architect_project_list_model.dart';

abstract class ArchitectProjectListRemoteDataSource {
  Future<List<ArchitectProjectListEntity>> getProjects();
  Future<List<ArchitectProjectListEntity>> getProjectsByStatus(ProjectStatus status);
}

class ArchitectProjectRemoteDataSourceImpl
    implements ArchitectProjectListRemoteDataSource {
  // final SupabaseClient supabaseClient;

  // ArchitectProjectRemoteDataSourceImpl({required this.supabaseClient});

  ArchitectProjectRemoteDataSourceImpl();

  final List<ArchitectProjectListModel> _dummyProjects = [
    
    ArchitectProjectListModel(
      id: '2',
      name: 'Proyek Pembangunan PT. Indah',
      location: 'Lowokwaru, Malang',
      startDate: DateTime(2026, 4, 18),
      clientName: 'Diana Maghfiroh',
      status: ProjectStatus.berjalan,
    ),
    
    ArchitectProjectListModel(
      id: '3',
      name: 'Ruang Tidur Anak Kecil',
      location: 'Polinema, Malang',
      startDate: DateTime(2024, 7, 18),
      clientName: 'Ramon Simon',
      status: ProjectStatus.selesai,
    ),
    ArchitectProjectListModel(
      id: '4',
      name: 'Rumah Grand Heaven',
      location: 'Lowokwaru, Malang',
      startDate: DateTime(2026, 1, 3),
      clientName: 'Albert Einsten',
      status: ProjectStatus.selesai,
    ),
  ];

  @override
  Future<List<ArchitectProjectListModel>> getProjects() async {
    // try {
    //   final response = await supabaseClient
    //       .from('projects')
    //       .select()
    //       .order('start_date', ascending: false);

    //   return (response as List)
    //       .map((json) => ProjectArchitectListModel.fromJson(json as Map<String, dynamic>))
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
  Future<List<ArchitectProjectListModel>> getProjectsByStatus(
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
    //       .map((json) => ProjectArchitectListModel.fromJson(json as Map<String, dynamic>))
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