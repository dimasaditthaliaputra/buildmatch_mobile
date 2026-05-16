import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/penawaran_model.dart';

// const _kPenawaranTable = 'penawarans';

abstract class PenawaranRemoteDataSource {
  Future<PenawaranModel> ajukanPenawaran(Map<String, dynamic> data);
}

class PenawaranRemoteDataSourceImpl implements PenawaranRemoteDataSource {
  // final SupabaseClient supabaseClient;

  // const PenawaranRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<PenawaranModel> ajukanPenawaran(Map<String, dynamic> data) async {
    try {
      // final response = await supabaseClient
      //     .from(_kPenawaranTable)
      //     .insert(data)
      //     .select()
      //     .single();

      return PenawaranModel.fromJson(data);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('Gagal mengirim penawaran: ${e.toString()}');
    }
  }
}