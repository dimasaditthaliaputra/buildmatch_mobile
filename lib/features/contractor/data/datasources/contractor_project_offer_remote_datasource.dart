import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/contractor_project_offer_model.dart';

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
      // final response = await supabaseClient
      //     .from(_kPenawaranTable)
      //     .insert(data)
      //     .select()
      //     .single();

      return ContractorProjectOfferModel.fromJson(data);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('Gagal mengirim penawaran: ${e.toString()}');
    }
  }
}