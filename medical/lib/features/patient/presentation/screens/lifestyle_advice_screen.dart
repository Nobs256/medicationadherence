import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/patient_provider.dart';
import '../../../doctor/domain/models/lifestyle_advice.dart';

class LifestyleAdviceScreen extends ConsumerWidget {
  const LifestyleAdviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adviceAsync = ref.watch(patientLifestyleAdviceProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Health Recommendations', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: adviceAsync.when(
        data: (advice) {
          if (advice.isEmpty) {
            return const Center(child: Text('No active health tips.'));
          }

          final Map<String, List<LifestyleAdvice>> grouped = {};
          for (var item in advice) {
            grouped.putIfAbsent(item.adviceType, () => []).add(item);
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: grouped.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(entry.key.toUpperCase(), style: AppTextStyles.label.copyWith(color: AppColors.primary, letterSpacing: 1.0)),
                  ),
                  ...entry.value.map((item) => _AdviceCard(item: item)),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
          );
        },
        loading: () => const Padding(padding: EdgeInsets.all(20), child: LoadingShimmer()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  final LifestyleAdvice item;
  const _AdviceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_getIcon(item.adviceType), color: AppColors.accent, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.h3.copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.description, style: AppTextStyles.bodyMd),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'exercise': return Icons.directions_run;
      case 'diet': return Icons.restaurant;
      case 'hydration': return Icons.water_drop;
      case 'sleep': return Icons.bedtime;
      default: return Icons.lightbulb_outline;
    }
  }
}