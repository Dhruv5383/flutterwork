// lib/screens/service_detail_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Auth service.dart';
import 'Constants.dart';
import 'Service provider.dart';
//import '../models/service_provider.dart';
//import '../services/auth_service.dart';
//import '../utils/constants.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen>
    with SingleTickerProviderStateMixin {
  File? _pickedImage;
  bool _isBooking = false;
  final AuthService _authService = AuthService();

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final XFile? file = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1080,
      );
      if (file != null) {
        setState(() => _pickedImage = File(file.path));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Photo selected! Attached to your request.'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not access ${source == ImageSource.camera ? "camera" : "gallery"}. Check permissions.'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  )),
              const Text(
                'Attach a Photo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.camera_alt, color: AppColors.primary),
                ),
                title: const Text('Take a Photo'),
                subtitle: const Text('Use your camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library, color: AppColors.accent),
                ),
                title: const Text('Choose from Gallery'),
                subtitle: const Text('Pick an existing photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_pickedImage != null)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.delete_outline, color: AppColors.error),
                  ),
                  title: const Text('Remove Photo',
                      style: TextStyle(color: AppColors.error)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _pickedImage = null);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cannot make call on this device.'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _sendSms(String phone) async {
    final uri = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot send SMS on this device.')),
        );
      }
    }
  }

  Future<void> _openWhatsApp(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    final uri = Uri.parse('https://wa.me/91$cleaned');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('WhatsApp not installed.')));
      }
    }
  }

  Future<void> _bookService(ServiceProvider provider) async {
    setState(() => _isBooking = true);
    final user = await _authService.getCurrentUser();
    final booking = {
      'serviceId': provider.id,
      'serviceName': provider.name,
      'category': provider.category,
      'date': DateTime.now().toIso8601String().split('T')[0],
      'time': '10:00 AM',
      'status': 'pending',
      'userNote': 'Booked via app',
      'hasPhoto': _pickedImage != null,
    };
    await _authService.saveBooking(user['uid'] ?? '', booking);
    if (mounted) {
      setState(() => _isBooking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text('✅ '),
              Expanded(
                child: Text(
                    'Booking request sent to ${provider.name}!'),
              ),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    ModalRoute.of(context)!.settings.arguments as ServiceProvider;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          slivers: [
            // Hero Image AppBar
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      provider.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primary.withOpacity(0.2),
                        child: const Icon(Icons.store, size: 80, color: AppColors.primary),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // Info on image
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              provider.category,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            provider.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: provider.rating,
                                itemSize: 16,
                                itemBuilder: (_, __) => const Icon(
                                  Icons.star,
                                  color: AppColors.warning,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${provider.rating} (${provider.reviews} reviews)',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.black38,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 16),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Action Buttons
                    Row(
                      children: [
                        _actionBtn(
                          icon: Icons.call,
                          label: 'Call',
                          color: AppColors.success,
                          onTap: () => _makeCall(provider.phone),
                        ),
                        const SizedBox(width: 10),
                        _actionBtn(
                          icon: Icons.sms,
                          label: 'SMS',
                          color: AppColors.primary,
                          onTap: () => _sendSms(provider.phone),
                        ),
                        const SizedBox(width: 10),
                        _actionBtn(
                          icon: Icons.chat,
                          label: 'WhatsApp',
                          color: const Color(0xFF25D366),
                          onTap: () => _openWhatsApp(provider.phone),
                        ),
                        const SizedBox(width: 10),
                        _actionBtn(
                          icon: Icons.share,
                          label: 'Share',
                          color: AppColors.accent,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Share feature coming soon!')),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // About
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Address
                    _infoRow(Icons.location_on, provider.address),
                    const SizedBox(height: 10),
                    _infoRow(Icons.phone, provider.phone),

                    const SizedBox(height: 24),

                    // Upload Photo Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.15),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.attachment, color: AppColors.primary, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Attach a Photo of Your Issue',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Help the provider understand your requirement better.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 14),
                          if (_pickedImage != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _pickedImage!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                          OutlinedButton.icon(
                            onPressed: _showImagePickerOptions,
                            icon: Icon(
                              _pickedImage != null
                                  ? Icons.edit_outlined
                                  : Icons.add_photo_alternate_outlined,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              _pickedImage != null
                                  ? 'Change Photo'
                                  : 'Add Photo',
                              style: const TextStyle(color: AppColors.primary),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed:
                        _isBooking ? null : () => _bookService(provider),
                        icon: _isBooking
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                            : const Icon(Icons.calendar_today),
                        label: Text(_isBooking ? 'Booking...' : 'Book This Service'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                    color: color, fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          ),
        ),
      ],
    );
  }
}