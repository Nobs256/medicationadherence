import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../providers/patient_provider.dart';

class MyPrescriptionsScreen extends ConsumerWidget {
  const MyPrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(myPrescriptionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Prescriptions', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myPrescriptionsProvider.future),
        child: prescriptionsAsync.when(
          data: (prescriptions) {
            if (prescriptions.isEmpty) {
              return const Center(child: Text('No prescriptions found.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final p = prescriptions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => context.push('/patient/prescriptions/${p.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(p.diagnosis, style: AppTextStyles.h3),
                              ),
                              StatusBadge(
                                label: p.isActive ? 'ACTIVE' : 'INACTIVE',
                                color: p.isActive ? AppColors.success : AppColors.textMuted,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Doctor: Dr. ${p.doctorName}',
                            style: AppTextStyles.bodyMd,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Period: ${p.startDate} to ${p.endDate ?? 'Indefinite'}',
                            style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                          ),
                          const Divider(height: 24),
                          Text(
                            '${p.medicationCount ?? 0} Medications • ${p.adviceCount ?? 0} Lifestyle Tips',
                            style: AppTextStyles.label,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => Padding(padding: const EdgeInsets.all(20), child: LoadingShimmer.list(count: 4)),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}