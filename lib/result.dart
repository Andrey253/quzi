import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/item_result.dart';
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
              const SizedBox(height: 22),
              Text('Правильных ответов ${model.answers.length}'),
              const SizedBox(height: 22),
              Text('Не правильных ответов ${model.questions.length - model.answers.length}'),
              const SizedBox(height: 22),
              model.sended
                  ? const Text('Результат отправлен')
                  : model.isLoading
                      ? const CircularProgressIndicator()
                      : TextButton(onPressed: () => model.sendResult(), child: const Text('Отправить результат')),
              model.isLoading
                  ? const CircularProgressIndicator()
                  : TextButton(onPressed: () => model.getResult(), child: const Text('Проверить результаты')),
              Expanded(
                  child: Column(
                children: model.resultList.map((e) => ItemResult(resultData: e)).toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}