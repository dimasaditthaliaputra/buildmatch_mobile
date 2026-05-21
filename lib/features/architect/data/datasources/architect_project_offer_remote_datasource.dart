//import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/architect_project_offer_model.dart';
import '../../domain/entities/architect_project_offer_entity.dart';

// const _kPenawaranTable = 'penawarans';

abstract class ArchitectProjectOfferRemoteDataSource {
  Future<ArchitectProjectOfferModel> ajukanPenawaran(Map<String, dynamic> data);
}

class ArchitectPenawaranRemoteDataSourceImpl implements ArchitectProjectOfferRemoteDataSource {
  // final SupabaseClient supabaseClient;

  // const PenawaranRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<ArchitectProjectOfferModel> ajukanPenawaran(Map<String, dynamic> data) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      return ArchitectProjectOfferModel(
        id: 'mock-offer-999',
        projectId: data['project_id'] ?? 'dummy-proj-123',
        architectId: 'mock-architect-id',
        budgetMin: data['budget_min'] ?? 0,
        budgetMax: data['budget_max'] ?? 0,
        pesan: data['pesan'] ?? '',
        estimasiWaktu: DateTime.tryParse(data['estimasi_waktu'] ?? '') ?? DateTime.now(),
        status: PenawaranStatus.menunggu,
        createdAt: DateTime.now(),
      );
      
    } catch (e) {
      throw ServerException('Gagal mengirim penawaran: ${e.toString()}');
    }
    // try {
    //   // final response = await supabaseClient
    //   //     .from(_kPenawaranTable)
    //   //     .insert(data)
    //   //     .select()
    //   //     .single();

    //   return ContractorProjectOfferModel.fromJson(data);
    // } on PostgrestException catch (e) {
    //   throw ServerException(e.message);
    // } catch (e) {
    //   throw ServerException('Gagal mengirim penawaran: ${e.toString()}');
    // }
  }
}