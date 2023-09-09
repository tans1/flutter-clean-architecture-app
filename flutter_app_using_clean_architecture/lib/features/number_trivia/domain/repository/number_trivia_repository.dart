import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/numberTrivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
