import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/numberTrivia.dart';
import '../repository/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params param) async {
    return await repository.getConcreteNumberTrivia(param.number);
  }
}

class Params extends Equatable {
  final int number;
  Params({required this.number});

  @override
  List<Object?> get props => [number];
}
