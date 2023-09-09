import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/numberTrivia_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/usecases/get_concrete_NumberTrivia.dart';
import '../../domain/usecases/get_random_NumberTrivia.dart';
import '../../domain/entities/numberTrivia.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  final NumberTriviaConstants constants;
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
    required this.constants,
  }) : super(EmptyState()) {
    on<GetTriviaForConcreteNumber>(_onGetConcreteTrivia);
    on<GetTriviaForRandomNumber>(_onGetRandomTrivia);
  }

  Future<void> _onGetRandomTrivia(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(Loading());
    final result = await getRandomNumberTrivia(NoParams());

    return result.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (trivia) => emit(Loaded(numberTrivia: trivia)));
  }

  Future<void> _onGetConcreteTrivia(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(Loading());
    final integer = inputConverter.stringToInt(event.number);

    return integer.fold(
      (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
      (integer) async {
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));

        return await failureOrTrivia.fold(
          (failure) {
            emit(ErrorState(message: _mapFailureToMessage(failure)));
          },
          (trivia) {
            emit(Loaded(numberTrivia: trivia));
          },
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return constants.SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return constants.CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error occurred";
    }
  }
}
