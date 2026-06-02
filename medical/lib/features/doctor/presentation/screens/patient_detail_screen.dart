import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../providers/doctor_providers.dart';

class PatientDetailScreen extends ConsumerWidget {
  final int patientId;
  const PatientDetailScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientDetailProvider(patientId));
    final prescriptionsAsync = ref.watch(
      patientPrescriptionsProvider(patientId),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: patientAsync.when(
        data:
            (patient) => SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(patient),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Prescription History',
                        style: AppTextStyles.h3,
                      ),
                      ElevatedButton.icon(
                        onPressed:
                            () => context.push('/doctor/prescribe/$patientId'),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('New'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPrescriptionList(context, prescriptionsAsync),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildProfileHeader(dynamic patient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primaryLight,
            backgroundImage:
                patient.avatarUrl != null
                    ? NetworkImage(patient.avatarUrl!)
                    : null,
            child:
                patient.avatarUrl == null
                    ? Text(
                      patient.fullName[0],
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.primary,
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient.fullName, style: AppTextStyles.h2),
                const SizedBox(height: 4),
                Text(
                  'Diagnosis: ${patient.diagnosis ?? 'N/A'}',
                  style: AppTextStyles.bodyMd,
                ),
                const SizedBox(height: 4),
                Text(
                  'Phone: ${patient.phone ?? 'N/A'}',
                  style: AppTextStyles.bodySm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionList(
    BuildContext context,
    AsyncValue<List<dynamic>> prescriptionsAsync,
  ) {
    return prescriptionsAsync.when(
      data: (prescriptions) {
        if (prescriptions.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No prescription history found.'),
            ),
          );
        }
        return Column(
          children:
              prescriptions
                  .map(
                    (p) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                p.diagnosis,
                                style: AppTextStyles.h3.copyWith(fontSize: 16),
                              ),
                            ),
                            _StatusChip(isActive: p.isActive),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${p.medicationCount ?? 0} Medications • Issued on ${p.startDate}',
                          ),
                        ),
                        onTap:
                            () => context.push(
                              '/patient/prescriptions/${p.id}',
                            ), // Use patient view for detail for simplicity
                      ),
                    ),
                  )
                  .toList(),
        );
      },
      loading: () => LoadingShimmer.list(count: 3),
      error: (err, _) => Text('Error loading prescriptions: $err'),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isActive;
  const _StatusChip({required this.isActive});
  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: isActive ? 'ACTIVE' : 'INACTIVE',
      color: isActive ? AppColors.success : AppColors.textMuted,
    );
  }
}
