import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/data/quzi_model.dart';
import 'package:quzi/model/model.dart';

class Result extends StatefulWidget {
  static const id = '/result';
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 22),
              Text('Правильных ответов ${model.answers.length}'),
              SizedBox(height: 22),
              Text('Не правильных ответов ${model.questions.length - model.answers.length}'),
              SizedBox(height: 22),
              TextButton(onPressed: () => model.sendResult(), child: Text('Отправить результат')),
              TextButton(onPressed: () => model.getResult(), child: Text('Проверить результаты')),
              Expanded(
                  child: Column(
                children: model.resultList.map((e) => Text(e.correctAnswer)).toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
