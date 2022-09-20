import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuziData {
  int? id;
  String? question;
  dynamic description;
  List answers;
  String? multipleCorrectAnswers;
  List correctAnswers;
  String? correctAnswer;

  List<dynamic>? tags;
  String? category;
  String? difficulty;
  QuziData({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    this.correctAnswer,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  QuziData copyWith({
    int? id,
    String? question,
    dynamic description,
    List? answers,
    String? multipleCorrectAnswers,
    List? correctAnswers,
    String? correctAnswer,
    List<String>? tags,
    String? category,
    String? difficulty,
  }) {
    return QuziData(
      id: id ?? this.id,
      question: question ?? this.question,
      description: description ?? this.description,
      answers: answers ?? this.answers,
      multipleCorrectAnswers: multipleCorrectAnswers ?? this.multipleCorrectAnswers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'description': description,
      'answers': answers,
      'multipleCorrectAnswers': multipleCorrectAnswers,
      'correctAnswers': correctAnswers,
      'correctAnswer': correctAnswer,
      'tags': tags,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory QuziData.fromMap(Map<String, dynamic> map) {
    return QuziData(
      id: map['id'],
      question: map['question'],
      description: map['description'],
      answers: map['answers'] == null ? [] : Map<String, dynamic>.from(map['answers']).values.toList(),
      multipleCorrectAnswers: map['multipleCorrectAnswers'],
      correctAnswers:
          map['correct_answers'] == null ? [] : Map<String, String>.from(map['correct_answers']).values.toList(),
      correctAnswer: map['correct_answer'],
      tags: map['tags'] == null ? null : List<dynamic>.from(map['tags']),
      category: map['category'],
      difficulty: map['difficulty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuziData.fromJson(String source) => QuziData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuziApi(id: $id, question: $question, description: $description, answers: $answers, multipleCorrectAnswers: $multipleCorrectAnswers, correctAnswers: $correctAnswers, correctAnswer: $correctAnswer, tags: $tags, category: $category, difficulty: $difficulty)';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        description.hashCode ^
        answers.hashCode ^
        multipleCorrectAnswers.hashCode ^
        correctAnswers.hashCode ^
        correctAnswer.hashCode ^
        tags.hashCode ^
        category.hashCode ^
        difficulty.hashCode;
  }
}
