// lib/widgets/stats_banner.dart
// Horizontal stats row showing Pending / In Progress / Completed counts

import 'package:flutter/material.dart';

class StatsBanner extends StatelessWidget {
  final int pending;
  final int inProgress;
  final int completed;

  const StatsBanner({
    super.key,
    required this.pending,
    required this.inProgress,
    required this.completed,
  });

  int get _total => pending + inProgress + completed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          _StatChip(
            label:     'Pending',
            count:     pending,
            color:     const Color(0xFFFFB300),
            icon:      Icons.hourglass_empty_rounded,
          ),
          const SizedBox(width: 10),
          _StatChip(
            label:     'In Progress',
            count:     inProgress,
            color:     const Color(0xFF4F6AF5),
            icon:      Icons.timelapse_rounded,
          ),
          const SizedBox(width: 10),
          _StatChip(
            label:     'Done',
            count:     completed,
            color:     const Color(0xFF26C36F),
            icon:      Icons.check_circle_rounded,
          ),
          const Spacer(),
          // Total pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color:        cs.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$_total Total',
              style: TextStyle(
                fontSize:   12,
                fontWeight: FontWeight.w700,
                color:      cs.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String   label;
  final int      count;
  final Color    color;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color:        color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      border:       Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 5),
        Text(
          '$count',
          style: TextStyle(
            fontSize:   13,
            fontWeight: FontWeight.w800,
            color:      color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize:   11,
            fontWeight: FontWeight.w500,
            color:      color.withOpacity(0.8),
          ),
        ),
      ],
    ),
  );
}