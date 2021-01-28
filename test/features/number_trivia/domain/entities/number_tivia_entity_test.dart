import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

void main() {


  test(
    'entities should be equals',
        () async {
      // arrange
      final tNumberTrivia = NumberTrivia(
        text: 'hello',
        number: 1,
      );
      // act
      final result = await NumberTrivia(text: 'hello', number: 1);

      // assert
      expect(result, tNumberTrivia);
    },
  );
}