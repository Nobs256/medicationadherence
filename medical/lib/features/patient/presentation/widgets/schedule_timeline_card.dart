import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../../domain/models/medication_schedule.dart';
import '../providers/patient_provider.dart';

class ScheduleTimelineCard extends ConsumerWidget {
  final MedicationSchedule schedule;

  const ScheduleTimelineCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = schedule.scheduledTime.split(' ')[1].substring(0, 5);
    final isPending = schedule.status == 'pending';
    final actionState = ref.watch(scheduleActionProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time and Timeline indicator
          Column(
            children: [
              Text(
                time,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(width: 2, height: 80, color: AppColors.border),
            ],
          ),
          const SizedBox(width: 16),
          // Medication Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          schedule.medicationName,
                          style: AppTextStyles.h3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      StatusBadge.medication(schedule.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    schedule.dosage,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (schedule.specialInstructions != null &&
                      schedule.specialInstructions!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Note: ${schedule.specialInstructions}',
                      style: AppTextStyles.bodySm.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (isPending) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // To be implemented: Skip functionality
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.error),
                              foregroundColor: AppColors.error,
                            ),
                            child: const Text('Skip'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                actionState.isLoading
                                    ? null
                                    : () => ref
                                        .read(scheduleActionProvider.notifier)
                                        .markTaken(schedule.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            child:
                                actionState.isLoading
                                    ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : const Text('Take'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
