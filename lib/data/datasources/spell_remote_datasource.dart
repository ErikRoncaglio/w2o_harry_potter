import 'package:dio/dio.dart';
import '../models/spell_model.dart';

abstract class SpellRemoteDataSource {
  Future<List<SpellModel>> getSpells();
}

class SpellRemoteDataSourceImpl implements SpellRemoteDataSource {
  final Dio dio;

  SpellRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SpellModel>> getSpells() async {
    try {
      final response = await dio.get('https://hp-api.onrender.com/api/spells');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => SpellModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load spells: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error while fetching spells: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching spells: $e');
    }
  }
}
