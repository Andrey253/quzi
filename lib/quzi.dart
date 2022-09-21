import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/model/model.dart';
import 'package:quzi/result.dart';

class QuziPage extends StatefulWidget {
  static const id = '/quziPage';
  const QuziPage({Key? key}) : super(key: key);

  @override
  State<QuziPage> createState() => _QuziPageState();
}

class _QuziPageState extends State<QuziPage> {
  int currentPage = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Scaffold(
      appBar: AppBar(elevation: 1, title: Text("Score: ${model.score}, page: ${currentPage+1}/${model.questions.length}")),
      body: model.questions.isEmpty
          ? const Center(child: Text('Задания не получены'))
          : model.questions.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PageView.builder(
                    itemCount: model.questions.length,
                    itemBuilder: (context, index) {
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          model.question(index).question ?? '',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 10.0),
                        ...model.question(index).answers.where((element) => element != null).map((itemQuest) => Card(
                            color: model.getColor(itemQuest, index),
                            elevation: 1,
                            clipBehavior: Clip.antiAlias,
                            child: RadioListTile<dynamic>(
                              value: itemQuest,
                              selected: model.selected(index, itemQuest),
                              title: Text(itemQuest ?? ''),
                              groupValue: model.groupValue(index),
                              onChanged: (item) => model.onChanged(index, item),
                            )))
                      ]);
                    },
                    controller: _controller,
                    onPageChanged: (ind) => setState(() => currentPage = ind),
                  ),
                )
              : const Text("Some error! Check console"),
      bottomNavigationBar: (model.questions.isNotEmpty)
          ? BottomAppBar(
              child: SizedBox(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage <= 0 ? null : () => _controller.jumpToPage(currentPage - 1),
                        child: const Text("Prev"),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: currentPage >= model.questions.length - 1
                            ? null
                            : () => _controller.jumpToPage(currentPage + 1),
                        child: const Text("Next"),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, Result.id),
                        child: const Text("Done"),
                      ),
                    ],
                  )))
          : null,
    );
  }
}
