import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../bloc/number_trivia_bloc.dart';
import 'widgets/reUsableWidgets.dart';

class HomePage extends HookWidget {
  HomePage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _inputNumber = useState('');
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia App"),
      ),
      body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                        builder: (context, state) {
                          if (state is EmptyState)
                            return MessageDisplayWidget(
                              message: "Empty state",
                              fontSize: 40,
                              textColor: Colors.black,
                            );
                          else if (state is ErrorState)
                            return MessageDisplayWidget(
                              message: state.message,
                              fontSize: 25,
                              textColor: Colors.red,
                            );
                          else if (state is Loading)
                            return LoadingWidget();
                          else if (state is Loaded) {
                            return DisplayLoadedWidget(
                              number: state.numberTrivia.number,
                              text: state.numberTrivia.text,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            child: TextField(
                              controller: controller,
                              onChanged: (value) {
                                _inputNumber.value = value;
                              },
                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                controller.clear();
                                context.read<NumberTriviaBloc>().add(
                                      GetTriviaForConcreteNumber(
                                          number: _inputNumber.value),
                                    );
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Input the number"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      controller.clear();
                                      context.read<NumberTriviaBloc>().add(
                                            GetTriviaForConcreteNumber(
                                                number: _inputNumber.value),
                                          );
                                    },
                                    child: Text(
                                      "search",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      context.read<NumberTriviaBloc>().add(
                                            GetTriviaForRandomNumber(),
                                          );
                                    },
                                    child: Text(
                                      "Get Random",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
