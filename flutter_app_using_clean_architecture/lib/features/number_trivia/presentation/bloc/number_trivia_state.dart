part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

// initial state
class EmptyState extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded({
    required this.numberTrivia,
  });

  @override
  List<Object> get props => [this.numberTrivia];
}

class ErrorState extends NumberTriviaState {
  final String message;

  ErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [this.message];
}
