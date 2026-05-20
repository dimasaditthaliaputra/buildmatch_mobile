//import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/contractor_project_offer_model.dart';
import '../../domain/entities/contractor_project_offer_entity.dart';

// const _kPenawaranTable = 'penawarans';

abstract class ContractorProjectOfferRemoteDataSource {
  Future<ContractorProjectOfferModel> ajukanPenawaran(Map<String, dynamic> data);
}

class PenawaranRemoteDataSourceImpl implements ContractorProjectOfferRemoteDataSource {
  // final SupabaseClient supabaseClient;

  // const PenawaranRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<ContractorProjectOfferModel> ajukanPenawaran(Map<String, dynamic> data) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      return ContractorProjectOfferModel(
        id: 'mock-offer-999',
        projectId: data['project_id'] ?? 'dummy-proj-123',
        contractorId: 'mock-contractor-id',
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