import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../doctor/domain/models/lifestyle_advice.dart';
import '../providers/patient_provider.dart';

class PrescriptionDetailScreen extends ConsumerWidget {
  final int id;
  const PrescriptionDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(prescriptionDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Prescription Detail'),
        backgroundColor: AppColors.background,
      ),
      body: detailAsync.when(
        data: (p) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(p.diagnosis, p.doctorName, p.startDate),
              const SizedBox(height: 24),
              if (p.notes != null && p.notes!.isNotEmpty) ...[
                const Text('Doctor\'s Notes', style: AppTextStyles.label),
                const SizedBox(height: 8),
                Text(p.notes!, style: AppTextStyles.bodyMd),
                const SizedBox(height: 24),
              ],
              const Text('Medications', style: AppTextStyles.h3),
              const SizedBox(height: 12),
              ...?p.medications?.map((m) => _medCard(m)),
              const SizedBox(height: 24),
              if (p.lifestyleAdvice != null && p.lifestyleAdvice!.isNotEmpty) ...[
                const Text('Lifestyle Recommendations', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                ...p.lifestyleAdvice!.map((a) => _adviceCard(a)),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _header(String diagnosis, String doctor, String date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(diagnosis, style: AppTextStyles.h2.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text('Prescribed by Dr. $doctor', style: AppTextStyles.bodyMd.copyWith(color: Colors.white.withOpacity(0.9))),
          Text('Date: $date', style: AppTextStyles.bodySm.copyWith(color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _medCard(dynamic m) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
      child: ListTile(
        leading: const Icon(Icons.medication, color: AppColors.primary),
        title: Text(m.medicationName, style: AppTextStyles.h3.copyWith(fontSize: 16)),
        subtitle: Text('${m.dosage} • ${m.frequency}'),
      ),
    );
  }

  Widget _adviceCard(LifestyleAdvice a) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.accentLight.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.accentLight)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb, size: 18, color: AppColors.accent),
                const SizedBox(width: 8),
                Text(a.adviceType.toUpperCase(), style: AppTextStyles.label.copyWith(color: AppColors.accent)),
              ],
            ),
            const SizedBox(height: 8),
            Text(a.title, style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(a.description, style: AppTextStyles.bodyMd),
          ],
        ),
      ),
    );
  }
}