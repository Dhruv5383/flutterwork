// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'ECORP';
  static const String appTagline = 'E-Learning for Interview Prep';
  static const String appVersion = '1.0.0';
  static const String developerName = 'ECORP Dev Team';
  static const String contactEmail = 'support@ecorp.com';
  static const String contactPhone = '+91 98765 43210';
  static const String aboutUs =
      'ECORP is a premier e-learning platform designed to help candidates '
      'prepare for technical and HR interviews. Our curated question bank '
      'covers Fundamentals, SQL, and HR topics to give you the edge you need.';

  // SharedPreferences Keys
  static const String prefIsLoggedIn = 'isLoggedIn';
  static const String prefUserId = 'userId';
  static const String prefUserName = 'userName';
  static const String prefUserEmail = 'userEmail';

  // Database
  static const String dbName = 'ecorp_elearning.db';
  static const int dbVersion = 1;

  // Tables
  static const String tableUsers = 'users';
  static const String tableQuestions = 'questions';
  static const String tableQuizQuestions = 'quiz_questions';

  // Quiz settings
  static const int totalQuizQuestions = 10;
  static const int pointsPerCorrectAnswer = 5;

  // Categories
  static const String categoryFundamentals = 'Fundamentals';
  static const String categorySQL = 'SQL';
  static const String categoryHR = 'HR Questions';

  // Validation
  static const int minPasswordLength = 6;
  static final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{6,}$');
  static final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]{2,50}$');
}
