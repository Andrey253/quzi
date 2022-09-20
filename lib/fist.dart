import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/model/model.dart';
import 'package:quzi/quzi.dart';
import 'package:quzi/search/show_search_difficulty.dart';
import 'package:quzi/search/show_search_theme.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

bool isLoading = false;

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return SafeArea(
        child: Scaffold(
            body: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset("images/fox.png"),
        const SizedBox(height: 50),
        TextButton(
          child: Text(model.difficulty ?? 'Выберите сложность'),
          onPressed: () async {
            final d = await showSearch(context: context, delegate: ShowSearchDifficulty());
            model.setDifficulty(d);
          },
        ),
        TextButton(
          child: Text(model.category ?? 'Выберите категорию'),
          onPressed: () async {
            final d = await showSearch(context: context, delegate: ShowSearchCategory());
            model.setCategory(d);
          },
        ),
        TextButton(
          child: isLoading ? const Text('Загрузка вопросов...') : const Text('Начать'),
          onPressed: () async {
            isLoading = true;
            await model.loadQuestions();
            isLoading = false;
            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, QuziPage.id);
          },
        ),
      ]),
    )));
  }
}
