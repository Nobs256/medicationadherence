import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../providers/hospitals_provider.dart';

class HospitalDetailScreen extends ConsumerWidget {
  final int id;
  const HospitalDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(hospitalDetailProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Hospital Details'), backgroundColor: AppColors.background),
      body: detailAsync.when(
        data: (h) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 32, backgroundImage: h.logoUrl != null ? NetworkImage(h.logoUrl!) : null, child: h.logoUrl == null ? const Icon(Icons.business) : null),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(h.name, style: AppTextStyles.h2),
                        const SizedBox(height: 4),
                        StatusBadge(label: h.isActive ? 'ACTIVE' : 'INACTIVE', color: h.isActive ? AppColors.success : AppColors.textMuted),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Facility Statistics', style: AppTextStyles.h3),
              const SizedBox(height: 16),
              _DetailRow('Doctors', (h.doctorCount ?? 0).toString()),
              _DetailRow('Patients', (h.patientCount ?? 0).toString()),
              _DetailRow('Average Adherence', '${(h.avgAdherence ?? 0).toString()}%'),
              const SizedBox(height: 32),
              const Text('Contact Information', style: AppTextStyles.h3),
              const SizedBox(height: 16),
              _DetailRow('Email', h.email ?? 'Not set'),
              _DetailRow('Phone', h.phone ?? 'Not set'),
              _DetailRow('Address', h.address ?? 'Not set'),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => ref.read(hospitalActionsProvider.notifier).toggleHospital(h.id),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              h.isActive ? AppColors.error : AppColors.success,
                        ),
                        child: Text(h.isActive ? 'Deactivate Hospital' : 'Activate Hospital'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.push('/super-admin/hospitals/${h.id}/admins'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Manage Admins'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _DetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}