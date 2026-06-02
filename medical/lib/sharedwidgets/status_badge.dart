import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({super.key, required this.label, required this.color});

  factory StatusBadge.medication(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
        return const StatusBadge(label: 'TAKEN', color: AppColors.success);
      case 'missed':
        return const StatusBadge(label: 'MISSED', color: AppColors.error);
      case 'skipped':
        return const StatusBadge(label: 'SKIPPED', color: AppColors.warning);
      default:
        return const StatusBadge(label: 'PENDING', color: AppColors.info);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.label.copyWith(
          color: color,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
