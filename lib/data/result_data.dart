import 'dart:convert';

class ResultData {
  static const CLASS_NAME = 'ResultData';
  String correctAnswer;
  String unCorrectAnswer;
  DateTime dateTime;
  String? category;
  String? difficulty;
  ResultData({
    required this.correctAnswer,
    required this.unCorrectAnswer,
    required this.dateTime,
    this.category,
    this.difficulty,
  });

  ResultData copyWith({
    String? correctAnswer,
    String? unCorrectAnswer,
    DateTime? dateTime,
    String? category,
    String? difficulty,
  }) {
    return ResultData(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      unCorrectAnswer: unCorrectAnswer ?? this.unCorrectAnswer,
      dateTime: dateTime ?? this.dateTime,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'correctAnswer': correctAnswer,
      'unCorrectAnswer': unCorrectAnswer,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory ResultData.fromMap(Map<String, dynamic> map) {
    return ResultData(
      correctAnswer: map['correctAnswer'],
      unCorrectAnswer: map['unCorrectAnswer'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      category: map['category'],
      difficulty: map['difficulty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultData.fromJson(String source) => ResultData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultData(correctAnswer: $correctAnswer, unCorrectAnswer: $unCorrectAnswer, dateTime: $dateTime, category: $category, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultData &&
        other.correctAnswer == correctAnswer &&
        other.unCorrectAnswer == unCorrectAnswer &&
        other.dateTime == dateTime &&
        other.category == category &&
        other.difficulty == difficulty;
  }

  @override
  int get hashCode {
    return correctAnswer.hashCode ^
        unCorrectAnswer.hashCode ^
        dateTime.hashCode ^
        category.hashCode ^
        difficulty.hashCode;
  }
}
