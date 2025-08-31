import 'package:flutter_test/flutter_test.dart';
import 'package:w2o_harry_potter/domain/entities/character.dart';
import 'package:w2o_harry_potter/domain/repositories/character_repository.dart';
import 'package:w2o_harry_potter/domain/usecases/get_all_characters.dart';
import 'package:w2o_harry_potter/domain/usecases/get_characters_by_house.dart';
import 'package:w2o_harry_potter/presentation/providers/character_provider.dart';

// Mock simples do CharacterRepository
class MockCharacterRepository implements CharacterRepository {
  bool shouldThrowError = false;
  List<Character> charactersToReturn = [];

  @override
  Future<List<Character>> getCharacters() async {
    if (shouldThrowError) {
      throw Exception('Erro de conexão');
    }
    return charactersToReturn;
  }

  @override
  Future<List<Character>> getCharactersByHouse(String house) async {
    if (shouldThrowError) {
      throw Exception('Erro de conexão');
    }
    return charactersToReturn.where((c) => c.house == house).toList();
  }
}

void main() {
  group('CharacterProvider', () {
    late CharacterProvider provider;
    late MockCharacterRepository mockRepository;
    late GetAllCharacters getAllCharacters;
    late GetCharactersByHouse getCharactersByHouse;

    setUp(() {
      mockRepository = MockCharacterRepository();
      getAllCharacters = GetAllCharacters(repository: mockRepository);
      getCharactersByHouse = GetCharactersByHouse(repository: mockRepository);
      provider = CharacterProvider(
        getAllCharacters: getAllCharacters,
        getCharactersByHouse: getCharactersByHouse,
      );
    });

    test('deve inicializar com estado correto', () {
      expect(provider.isLoading, false);
      expect(provider.characters, isEmpty);
      expect(provider.errorMessage, isNull);
    });

    test('deve carregar personagens com sucesso', () async {
      // Arrange
      final expectedCharacters = [
        Character(
          id: '1',
          name: 'Harry Potter',
          house: 'Gryffindor',
          image: 'test.jpg',
          actor: 'Daniel Radcliffe',
        ),
        Character(
          id: '2',
          name: 'Hermione Granger',
          house: 'Gryffindor',
          image: 'test2.jpg',
          actor: 'Emma Watson',
        ),
      ];
      mockRepository.charactersToReturn = expectedCharacters;
      mockRepository.shouldThrowError = false;

      // Act
      await provider.fetchCharacters();

      // Assert
      expect(provider.isLoading, false);
      expect(provider.characters, equals(expectedCharacters));
      expect(provider.errorMessage, isNull);
    });

    test('deve lidar com erro ao carregar personagens', () async {
      // Arrange
      mockRepository.shouldThrowError = true;

      // Act
      await provider.fetchCharacters();

      // Assert
      expect(provider.isLoading, false);
      expect(provider.characters, isEmpty);
      expect(provider.errorMessage, isNotNull);
      expect(provider.errorMessage, contains('Erro'));
    });

    test('deve mudar isLoading durante o carregamento', () async {
      // Arrange
      mockRepository.charactersToReturn = [];
      mockRepository.shouldThrowError = false;

      // Verificar estados durante execução
      bool wasLoadingTrue = false;
      provider.addListener(() {
        if (provider.isLoading) {
          wasLoadingTrue = true;
        }
      });

      // Act
      await provider.fetchCharacters();

      // Assert
      expect(wasLoadingTrue, true);
      expect(provider.isLoading, false);
    });
  });
}
