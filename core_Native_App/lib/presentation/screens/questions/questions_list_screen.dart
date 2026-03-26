// lib/presentation/screens/questions/questions_list_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/database_helper.dart';
import '../../../data/models/question_model.dart';

/// Displays questions by category in a ListView (Flutter equivalent of RecyclerView).
/// Supports smooth scrolling.
class QuestionsListScreen extends StatefulWidget {
  final String category;
  const QuestionsListScreen({super.key, required this.category});

  @override
  State<QuestionsListScreen> createState() => _QuestionsListScreenState();
}

class _QuestionsListScreenState extends State<QuestionsListScreen> {
  final _dbHelper = DatabaseHelper();
  late Future<List<QuestionModel>> _questionsFuture;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _questionsFuture =
        _dbHelper.getQuestionsByCategory(widget.category);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color get _categoryColor {
    switch (widget.category) {
      case 'SQL':
        return const Color(0xFF0891B2);
      case 'HR Questions':
        return const Color(0xFF059669);
      default:
        return AppTheme.primaryPurple;
    }
  }

  IconData get _categoryIcon {
    switch (widget.category) {
      case 'SQL':
        return Icons.storage;
      case 'HR Questions':
        return Icons.people_outline;
      default:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: _categoryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_categoryColor, _categoryColor.withOpacity(0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(_categoryIcon,
                      color: Colors.white.withOpacity(0.2), size: 100),
                ),
              ),
            ),
          ),
          FutureBuilder<List<QuestionModel>>(
            future: _questionsFuture,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppTheme.primaryPurple),
                  ),
                );
              }

              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error loading questions: ${snapshot.error}'),
                  ),
                );
              }

              final questions = snapshot.data ?? [];

              if (questions.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No questions available for this category.'),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _QuestionCard(
                      question: questions[i],
                      index: i,
                      color: _categoryColor,
                    ),
                    childCount: questions.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: _categoryColor,
        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
      ),
    );
  }
}

/// Individual question card widget.
class _QuestionCard extends StatefulWidget {
  final QuestionModel question;
  final int index;
  final Color color;

  const _QuestionCard({
    required this.question,
    required this.index,
    required this.color,
  });

  @override
  State<_QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<_QuestionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${widget.index + 1}',
                        style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.question.question,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.keyboard_arrow_down,
                        color: widget.color, size: 22),
                  ),
                ],
              ),
            ),
          ),
          // Answer (expanded)
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: widget.color.withOpacity(0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: widget.color, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Answer',
                        style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.question.answer,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textDark,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
