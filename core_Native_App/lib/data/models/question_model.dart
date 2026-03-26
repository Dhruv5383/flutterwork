// lib/data/models/question_model.dart

/// Base class for all questions - demonstrates Inheritance & Encapsulation.
abstract class BaseQuestion {
  final int? _id;
  final String _question;
  final String _category;

  BaseQuestion({
    int? id,
    required String question,
    required String category,
  })  : _id = id,
        _question = question,
        _category = category;

  int? get id => _id;
  String get question => _question;
  String get category => _category;

  Map<String, dynamic> toMap();
}

/// Represents a Q&A-style question used in the Read Questions section.
/// Inherits from BaseQuestion (Inheritance).
class QuestionModel extends BaseQuestion {
  final String _answer;

  QuestionModel({
    int? id,
    required String question,
    required String category,
    required String answer,
  })  : _answer = answer,
        super(id: id, question: question, category: category);

  String get answer => _answer;

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'question': question,
      'category': category,
      'answer': _answer,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int?,
      question: map['question'] as String,
      category: map['category'] as String,
      answer: map['answer'] as String,
    );
  }

  @override
  String toString() =>
      'QuestionModel(id: $id, category: $category, question: $question)';
}

/// Represents a multiple-choice quiz question.
/// Inherits from BaseQuestion (Inheritance).
class QuizQuestionModel extends BaseQuestion {
  final String _option1;
  final String _option2;
  final String _option3;
  final String _option4;
  final int _correctOption; // 1-4

  QuizQuestionModel({
    int? id,
    required String question,
    required String category,
    required String option1,
    required String option2,
    required String option3,
    required String option4,
    required int correctOption,
  })  : _option1 = option1,
        _option2 = option2,
        _option3 = option3,
        _option4 = option4,
        _correctOption = correctOption,
        super(id: id, question: question, category: category);

  String get option1 => _option1;
  String get option2 => _option2;
  String get option3 => _option3;
  String get option4 => _option4;
  int get correctOption => _correctOption;

  String get correctAnswer {
    switch (_correctOption) {
      case 1:
        return _option1;
      case 2:
        return _option2;
      case 3:
        return _option3;
      case 4:
        return _option4;
      default:
        return _option1;
    }
  }

  List<String> get options => [_option1, _option2, _option3, _option4];

  bool isCorrect(int selectedOption) => selectedOption == _correctOption;

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'question': question,
      'category': category,
      'option1': _option1,
      'option2': _option2,
      'option3': _option3,
      'option4': _option4,
      'correctOption': _correctOption,
    };
  }

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizQuestionModel(
      id: map['id'] as int?,
      question: map['question'] as String,
      category: map['category'] as String,
      option1: map['option1'] as String,
      option2: map['option2'] as String,
      option3: map['option3'] as String,
      option4: map['option4'] as String,
      correctOption: map['correctOption'] as int,
    );
  }

  @override
  String toString() =>
      'QuizQuestionModel(id: $id, category: $category, correctOption: $_correctOption)';
}
