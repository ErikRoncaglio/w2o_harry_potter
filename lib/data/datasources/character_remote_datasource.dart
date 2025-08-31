import 'package:dio/dio.dart';
import '../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<List<CharacterModel>> getCharactersByHouse(String house);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get('https://hp-api.onrender.com/api/characters');

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data;
        return charactersJson
            .map((json) => CharacterModel.fromJson(json))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load characters: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          message: 'Network error: Unable to connect to server',
        );
      } else {
        throw DioException(
          requestOptions: e.requestOptions,
          message: 'Failed to fetch characters: ${e.message}',
        );
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByHouse(String house) async {
    try {
      final response = await dio.get('https://hp-api.onrender.com/api/characters/house/${house.toLowerCase()}');

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data;
        return charactersJson
            .map((json) => CharacterModel.fromJson(json))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load characters for house $house: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          message: 'Network error: Unable to connect to server',
        );
      } else {
        throw DioException(
          requestOptions: e.requestOptions,
          message: 'Failed to fetch characters for house $house: ${e.message}',
        );
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
