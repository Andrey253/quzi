import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quzi/data/result_data.dart';
import 'model/model.dart';

class ItemResult extends StatelessWidget {
  const ItemResult({super.key, required this.resultData});
  final ResultData resultData;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    final pr = (resultData.correctAnswer / resultData.totalQuestions * 100).toStringAsFixed(0);
    final dt = resultData.dateTime;
    final time = '${dt.hour.toString().padLeft(2, '0')} : ${dt.minute.toString().padLeft(2, '0')}';
    final date = '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

    return Card(
        // ignore: sort_child_properties_last
        child: ListTile(
          trailing: IconButton(onPressed: () => model.delete(resultData), icon: const Icon(Icons.delete)),
          title: Text('Выполнено $time $date '),
          leading: SizedBox(width: 50, child: Text('$pr %')),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Сложность ${resultData.difficulty ?? 'не выбрана'}'),
              Text('Категория ${resultData.category ?? 'не выбрана'}'),
              Text('Правильных ответов ${resultData.correctAnswer}'),
              Text('Не правильных ответов ${resultData.unCorrectAnswer}')
            ],
          ),
        ),
        elevation: 4);
  }
}
