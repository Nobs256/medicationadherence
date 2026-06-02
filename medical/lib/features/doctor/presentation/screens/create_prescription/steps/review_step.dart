import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';

class ReviewStep extends StatelessWidget {
  final String diagnosis;
  final List<Map<String, dynamic>> meds;
  final List<Map<String, dynamic>> advice;

  const ReviewStep({
    super.key,
    required this.diagnosis,
    required this.meds,
    required this.advice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Final Review', style: AppTextStyles.h3),
        const SizedBox(height: 24),
        _section('Diagnosis', diagnosis.isEmpty ? 'Not specified' : diagnosis),
        const Divider(height: 32),
        _section('Medications', '${meds.length} medications added'),
        ...meds.map(
          (m) => Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              '• ${m['medication_name']} (${m['dosage']})',
              style: AppTextStyles.bodyMd,
            ),
          ),
        ),
        const Divider(height: 32),
        _section('Lifestyle Advice', '${advice.length} recommendations added'),
        ...advice.map(
          (a) => Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text('• ${a['title']}', style: AppTextStyles.bodyMd),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Submitting this will automatically generate daily medication reminders for the patient.',
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _section(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.label),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h3.copyWith(fontSize: 16)),
      ],
    );
  }
}
