import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quzi/data/firestore_abstract.dart';

class ResultData extends FireStoreObject{
  // ignore: constant_identifier_names
  static const CLASS_NAME = 'ResultData';
  int correctAnswer;
  int unCorrectAnswer;
  int totalQuestions;
  DateTime dateTime;
  String? category;
  String? difficulty;
  ResultData({
    required this.correctAnswer,
    required this.unCorrectAnswer,
    required this.totalQuestions,
    required this.dateTime,
    this.category,
    this.difficulty,
  });

  ResultData copyWith({
    int? correctAnswer,
    int? unCorrectAnswer,
    int? totalQuestions,
    DateTime? dateTime,
    String? category,
    String? difficulty,
  }) {
    return ResultData(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      unCorrectAnswer: unCorrectAnswer ?? this.unCorrectAnswer,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      dateTime: dateTime ?? this.dateTime,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'correctAnswer': correctAnswer,
      'unCorrectAnswer': unCorrectAnswer,
      'totalQuestions': totalQuestions,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'category': category,
      'difficulty': difficulty,
    };
  }

  static ResultData fromFire(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    final map = data.data();
    return ResultData.fromMap(map)..id = data.reference.path;
  }

  factory ResultData.fromMap(Map<String, dynamic> map) {
    return ResultData(
      correctAnswer: map['correctAnswer'],
      unCorrectAnswer: map['unCorrectAnswer'],
      totalQuestions: map['totalQuestions'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      category: map['category'],
      difficulty: map['difficulty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultData.fromJson(String source) => ResultData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultData(correctAnswer: $correctAnswer, unCorrectAnswer: $unCorrectAnswer, totalQuestions: $totalQuestions, dateTime: $dateTime, category: $category, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultData &&
        other.correctAnswer == correctAnswer &&
        other.unCorrectAnswer == unCorrectAnswer &&
        other.totalQuestions == totalQuestions &&
        other.dateTime == dateTime &&
        other.category == category &&
        other.difficulty == difficulty;
  }

  @override
  int get hashCode {
    return correctAnswer.hashCode ^
        unCorrectAnswer.hashCode ^
        totalQuestions.hashCode ^
        dateTime.hashCode ^
        category.hashCode ^
        difficulty.hashCode;
  }
}
