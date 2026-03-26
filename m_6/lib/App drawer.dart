// lib/widgets/app_drawer.dart

import 'package:flutter/material.dart';
//import '../utils/constants.dart';
//import '../services/auth_service.dart';
import 'Auth service.dart';
import 'Constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthService _authService = AuthService();
  String _userName = 'User';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _authService.getCurrentUser();
    if (mounted) {
      setState(() {
        _userName = user['name'] ?? 'User';
        _userEmail = user['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userEmail,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '✓ Verified User',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _drawerItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.home, (r) => false);
                  },
                ),
                _drawerItem(
                  icon: Icons.calendar_today_rounded,
                  label: 'My Bookings',
                  badge: '2',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.myBookings);
                  },
                ),
                _drawerItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                ),
                _drawerItem(
                  icon: Icons.headset_mic_rounded,
                  label: 'Contact Us',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.contactUs);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                _drawerItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings coming soon!')),
                    );
                  },
                ),
                _drawerItem(
                  icon: Icons.info_rounded,
                  label: 'About App',
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
                const SizedBox(height: 8),
                // Logout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'MyCityConnect v1.0.0',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? badge,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: badge != null
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 11)),
      )
          : const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 18),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: AppColors.primary.withOpacity(0.05),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _authService.logout();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.location_city, color: AppColors.primary),
            SizedBox(width: 8),
            Text('MyCityConnect'),
          ],
        ),
        content: const Text(
          'Explore essential services in your city — salons, plumbers, tutors, and more.\n\nVersion 1.0.0\n© 2024 MyCityConnect',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}