import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:numbers_trivia_app/core/error/failures.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbers_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository _repository;

  GetConcreteNumberTrivia(
    this._repository,
  );

  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await _repository.getConcreteNumberTrivia(number);
  }
}
