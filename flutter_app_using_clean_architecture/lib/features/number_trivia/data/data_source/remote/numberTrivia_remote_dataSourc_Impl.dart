import 'dart:convert';
import '../../../../../core/errors/exceptions.dart';
import '../../model/number_trivia_model.dart';
import 'numberTrivia_remote_dataSource.dart';
import 'package:http/http.dart' as http;

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final http.Response response = await client.get(
      Uri.parse("http://numbersapi.com/$number"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return await NumberTriviaModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final http.Response response = await client.get(
      Uri.parse('http://numbersapi.com/random?json'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException();
    }
  }
}
