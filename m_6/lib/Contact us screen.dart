// lib/screens/contact_us_screen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../utils/constants.dart';
// import '../widgets/app_drawer.dart';
import 'App drawer.dart';
import 'Constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _launchPhone(BuildContext ctx) async {
    final uri = Uri(scheme: 'tel', path: '+911800001234');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Cannot make call on this device.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _launchSms(BuildContext ctx) async {
    final uri = Uri(scheme: 'sms', path: '+911800001234');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Cannot send SMS on this device.')),
      );
    }
  }

  Future<void> _launchEmail(BuildContext ctx) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@mycityconnect.app',
      query: Uri.encodeQueryComponent('subject=Support Request&body=Hi,'),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Cannot open email app.')),
      );
    }
  }

  Future<void> _launchUrl(BuildContext ctx, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Cannot open $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🤝', style: TextStyle(fontSize: 40)),
                  SizedBox(height: 12),
                  Text(
                    'We\'re here to help!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Reach out to us through any channel below. Our team responds within 24 hours.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            const Text(
              'Get In Touch',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Contact Options
            _contactCard(
              context,
              icon: Icons.call_rounded,
              color: AppColors.success,
              title: 'Call Us',
              subtitle: '+91 1800-001-2345 (Toll Free)',
              hint: 'Mon–Sat, 9AM–7PM',
              onTap: () => _launchPhone(context),
            ),
            _contactCard(
              context,
              icon: Icons.sms_rounded,
              color: AppColors.primary,
              title: 'Send SMS',
              subtitle: '+91 1800-001-2345',
              hint: 'Expect reply within 2 hours',
              onTap: () => _launchSms(context),
            ),
            _contactCard(
              context,
              icon: Icons.email_rounded,
              color: AppColors.accent,
              title: 'Email Support',
              subtitle: 'support@mycityconnect.app',
              hint: 'Detailed queries & complaints',
              onTap: () => _launchEmail(context),
            ),
            _contactCard(
              context,
              icon: Icons.language_rounded,
              color: const Color(0xFF6366F1),
              title: 'Visit Website',
              subtitle: 'www.mycityconnect.app',
              hint: 'FAQs, blog & more',
              onTap: () => _launchUrl(context, 'https://flutter.dev'),
            ),

            const SizedBox(height: 28),
            const Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _socialBtn(context, 'Instagram', '📸',
                    'https://instagram.com'),
                const SizedBox(width: 10),
                _socialBtn(context, 'Twitter / X', '🐦',
                    'https://twitter.com'),
                const SizedBox(width: 10),
                _socialBtn(context, 'YouTube', '▶️',
                    'https://youtube.com'),
              ],
            ),

            const SizedBox(height: 28),

            // Feedback Form
            const Text(
              'Send Us a Message',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _FeedbackForm(),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        required String subtitle,
        required String hint,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.primary)),
                  const SizedBox(height: 2),
                  Text(hint,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: color, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _socialBtn(BuildContext ctx, String label, String emoji, String url) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _launchUrl(ctx, url),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackForm extends StatefulWidget {
  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final _nameCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.success.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.success.withOpacity(0.3)),
        ),
        child: const Column(
          children: [
            Text('✅', style: TextStyle(fontSize: 40)),
            SizedBox(height: 12),
            Text(
              'Message Sent!',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.success),
            ),
            SizedBox(height: 6),
            Text(
              'We\'ll get back to you within 24 hours.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        TextField(
          controller: _nameCtrl,
          decoration: const InputDecoration(
            labelText: 'Your Name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _msgCtrl,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Your Message',
            alignLabelWithHint: true,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 64),
              child: Icon(Icons.message_outlined),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('Send Message'),
            onPressed: () {
              if (_nameCtrl.text.isEmpty || _msgCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields.'),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              setState(() => _sent = true);
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}