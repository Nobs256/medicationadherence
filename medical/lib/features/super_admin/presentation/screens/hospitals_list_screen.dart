import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../providers/hospitals_provider.dart';

class HospitalsListScreen extends ConsumerWidget {
  const HospitalsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hospitalsAsync = ref.watch(hospitalsListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('All Hospitals'), backgroundColor: AppColors.background),
      body: hospitalsAsync.when(
        data: (hospitals) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hospitals.length,
          itemBuilder: (context, index) {
            final h = hospitals[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryLight,
                  backgroundImage: h.logoUrl != null ? NetworkImage(h.logoUrl!) : null,
                  child: h.logoUrl == null ? const Icon(Icons.business, color: AppColors.primary) : null,
                ),
                title: Text(h.name, style: AppTextStyles.h3.copyWith(fontSize: 16)),
                subtitle: Text('${h.doctorCount ?? 0} Doctors • ${h.patientCount ?? 0} Patients'),
                trailing: StatusBadge(
                  label: h.isActive ? 'ACTIVE' : 'INACTIVE',
                  color: h.isActive ? AppColors.success : AppColors.textMuted,
                ),
                onTap: () => context.push('/super-admin/hospitals/${h.id}'),
              ),
            );
          },
        ),
        loading: () => Padding(padding: const EdgeInsets.all(16), child: LoadingShimmer.list(count: 8)),
        error: (e, __) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/super-admin/hospitals/add'), backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}