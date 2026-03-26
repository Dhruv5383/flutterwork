// lib/presentation/screens/questions/categories_screen.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import 'questions_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static final _categories = [
    _Category(
      name: AppConstants.categoryFundamentals,
      description: 'OOP, Data Structures, Algorithms, and more',
      icon: Icons.code,
      color: AppTheme.primaryPurple,
      gradientEnd: AppTheme.lightPurple,
      questionCount: '10 Questions',
    ),
    _Category(
      name: AppConstants.categorySQL,
      description: 'Database concepts, Queries, Joins & Normalization',
      icon: Icons.storage,
      color: const Color(0xFF0891B2),
      gradientEnd: const Color(0xFF0284C7),
      questionCount: '8 Questions',
    ),
    _Category(
      name: AppConstants.categoryHR,
      description: 'Behavioral, situational & communication questions',
      icon: Icons.people_outline,
      color: const Color(0xFF059669),
      gradientEnd: const Color(0xFF047857),
      questionCount: '6 Questions',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read Questions')),
      backgroundColor: const Color(0xFFF5F3FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryPurple, AppTheme.backgroundPurple],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Study questions organized by topic',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _categories.length,
              itemBuilder: (ctx, i) => _CategoryCard(
                category: _categories[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        QuestionsListScreen(category: _categories[i].name),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _Category category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category.color, category.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(category.icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.questionCount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white70, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _Category {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final Color gradientEnd;
  final String questionCount;

  _Category({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.gradientEnd,
    required this.questionCount,
  });
}
