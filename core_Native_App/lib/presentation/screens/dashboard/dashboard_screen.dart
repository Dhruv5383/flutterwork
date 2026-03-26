// lib/presentation/screens/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/preferences/pref_service.dart';
import '../auth/login_screen.dart';
import '../quiz/quiz_screen.dart';
import '../questions/categories_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final _prefService = PrefService();
  late AnimationController _animController;
  late List<Animation<double>> _cardAnimations;

  final _gridItems = [
    _GridItem(
      title: 'Play Quiz',
      subtitle: 'Test your knowledge',
      icon: Icons.quiz_outlined,
      color: AppTheme.primaryPurple,
      gradientEnd: AppTheme.lightPurple,
    ),
    _GridItem(
      title: 'Read Questions',
      subtitle: 'Study by category',
      icon: Icons.menu_book_outlined,
      color: const Color(0xFF0891B2),
      gradientEnd: const Color(0xFF06B6D4),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _cardAnimations = List.generate(
      _gridItems.length,
      (i) => CurvedAnimation(
        parent: _animController,
        curve: Interval(i * 0.2, 0.6 + i * 0.2, curve: Curves.easeOut),
      ),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _prefService.clearUserSession();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (_) => false,
        );
      }
    }
  }

  void _showAboutUs() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'E',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('About ECORP'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.aboutUs,
              style: const TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 12),
            const Text(
              'Version ${AppConstants.appVersion}',
              style: TextStyle(
                color: AppTheme.textGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactUs() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Contact Us'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _contactRow(Icons.email_outlined, 'Email',
                AppConstants.contactEmail),
            const SizedBox(height: 12),
            _contactRow(Icons.phone_outlined, 'Phone',
                AppConstants.contactPhone),
            const SizedBox(height: 12),
            _contactRow(Icons.web_outlined, 'Website', 'www.ecorp.com'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryPurple, size: 20),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textGrey)),
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstName = widget.userName.split(' ').first;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('ECORP'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              switch (value) {
                case 'about':
                  _showAboutUs();
                  break;
                case 'contact':
                  _showContactUs();
                  break;
                case 'logout':
                  _logout();
                  break;
              }
            },
            itemBuilder: (ctx) => [
              _buildMenuItem('about', Icons.info_outline, 'About Us'),
              _buildMenuItem(
                  'contact', Icons.contact_mail_outlined, 'Contact Us'),
              const PopupMenuDivider(),
              _buildMenuItem(
                  'logout', Icons.logout, 'Logout',
                  color: AppTheme.errorRed),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryPurple, AppTheme.backgroundPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor:
                            AppTheme.accentOrange.withOpacity(0.9),
                        child: Text(
                          firstName.isNotEmpty
                              ? firstName[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $firstName! 👋',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'Ready to ace your interview?',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _statsRow(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What would you like to do?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _gridItems.length,
                    itemBuilder: (ctx, i) {
                      return ScaleTransition(
                        scale: _cardAnimations[i],
                        child: _buildGridCard(_gridItems[i], i),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  _categorySection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statChip(Icons.quiz, '3 Categories'),
        const SizedBox(width: 10),
        _statChip(Icons.question_answer, '24+ Questions'),
      ],
    );
  }

  Widget _statChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGridCard(_GridItem item, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const QuizScreen()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CategoriesScreen()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [item.color, item.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categorySection() {
    final cats = [
      _CatItem('Fundamentals', Icons.code, AppTheme.primaryPurple),
      _CatItem('SQL', Icons.storage, const Color(0xFF0891B2)),
      _CatItem('HR Questions', Icons.people_outline, const Color(0xFF059669)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Browse Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        ...cats.map(
          (cat) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CategoriesScreen()),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cat.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(cat.icon, color: cat.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    cat.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppTheme.textGrey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      String value, IconData icon, String text,
      {Color? color}) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppTheme.textDark),
          const SizedBox(width: 10),
          Text(text,
              style: TextStyle(color: color ?? AppTheme.textDark)),
        ],
      ),
    );
  }
}

class _GridItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color gradientEnd;

  _GridItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.gradientEnd,
  });
}

class _CatItem {
  final String name;
  final IconData icon;
  final Color color;
  _CatItem(this.name, this.icon, this.color);
}
