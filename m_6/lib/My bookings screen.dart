// lib/screens/my_bookings_screen.dart

import 'package:flutter/material.dart';
//import '../utils/constants.dart';
//import '../widgets/app_drawer.dart';
import 'App drawer.dart';
import 'Constants.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  // Mock booking data
  static final List<Map<String, dynamic>> _bookings = [
    {
      'service': 'Glamour Salon',
      'category': 'Salon',
      'date': '2024-12-20',
      'time': '11:00 AM',
      'status': 'confirmed',
      'icon': '✂️',
    },
    {
      'service': 'QuickFix Plumbers',
      'category': 'Plumbing',
      'date': '2024-12-22',
      'time': '3:00 PM',
      'status': 'pending',
      'icon': '🔧',
    },
    {
      'service': 'SparkElectric',
      'category': 'Electrician',
      'date': '2024-12-15',
      'time': '10:00 AM',
      'status': 'completed',
      'icon': '⚡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      drawer: const AppDrawer(),
      body: _bookings.isEmpty
          ? _buildEmpty()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _bookings.length,
        itemBuilder: (_, i) => _buildBookingCard(_bookings[i]),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('📋', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text(
            'No Bookings Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start exploring services and book your first one!',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final statusColor = booking['status'] == 'confirmed'
        ? AppColors.success
        : booking['status'] == 'pending'
        ? AppColors.warning
        : AppColors.textSecondary;

    final statusLabel = booking['status'].toString().toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(booking['icon'], style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['service'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      booking['category'],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            color: AppColors.divider,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(booking['date'],
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(booking['time'],
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
          if (booking['status'] == 'pending') ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const Text('Cancel Booking',
                    style: TextStyle(
                        color: AppColors.error, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}