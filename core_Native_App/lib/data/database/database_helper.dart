// lib/data/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/question_model.dart';
import '../../core/constants/app_constants.dart';

/// Singleton database helper for managing SQLite operations.
/// Implements all CRUD operations for users, questions, and quiz questions.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);

    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableUsers} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        passwordHash TEXT NOT NULL
      )
    ''');

    // Create Questions table (for Read Questions)
    await db.execute('''
      CREATE TABLE ${AppConstants.tableQuestions} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        category TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');

    // Create Quiz Questions table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableQuizQuestions} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        category TEXT NOT NULL,
        option1 TEXT NOT NULL,
        option2 TEXT NOT NULL,
        option3 TEXT NOT NULL,
        option4 TEXT NOT NULL,
        correctOption INTEGER NOT NULL
      )
    ''');

    // Seed data
    await _seedQuestions(db);
    await _seedQuizQuestions(db);
  }

  // ─────────────────────────────── USER CRUD ────────────────────────────────

  /// INSERT: Register a new user.
  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert(
      AppConstants.tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  /// READ: Get user by email and password hash.
  Future<UserModel?> getUserByCredentials(
      String email, String passwordHash) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableUsers,
      where: 'email = ? AND passwordHash = ?',
      whereArgs: [email.trim().toLowerCase(), passwordHash],
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// READ: Check if email already exists.
  Future<bool> emailExists(String email) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableUsers,
      where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()],
    );
    return maps.isNotEmpty;
  }

  /// READ: Get user by ID.
  Future<UserModel?> getUserById(int id) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// UPDATE: Update user details.
  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      AppConstants.tableUsers,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// DELETE: Delete user by ID.
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ──────────────────────────── QUESTION CRUD ───────────────────────────────

  /// READ: Get all questions by category.
  Future<List<QuestionModel>> getQuestionsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableQuestions,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'id ASC',
    );
    return maps.map((m) => QuestionModel.fromMap(m)).toList();
  }

  /// READ: Get all questions.
  Future<List<QuestionModel>> getAllQuestions() async {
    final db = await database;
    final maps =
        await db.query(AppConstants.tableQuestions, orderBy: 'category, id');
    return maps.map((m) => QuestionModel.fromMap(m)).toList();
  }

  /// INSERT: Add a new question.
  Future<int> insertQuestion(QuestionModel question) async {
    final db = await database;
    return await db.insert(AppConstants.tableQuestions, question.toMap());
  }

  /// UPDATE: Update a question.
  Future<int> updateQuestion(QuestionModel question) async {
    final db = await database;
    return await db.update(
      AppConstants.tableQuestions,
      question.toMap(),
      where: 'id = ?',
      whereArgs: [question.id],
    );
  }

  /// DELETE: Delete a question.
  Future<int> deleteQuestion(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableQuestions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ─────────────────────────── QUIZ QUESTION CRUD ───────────────────────────

  /// READ: Get random quiz questions (limited).
  Future<List<QuizQuestionModel>> getRandomQuizQuestions(int limit) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableQuizQuestions,
      orderBy: 'RANDOM()',
      limit: limit,
    );
    return maps.map((m) => QuizQuestionModel.fromMap(m)).toList();
  }

  /// READ: Get quiz questions by category.
  Future<List<QuizQuestionModel>> getQuizQuestionsByCategory(
      String category) async {
    final db = await database;
    final maps = await db.query(
      AppConstants.tableQuizQuestions,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'RANDOM()',
    );
    return maps.map((m) => QuizQuestionModel.fromMap(m)).toList();
  }

  // ─────────────────────────────── SEED DATA ────────────────────────────────

  Future<void> _seedQuestions(Database db) async {
    final questions = [
      // Fundamentals
      {
        'question': 'What is Object-Oriented Programming (OOP)?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'OOP is a programming paradigm based on the concept of "objects" which contain data (fields/attributes) and code (methods/functions). The four main principles are Encapsulation, Inheritance, Polymorphism, and Abstraction.',
      },
      {
        'question': 'What is the difference between Stack and Heap memory?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Stack memory is used for static memory allocation (local variables, function calls) and is faster but limited. Heap memory is used for dynamic memory allocation and is larger but slower and requires manual management (or garbage collection).',
      },
      {
        'question': 'What is a Design Pattern? Name some common ones.',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Design patterns are reusable solutions to commonly occurring problems. Common ones include: Singleton (one instance), Factory (object creation), Observer (event handling), MVC (Model-View-Controller), and Repository (data access).',
      },
      {
        'question': 'What is the difference between Abstraction and Encapsulation?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Abstraction hides implementation complexity and shows only essential features. Encapsulation bundles data and methods together and restricts direct access to internal state, usually via access modifiers (private, public).',
      },
      {
        'question': 'What is a RESTful API?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'REST (Representational State Transfer) API is an architectural style for distributed systems. It uses HTTP methods (GET, POST, PUT, DELETE), is stateless, and communicates in JSON/XML format. Resources are identified by URLs.',
      },
      {
        'question': 'What is Polymorphism?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Polymorphism allows objects of different classes to be treated as objects of a common superclass. It comes in two types: Compile-time (method overloading) and Runtime (method overriding). It enables flexible and extensible code.',
      },
      {
        'question': 'Explain the concept of Recursion.',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Recursion is a programming technique where a function calls itself to solve smaller instances of the same problem. It has a base case (stopping condition) and a recursive case. Examples: factorial, Fibonacci, tree traversal.',
      },
      {
        'question': 'What is the difference between synchronous and asynchronous programming?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Synchronous: operations execute sequentially, blocking until each completes. Asynchronous: operations can execute concurrently without blocking the main thread. Async is crucial for I/O operations (network calls, file reading) to keep UI responsive.',
      },
      {
        'question': 'What is a linked list?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'A linked list is a linear data structure where elements (nodes) are stored in non-contiguous memory locations. Each node contains data and a pointer to the next node. Types: Singly linked, Doubly linked, Circular linked list.',
      },
      {
        'question': 'What is Big O Notation?',
        'category': AppConstants.categoryFundamentals,
        'answer':
            'Big O notation describes the performance or complexity of an algorithm. It shows how runtime or space requirements grow relative to input size. Common: O(1) constant, O(n) linear, O(log n) logarithmic, O(n²) quadratic.',
      },
      // SQL
      {
        'question': 'What is the difference between INNER JOIN and OUTER JOIN?',
        'category': AppConstants.categorySQL,
        'answer':
            'INNER JOIN returns only matching rows from both tables. OUTER JOIN returns matched rows plus unmatched rows from one or both tables. Types of OUTER JOIN: LEFT (all from left + matches from right), RIGHT, FULL OUTER JOIN.',
      },
      {
        'question': 'What is normalization in databases?',
        'category': AppConstants.categorySQL,
        'answer':
            'Normalization is the process of organizing database tables to reduce redundancy and improve data integrity. Normal forms: 1NF (atomic values), 2NF (no partial dependency), 3NF (no transitive dependency), BCNF.',
      },
      {
        'question': 'What is an Index in SQL and why is it used?',
        'category': AppConstants.categorySQL,
        'answer':
            'An index is a database structure that improves the speed of data retrieval operations. It works like a book index, allowing the database engine to find data quickly without scanning all rows. Trade-off: speeds up reads but slows writes.',
      },
      {
        'question': 'What is the difference between DELETE, TRUNCATE, and DROP?',
        'category': AppConstants.categorySQL,
        'answer':
            'DELETE: removes specific rows (can have WHERE clause), logged, can rollback. TRUNCATE: removes all rows quickly, minimal logging, cannot rollback in some DBs. DROP: removes the entire table structure and data permanently.',
      },
      {
        'question': 'What are ACID properties in a database?',
        'category': AppConstants.categorySQL,
        'answer':
            'ACID stands for: Atomicity (all or nothing), Consistency (data remains valid), Isolation (transactions don\'t interfere), Durability (committed data persists). These properties guarantee reliable transaction processing.',
      },
      {
        'question': 'What is a stored procedure?',
        'category': AppConstants.categorySQL,
        'answer':
            'A stored procedure is a precompiled set of SQL statements stored in the database. Benefits: code reuse, better performance (precompiled), security (grant execute without table access), reduced network traffic.',
      },
      {
        'question': 'What is a Primary Key vs Foreign Key?',
        'category': AppConstants.categorySQL,
        'answer':
            'Primary Key: uniquely identifies each row in a table, cannot be NULL or duplicate. Foreign Key: a column that references the Primary Key of another table, establishes a relationship between tables and enforces referential integrity.',
      },
      {
        'question': 'What is GROUP BY in SQL?',
        'category': AppConstants.categorySQL,
        'answer':
            'GROUP BY groups rows with the same values into summary rows. Used with aggregate functions (COUNT, SUM, AVG, MAX, MIN). HAVING clause filters groups (like WHERE but for groups). Example: SELECT dept, COUNT(*) FROM emp GROUP BY dept.',
      },
      // HR Questions
      {
        'question': 'Tell me about yourself.',
        'category': AppConstants.categoryHR,
        'answer':
            'Structure with the Present-Past-Future formula: Start with your current role/skills, briefly mention relevant past experience, then express what you\'re looking for. Keep it professional, concise (2-3 minutes), and relevant to the job. Practice it to sound natural, not rehearsed.',
      },
      {
        'question': 'What are your greatest strengths?',
        'category': AppConstants.categoryHR,
        'answer':
            'Choose 2-3 strengths relevant to the role. Use the STAR method to demonstrate with examples. Good examples: problem-solving, adaptability, communication, leadership, attention to detail. Back each strength with a specific professional example.',
      },
      {
        'question': 'What is your greatest weakness?',
        'category': AppConstants.categoryHR,
        'answer':
            'Choose a genuine weakness that isn\'t critical to the job. Show self-awareness and focus on what you\'re doing to improve. Example: "I used to struggle with public speaking, so I joined Toastmasters and have since led 5+ team presentations."',
      },
      {
        'question': 'Where do you see yourself in 5 years?',
        'category': AppConstants.categoryHR,
        'answer':
            'Show ambition aligned with the company\'s growth. Mention developing skills, taking on more responsibility, and contributing to the company\'s mission. Avoid mentioning competitor companies or positions that require leaving. Research the company\'s career paths.',
      },
      {
        'question': 'Why do you want to work for our company?',
        'category': AppConstants.categoryHR,
        'answer':
            'Research the company before your interview. Mention specific things: company culture, values, products, recent achievements, growth trajectory. Connect their offerings to your career goals. Show genuine enthusiasm and knowledge about the organization.',
      },
      {
        'question': 'Describe a challenging situation and how you handled it.',
        'category': AppConstants.categoryHR,
        'answer':
            'Use the STAR method: Situation (context), Task (your responsibility), Action (what you did, focus here), Result (positive outcome). Choose a real professional example. Quantify results where possible. Show your problem-solving and resilience.',
      },
    ];

    final batch = db.batch();
    for (final q in questions) {
      batch.insert(AppConstants.tableQuestions, q);
    }
    await batch.commit(noResult: true);
  }

  Future<void> _seedQuizQuestions(Database db) async {
    final quizQuestions = [
      // Fundamentals Quiz
      {
        'question': 'Which OOP principle hides internal details of an object?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'Inheritance',
        'option2': 'Polymorphism',
        'option3': 'Encapsulation',
        'option4': 'Abstraction',
        'correctOption': 3,
      },
      {
        'question': 'What does SOLID stand for in software engineering?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'Single, Open, Liskov, Interface, Dependency',
        'option2': 'Simple, Object, Linear, Inheritance, Design',
        'option3': 'Single, Optimized, Linked, Interface, Dynamic',
        'option4': 'Separation, Object, Linked, Instance, Dependency',
        'correctOption': 1,
      },
      {
        'question': 'Which data structure uses LIFO (Last In First Out) order?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'Queue',
        'option2': 'Stack',
        'option3': 'Linked List',
        'option4': 'Array',
        'correctOption': 2,
      },
      {
        'question': 'What is the time complexity of binary search?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'O(n)',
        'option2': 'O(n²)',
        'option3': 'O(log n)',
        'option4': 'O(1)',
        'correctOption': 3,
      },
      {
        'question': 'Which HTTP method is used to UPDATE an existing resource?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'GET',
        'option2': 'POST',
        'option3': 'DELETE',
        'option4': 'PUT',
        'correctOption': 4,
      },
      {
        'question': 'What is a Constructor in OOP?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'A method that destroys an object',
        'option2': 'A special method that initializes a new object',
        'option3': 'A type of loop structure',
        'option4': 'A design pattern',
        'correctOption': 2,
      },
      {
        'question': 'Which sorting algorithm has O(n log n) average complexity?',
        'category': AppConstants.categoryFundamentals,
        'option1': 'Bubble Sort',
        'option2': 'Selection Sort',
        'option3': 'Merge Sort',
        'option4': 'Insertion Sort',
        'correctOption': 3,
      },
      // SQL Quiz
      {
        'question': 'Which SQL command retrieves data from a database?',
        'category': AppConstants.categorySQL,
        'option1': 'INSERT',
        'option2': 'UPDATE',
        'option3': 'SELECT',
        'option4': 'DELETE',
        'correctOption': 3,
      },
      {
        'question': 'Which JOIN returns all rows from both tables?',
        'category': AppConstants.categorySQL,
        'option1': 'INNER JOIN',
        'option2': 'LEFT JOIN',
        'option3': 'RIGHT JOIN',
        'option4': 'FULL OUTER JOIN',
        'correctOption': 4,
      },
      {
        'question': 'What does the DISTINCT keyword do in SQL?',
        'category': AppConstants.categorySQL,
        'option1': 'Sorts the results',
        'option2': 'Returns only unique values',
        'option3': 'Filters null values',
        'option4': 'Groups the results',
        'correctOption': 2,
      },
      {
        'question': 'Which aggregate function counts non-NULL values?',
        'category': AppConstants.categorySQL,
        'option1': 'SUM()',
        'option2': 'AVG()',
        'option3': 'COUNT()',
        'option4': 'MAX()',
        'correctOption': 3,
      },
      {
        'question': 'What constraint ensures no duplicate values in a column?',
        'category': AppConstants.categorySQL,
        'option1': 'NOT NULL',
        'option2': 'PRIMARY KEY',
        'option3': 'UNIQUE',
        'option4': 'FOREIGN KEY',
        'correctOption': 3,
      },
      {
        'question': 'Which clause filters results AFTER grouping?',
        'category': AppConstants.categorySQL,
        'option1': 'WHERE',
        'option2': 'HAVING',
        'option3': 'ORDER BY',
        'option4': 'GROUP BY',
        'correctOption': 2,
      },
      // HR Quiz
      {
        'question': 'What does STAR stand for in interview techniques?',
        'category': AppConstants.categoryHR,
        'option1': 'Skill, Task, Action, Result',
        'option2': 'Situation, Task, Action, Result',
        'option3': 'Strategy, Team, Approach, Role',
        'option4': 'Situation, Target, Assess, Respond',
        'correctOption': 2,
      },
      {
        'question': 'When asked "What is your weakness?", the best approach is:',
        'category': AppConstants.categoryHR,
        'option1': 'Say you have no weaknesses',
        'option2': 'Mention a core skill weakness',
        'option3': 'Show a real weakness with improvement steps',
        'option4': 'Talk about a personal non-work weakness',
        'correctOption': 3,
      },
      {
        'question': 'What is the ideal length for answering "Tell me about yourself"?',
        'category': AppConstants.categoryHR,
        'option1': '30 seconds',
        'option2': '2-3 minutes',
        'option3': '10 minutes',
        'option4': '5-7 minutes',
        'correctOption': 2,
      },
    ];

    final batch = db.batch();
    for (final q in quizQuestions) {
      batch.insert(AppConstants.tableQuizQuestions, q);
    }
    await batch.commit(noResult: true);
  }
}
