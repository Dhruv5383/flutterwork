// lib/presentation/screens/quiz/quiz_screen.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/database_helper.dart';
import '../../../data/models/question_model.dart';

/// Full offline quiz screen.
/// Demonstrates OOP: QuizQuestionModel uses Inheritance from BaseQuestion.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  final _dbHelper = DatabaseHelper();

  List<QuizQuestionModel> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  bool _isLoading = true;

  late AnimationController _animController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animController);
    _loadQuestions();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    final questions = await _dbHelper
        .getRandomQuizQuestions(AppConstants.totalQuizQuestions);
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
    _updateProgress();
  }

  void _updateProgress() {
    if (_questions.isEmpty) return;
    final target = (_currentIndex + 1) / _questions.length;
    _animController.animateTo(target);
  }

  void _selectOption(int option) {
    if (_answered) return;
    setState(() {
      _selectedOption = option;
      _answered = true;
      if (_questions[_currentIndex].isCorrect(option)) {
        _score += AppConstants.pointsPerCorrectAnswer;
      }
    });
  }

  void _next() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
      _updateProgress();
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    final totalMarks = _questions.length * AppConstants.pointsPerCorrectAnswer;
    final percentage = (_score / totalMarks * 100).toStringAsFixed(0);
    final isPassed = _score >= totalMarks * 0.5;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: isPassed
                  ? [AppTheme.successGreen, const Color(0xFF059669)]
                  : [AppTheme.errorRed, const Color(0xFFDC2626)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPassed ? '🎉' : '📚',
                style: const TextStyle(fontSize: 56),
              ),
              const SizedBox(height: 12),
              Text(
                isPassed ? 'Excellent!' : 'Keep Practicing!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Score',
                style:
                    TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '$_score / $totalMarks',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_questions.length - (_score ~/ AppConstants.pointsPerCorrectAnswer)} wrong  •  ${_score ~/ AppConstants.pointsPerCorrectAnswer} correct',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Exit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      setState(() {
                        _currentIndex = 0;
                        _score = 0;
                        _selectedOption = null;
                        _answered = false;
                        _isLoading = true;
                      });
                      _loadQuestions();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: isPassed
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _optionColor(int optionIndex) {
    if (!_answered) return Colors.white;
    final question = _questions[_currentIndex];
    if (optionIndex == question.correctOption) return AppTheme.quizGreen;
    if (optionIndex == _selectedOption) return AppTheme.quizRed;
    return Colors.white;
  }

  Color _optionTextColor(int optionIndex) {
    if (!_answered) return AppTheme.textDark;
    final question = _questions[_currentIndex];
    if (optionIndex == question.correctOption) return Colors.white;
    if (optionIndex == _selectedOption) return Colors.white;
    return AppTheme.textDark;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F3FF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppTheme.primaryPurple),
              const SizedBox(height: 16),
              Text('Loading Quiz...', style: TextStyle(color: AppTheme.textGrey)),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Play Quiz')),
        body: const Center(child: Text('No questions available.')),
      );
    }

    final question = _questions[_currentIndex];
    final totalMarks = _questions.length * AppConstants.pointsPerCorrectAnswer;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryPurple, AppTheme.backgroundPurple],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => _confirmExit(),
                      ),
                      Column(
                        children: [
                          const Text('Questions',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                          Text(
                            '${_currentIndex + 1} / ${_questions.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Marks',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                          Text(
                            '$_score / $totalMarks',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (ctx, _) => LinearProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                              AppTheme.accentOrange),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Category badge
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppTheme.primaryPurple.withOpacity(0.3)),
                        ),
                        child: Text(
                          question.category,
                          style: const TextStyle(
                            color: AppTheme.primaryPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Question card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryPurple,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryPurple.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Options
                    ...List.generate(4, (i) {
                      final optionNumber = i + 1;
                      final optionText = question.options[i];
                      return GestureDetector(
                        onTap: () => _selectOption(optionNumber),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _optionColor(optionNumber),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _answered
                                  ? _optionColor(optionNumber)
                                  : AppTheme.dividerColor,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _answered
                                      ? Colors.white.withOpacity(0.2)
                                      : AppTheme.inputBg,
                                ),
                                child: Center(
                                  child: Text(
                                    ['A', 'B', 'C', 'D'][i],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: _optionTextColor(optionNumber),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  optionText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _optionTextColor(optionNumber),
                                  ),
                                ),
                              ),
                              if (_answered &&
                                  optionNumber == question.correctOption)
                                const Icon(Icons.check_circle,
                                    color: Colors.white, size: 20),
                              if (_answered &&
                                  optionNumber == _selectedOption &&
                                  !question.isCorrect(optionNumber))
                                const Icon(Icons.cancel,
                                    color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    // Feedback
                    if (_answered)
                      AnimatedOpacity(
                        opacity: _answered ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _questions[_currentIndex]
                                    .isCorrect(_selectedOption ?? 0)
                                ? AppTheme.quizGreen.withOpacity(0.1)
                                : AppTheme.quizRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _questions[_currentIndex]
                                      .isCorrect(_selectedOption ?? 0)
                                  ? AppTheme.quizGreen.withOpacity(0.3)
                                  : AppTheme.quizRed.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _questions[_currentIndex]
                                        .isCorrect(_selectedOption ?? 0)
                                    ? Icons.check_circle_outline
                                    : Icons.cancel_outlined,
                                color: _questions[_currentIndex]
                                        .isCorrect(_selectedOption ?? 0)
                                    ? AppTheme.quizGreen
                                    : AppTheme.quizRed,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _questions[_currentIndex]
                                          .isCorrect(_selectedOption ?? 0)
                                      ? 'Correct! Well done!'
                                      : 'Incorrect. Correct answer: ${_questions[_currentIndex].correctAnswer}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _questions[_currentIndex]
                                            .isCorrect(_selectedOption ?? 0)
                                        ? AppTheme.quizGreen
                                        : AppTheme.quizRed,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // Next button
                    if (_answered)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _next,
                          icon: Icon(
                            _currentIndex < _questions.length - 1
                                ? Icons.arrow_forward
                                : Icons.flag,
                          ),
                          label: Text(
                            _currentIndex < _questions.length - 1
                                ? 'Next Question'
                                : 'View Results',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.quizGreen,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmExit() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Exit Quiz?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) Navigator.pop(context);
  }
}
