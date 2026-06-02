import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../providers/patient_provider.dart';
import '../../domain/models/medication_schedule.dart';

class MedicationDetailScreen extends ConsumerWidget {
  final int scheduleId;

  const MedicationDetailScreen({super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(todaySchedulesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Medication Details'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: schedulesAsync.when(
        data: (schedules) {
          final schedule = schedules.firstWhere(
            (s) => s.id == scheduleId,
            orElse: () => throw Exception('Schedule not found'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(schedule),
                const SizedBox(height: 24),
                _buildInstructionCard(schedule),
                const SizedBox(height: 24),
                if (schedule.lifestyleTips != null && schedule.lifestyleTips!.isNotEmpty)
                  _buildLifestyleAdvice(schedule.lifestyleTips!),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: ${err.toString()}')),
      ),
    );
  }

  Widget _buildHeader(MedicationSchedule schedule) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.medication_liquid, size: 40, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(schedule.medicationName, style: AppTextStyles.h1),
              Text(
                schedule.diagnosis ?? 'Prescribed Medication',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionCard(MedicationSchedule schedule) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Instructions', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          _infoRow(Icons.bolt_outlined, 'Dosage', schedule.dosage),
          _infoRow(Icons.restaurant_outlined, 'Food', schedule.withFood ? 'Take with food' : 'Take on empty stomach'),
          _infoRow(Icons.water_drop_outlined, 'Water', schedule.withWater ? 'Drink plenty of water' : 'Normal hydration'),
          if (schedule.specialInstructions != null)
            _infoRow(Icons.info_outline, 'Doctor\'s Note', schedule.specialInstructions!),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.label),
                Text(value, style: AppTextStyles.bodyMd),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleAdvice(List<Map<String, String>> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Health Tips', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        ...tips.map((tip) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 0,
          color: AppColors.primaryLight.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.primaryLight),
          ),
          child: ListTile(
            leading: const Icon(Icons.lightbulb_outline, color: AppColors.accent),
            title: Text(
              tip['title'] ?? '',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              (tip['type'] ?? 'General').toUpperCase(),
              style: AppTextStyles.label.copyWith(fontSize: 10),
            ),
          ),
        )),
      ],
    );
  }
}