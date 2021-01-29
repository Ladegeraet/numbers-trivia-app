import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia_app/core/error/exception.dart';
import 'package:numbers_trivia_app/features/number_trivia/data/datasources/number_triva_local_data_source.dart';
import 'package:numbers_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final triviaCachedJson = fixture('trivia_cached.json');
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(triviaCachedJson),
    );

    test(
        'should return NumberTriviaModel from SharedPreferences '
        'when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(triviaCachedJson);
      // act
      final result = await dataSource.getLastNumberTrivia();

      // assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw CacheException '
        'when there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = dataSource.getLastNumberTrivia;

      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });

    test(
        'should throw FormatException '
        'when there is a wrong cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn("undecodable");

      // act
      final call = dataSource.getLastNumberTrivia;

      // assert
      expect(() => call(), throwsA(TypeMatcher<FormatException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(
      text: 'Test Text',
      number: 1,
    );

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);

      // assert
      final expectedJsonString = json.encode(
        tNumberTriviaModel.toJson(),
      );
      verify(mockSharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        expectedJsonString,
      ));
    });
  });
}
