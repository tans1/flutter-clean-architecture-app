import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'features/number_trivia/presentation/pages/home/homePage.dart';
import 'injections_container.dart' as injection;
import 'injections_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
