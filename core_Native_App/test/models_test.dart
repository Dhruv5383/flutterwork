// test/models_test.dart

import 'package:core_native_app/core/utils/password_helper.dart';
import 'package:core_native_app/data/models/question_model.dart';
import 'package:core_native_app/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:ecorp_elearning/data/models/user_model.dart';
//import 'package:ecorp_elearning/data/models/question_model.dart';
//import 'package:ecorp_elearning/core/utils/password_helper.dart';

void main() {
  group('UserModel', () {
    test('fullName returns correct concatenation', () {
      final user = UserModel(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        passwordHash: 'hash',
      );
      expect(user.fullName, 'John Doe');
    });

    test('toMap and fromMap round-trip', () {
      final user = UserModel(
        id: 1,
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        passwordHash: 'abc123',
      );
      final map = user.toMap();
      final restored = UserModel.fromMap(map);
      expect(restored.firstName, user.firstName);
      expect(restored.lastName, user.lastName);
      expect(restored.email, user.email);
      expect(restored.passwordHash, user.passwordHash);
    });

    test('Setter updates field', () {
      final user = UserModel(
        firstName: 'Old',
        lastName: 'Name',
        email: 'old@example.com',
        passwordHash: 'hash',
      );
      user.firstName = 'New';
      expect(user.firstName, 'New');
    });
  });

  group('QuizQuestionModel - Inheritance', () {
    final quiz = QuizQuestionModel(
      question: 'What is Flutter?',
      category: 'Fundamentals',
      option1: 'A framework',
      option2: 'A language',
      option3: 'A database',
      option4: 'An IDE',
      correctOption: 1,
    );

    test('isCorrect returns true for correct option', () {
      expect(quiz.isCorrect(1), isTrue);
    });

    test('isCorrect returns false for wrong option', () {
      expect(quiz.isCorrect(2), isFalse);
    });

    test('correctAnswer returns the correct option text', () {
      expect(quiz.correctAnswer, 'A framework');
    });

    test('options list has 4 items', () {
      expect(quiz.options.length, 4);
    });

    test('Inherits category from BaseQuestion', () {
      expect(quiz.category, 'Fundamentals');
    });
  });

  group('QuestionModel - Inheritance', () {
    final question = QuestionModel(
      question: 'What is OOP?',
      category: 'Fundamentals',
      answer: 'Object-Oriented Programming',
    );

    test('Inherits question from BaseQuestion', () {
      expect(question.question, 'What is OOP?');
    });

    test('toMap includes answer', () {
      final map = question.toMap();
      expect(map.containsKey('answer'), isTrue);
    });
  });

  group('PasswordHelper', () {
    test('Same password produces same hash', () {
      final h1 = PasswordHelper.hashPassword('Secret123');
      final h2 = PasswordHelper.hashPassword('Secret123');
      expect(h1, equals(h2));
    });

    test('Different passwords produce different hashes', () {
      final h1 = PasswordHelper.hashPassword('Secret123');
      final h2 = PasswordHelper.hashPassword('Secret456');
      expect(h1, isNot(equals(h2)));
    });

    test('verifyPassword returns true for correct password', () {
      final hash = PasswordHelper.hashPassword('MyPass99');
      expect(PasswordHelper.verifyPassword('MyPass99', hash), isTrue);
    });

    test('verifyPassword returns false for wrong password', () {
      final hash = PasswordHelper.hashPassword('MyPass99');
      expect(PasswordHelper.verifyPassword('WrongPass1', hash), isFalse);
    });
  });
}
