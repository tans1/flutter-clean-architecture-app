import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/numberTrivia_constants.dart';
import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'features/number_trivia/data/data_source/local/numberTrivia_local_dataSource.dart';
import 'features/number_trivia/data/data_source/local/numberTrivia_local_dataSourceImpl.dart';
import 'features/number_trivia/data/data_source/remote/numberTrivia_remote_dataSourc_Impl.dart';
import 'features/number_trivia/data/data_source/remote/numberTrivia_remote_dataSource.dart';
import 'features/number_trivia/data/repository/numberTrivia_repository_impl.dart';
import 'features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_NumberTrivia.dart';
import 'features/number_trivia/domain/usecases/get_random_NumberTrivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Features - NUmber Trivia

  // * Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
      constants: sl(),
    ),
  );

  // * UseCases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // * Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // * DataSource
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  // ! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => NumberTriviaConstants());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()));

  // ! Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
