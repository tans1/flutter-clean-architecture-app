import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../model/number_trivia_model.dart';
import 'numberTrivia_local_dataSource.dart';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia) {
    final jsonString = json.encode(numberTrivia.toJson());
    return sharedPreferences.setString("CACHED_NUMBER_TRIVIA", jsonString);
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString =
        await sharedPreferences.getString("CACHED_NUMBER_TRIVIA");

    if (jsonString != null) {
      final jsonNumberTrivia = json.decode(jsonString);
      return Future.value(NumberTriviaModel.fromJson(jsonNumberTrivia));
    } else {
      throw CacheException();
    }
  }
}
