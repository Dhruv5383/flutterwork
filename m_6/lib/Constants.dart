
// lib/utils/constants.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color accent = Color(0xFFFF6D00);
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color shimmer = Color(0xFFE0E0E0);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        labelStyle: const TextStyle(color: AppColors.primary, fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String serviceDetail = '/service-detail';
  static const String myBookings = '/my-bookings';
  static const String profile = '/profile';
  static const String contactUs = '/contact-us';
}

class AppStrings {
  static const String appName = 'MyCityConnect';
  static const String tagline = 'Your City, Your Services';
  static const String mockApiUrl =
      'https://6749ccc4e88051d6040c09e0.mockapi.io/api/v1/services';
}

// Mock data fallback
class MockData {
  static List<Map<String, dynamic>> services = [
    {
      'id': '1',
      'name': 'Glamour Salon',
      'category': 'Salon',
      'imageUrl': 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=400',
      'rating': '4.8',
      'description': 'Premium hair and beauty services. Expert stylists for all hair types, facials, manicures & pedicures. Walk-ins welcome!',
      'phone': '+91 98765 43210',
      'address': 'Shop 12, MG Road, Ahmedabad',
      'reviews': '124',
    },
    {
      'id': '2',
      'name': 'QuickFix Plumbers',
      'category': 'Plumbing',
      'imageUrl': 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=400',
      'rating': '4.5',
      'description': '24/7 emergency plumbing services. Leak repairs, pipe fitting, bathroom installation. Certified and insured professionals.',
      'phone': '+91 91234 56789',
      'address': '45 Navrangpura, Ahmedabad',
      'reviews': '89',
    },
    {
      'id': '3',
      'name': 'Bright Minds Tuition',
      'category': 'Education',
      'imageUrl': 'https://images.unsplash.com/photo-1509062522246-3755977927d7?w=400',
      'rating': '4.9',
      'description': 'Expert tutoring for Class 6-12 in Maths, Science, English. Small batch sizes. Result-oriented teaching methodology.',
      'phone': '+91 87654 32109',
      'address': '78 Paldi, Ahmedabad',
      'reviews': '256',
    },
    {
      'id': '4',
      'name': 'SparkElectric',
      'category': 'Electrician',
      'imageUrl': 'https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=400',
      'rating': '4.6',
      'description': 'Licensed electricians for home and commercial wiring, AC installation, panel upgrades. Safety certified.',
      'phone': '+91 76543 21098',
      'address': '23 Vastrapur, Ahmedabad',
      'reviews': '67',
    },
    {
      'id': '5',
      'name': 'AutoCare Garage',
      'category': 'Automobile',
      'imageUrl': 'https://images.unsplash.com/photo-1530046339160-ce3e530c7d2f?w=400',
      'rating': '4.4',
      'description': 'Multi-brand car service center. Engine repair, oil change, AC service, denting & painting. Pickup & drop available.',
      'phone': '+91 65432 10987',
      'address': '56 Satellite, Ahmedabad',
      'reviews': '112',
    },
    {
      'id': '6',
      'name': 'FreshHome Cleaning',
      'category': 'Cleaning',
      'imageUrl': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
      'rating': '4.7',
      'description': 'Professional home and office cleaning. Deep cleaning, sofa cleaning, carpet shampooing. Eco-friendly products.',
      'phone': '+91 54321 09876',
      'address': '89 Bopal, Ahmedabad',
      'reviews': '198',
    },
    {
      'id': '7',
      'name': 'TechSupport Pro',
      'category': 'IT Support',
      'imageUrl': 'https://images.unsplash.com/photo-1587920208977-d8dc617a053c?w=400',
      'rating': '4.3',
      'description': 'Computer repair, laptop service, networking, CCTV installation. Remote and onsite support available.',
      'phone': '+91 43210 98765',
      'address': '12 CG Road, Ahmedabad',
      'reviews': '43',
    },
    {
      'id': '8',
      'name': 'GreenThumb Gardens',
      'category': 'Gardening',
      'imageUrl': 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400',
      'rating': '4.6',
      'description': 'Landscape design, garden maintenance, plant nursery, terrace gardening. Transform your space with nature.',
      'phone': '+91 32109 87654',
      'address': '34 Thaltej, Ahmedabad',
      'reviews': '78',
    },
  ];

  static List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': '🏠'},
    {'name': 'Salon', 'icon': '✂️'},
    {'name': 'Plumbing', 'icon': '🔧'},
    {'name': 'Education', 'icon': '📚'},
    {'name': 'Electrician', 'icon': '⚡'},
    {'name': 'Automobile', 'icon': '🚗'},
    {'name': 'Cleaning', 'icon': '🧹'},
    {'name': 'IT Support', 'icon': '💻'},
    {'name': 'Gardening', 'icon': '🌿'},
  ];
}