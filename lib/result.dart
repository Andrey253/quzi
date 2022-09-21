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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Правильных ответов ${model.answers.length}'),
                ],
              ),
              const SizedBox(height: 22),
              Text('Не правильных ответов ${model.questions.length - model.answers.length}'),
              const SizedBox(height: 22),
              model.sended
                  ? SizedBox(
                      height: 40,
                      child: TextButton(
                          onPressed: () => model.restart(context),
                          child: const Text('Результат отправлен, начать заново')))
                  : SizedBox(
                      height: 40,
                      child: TextButton(onPressed: () => model.sendResult(), child: const Text('Отправить результат'))),
              model.isLoading
                  ? const SizedBox(height: 40, child: CircularProgressIndicator())
                  : SizedBox(
                      height: 40,
                      child: TextButton(onPressed: () => model.getResult(), child: const Text('Проверить результаты'))),
              Column(
                children: model.resultList.map((e) => ItemResult(resultData: e)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
