// lib/screens/profile_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import '../services/auth_service.dart';
//import '../utils/constants.dart';
//import '../widgets/app_drawer.dart';
import 'App drawer.dart';
import 'Auth service.dart';
import 'Constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  String _name = 'User';
  String _email = '';
  File? _profilePhoto;
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _name = user['name'] ?? 'User';
      _email = user['email'] ?? '';
      _nameCtrl.text = _name;
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickProfilePhoto() async {
    final picker = ImagePicker();
    try {
      final XFile? file = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (file != null) {
        setState(() => _profilePhoto = File(file.path));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile photo updated!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickProfilePhoto,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          backgroundImage:
                          _profilePhoto != null ? FileImage(_profilePhoto!) : null,
                          child: _profilePhoto == null
                              ? Text(
                            _name.isNotEmpty ? _name[0].toUpperCase() : 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _email,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('✓ Verified',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),

            // Stats
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statItem('3', 'Bookings'),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _statItem('2', 'Completed'),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _statItem('1', 'Pending'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Settings
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _settingsItem(Icons.person_outline, 'Edit Name', () {
                    _showEditNameDialog();
                  }),
                  _settingsItem(Icons.notifications_outlined, 'Notifications', () {}),
                  _settingsItem(Icons.lock_outline, 'Change Password', () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feature coming soon!')),
                    );
                  }),
                  _settingsItem(Icons.language, 'Language: English', () {}),
                  _settingsItem(Icons.help_outline, 'Help & FAQ', () {}),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _settingsItem(
                    Icons.logout,
                    'Logout',
                        () async {
                      await _authService.logout();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.login, (_) => false);
                      }
                    },
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _settingsItem(IconData icon, String label, VoidCallback onTap,
      {Color? color}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color ?? AppColors.primary, size: 22),
          title: Text(
            label,
            style: TextStyle(
              color: color ?? AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          trailing: Icon(Icons.chevron_right,
              color: color ?? AppColors.textSecondary, size: 20),
          onTap: onTap,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 1),
        ),
      ],
    );
  }

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Name'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: TextField(
          controller: _nameCtrl,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _name = _nameCtrl.text.trim());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Name updated!'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}