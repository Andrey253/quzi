import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quzi/data/quzi_model.dart';
import 'package:quzi/data/result_data.dart';
import 'package:quzi/repos/store.dart';

class Model with ChangeNotifier {
  int score = 0;
  List<QuziData> questions = [];
  List<ResultData> resultList = [];
  Map<int, dynamic> answers = {};
  String? category;
  String? difficulty;
  Store store = Store();

  QuziData question(int i) {
    return questions[i];
  }

  Future<void> loadQuestions() async {
    sended = false;
    score = 0;
    notifyListeners();
    answers = {};
    try {
      var queryParameters = {'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa'};
      if (category != null) {
        queryParameters.addAll({'category': category!});
      }
      if (difficulty != null) {
        queryParameters.addAll({'difficulty': difficulty!});
      }
      final responseDio = await Dio().get('https://quizapi.io/api/v1/questions',
          queryParameters: queryParameters, options: Options(responseType: ResponseType.json));

      if (responseDio.statusCode == 200) {
        questions = (responseDio.data as List).map((e) => QuziData.fromMap(e)).toList();
      }
      questions.shuffle();
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      questions = [];
      notifyListeners();
    } finally {}
  }

  void onChanged(int index, dynamic item) {
    // if (answers[question(index).id] == null) return;
    var indexOf = question(index).answers.indexOf(item);
    answers.addAll({index: indexOf});
    score = 0;
    answers.forEach((key, value) {
      if (questions[key].correctAnswers.indexOf('true') == answers[key]) {
        score++;
      }
    });
    notifyListeners();
  }

  bool selected(int index, String itemQuest) {
    return answers[index] == question(index).answers.indexOf(itemQuest);
  }

  Color getColor(dynamic itemQuest, int index) =>
      question(index).answers.indexOf(itemQuest) == answers[index] ? Colors.green.shade100 : Colors.white;

  groupValue(int index) => answers.length > index ? question(index).answers[answers[index]] : null;

  void setCategory(String? d) {
    category = d;
    notifyListeners();
  }

  void setDifficulty(String? d) {
    difficulty = d;
    notifyListeners();
  }

  Future<bool> sendResult() async {
    isLoading = true;
    notifyListeners();
    final res = ResultData(
        totalQuestions: questions.length,
        category: category,
        difficulty: difficulty,
        correctAnswer: answers.length,
        unCorrectAnswer: (questions.length - answers.length),
        dateTime: DateTime.now());
    await store.sendResult(res);
    sended = true;
    isLoading = false;
    notifyListeners();
    return true;
  }

  bool sended = false;
  bool isLoading = false;
  getResult() async {
    isLoading = true;
    notifyListeners();
    resultList = await store.getResult();
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(ResultData resultData) async {
    await store.delete(resultData);
    getResult();
  }

  restart(BuildContext context) {
    category == null;
    difficulty = null;
    Navigator.pushNamedAndRemoveUntil(context, '/',(d)=>false);
  }
}
