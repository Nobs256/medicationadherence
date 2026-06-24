import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/hospitals_provider.dart';

class SuperAdminDashboard extends ConsumerWidget {
  const SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(superAdminStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'MediTrack System Admin',
          style: AppTextStyles.h2,
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(superAdminStatsProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statsAsync.when(
                data: (stats) => GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _StatCard('Hospitals', stats['hospitals']?.toString() ?? '0', Icons.business_rounded, AppColors.superAdminColor),
                    _StatCard('Total Users', stats['users']?.toString() ?? '0', Icons.people_rounded, AppColors.primary),
                    _StatCard('Active Medication', stats['prescriptions']?.toString() ?? '0', Icons.medication_rounded, AppColors.success),
                    _StatCard('Average Adherence', '${stats['adherence'] ?? 0}%', Icons.analytics_rounded, AppColors.accent),
                  ],
                ),
                loading: () => const LoadingShimmer(height: 200),
                error: (e, __) => Center(child: Text('Error: $e')),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hospital Network', style: AppTextStyles.h3),
                  TextButton(
                    onPressed: () => context.go('/super-admin/hospitals'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.border)),
                child: ListTile(
                  leading: const Icon(Icons.add_business_outlined, color: AppColors.primary),
                  title: const Text('Onboard New Hospital', style: AppTextStyles.bodyLg),
                  subtitle: const Text('Add a new health facility to the platform'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/super-admin/hospitals/add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _StatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.h1.copyWith(fontSize: 20)),
          Text(label, style: AppTextStyles.bodySm),
        ],
      ),
    );
  }
}