import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/hospital_provider.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(adminStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hospital Admin', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(adminStatsProvider.future),
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
                    _StatCard('Doctors', stats['doctors']?.toString() ?? '0', Icons.medical_services_outlined, AppColors.doctorColor),
                    _StatCard('Patients', stats['patients']?.toString() ?? '0', Icons.people_outline, AppColors.patientColor),
                    _StatCard('Adherence', '${stats['avg_adherence'] ?? 0}%', Icons.analytics_outlined, AppColors.primary),
                    _StatCard('Reports', 'View', Icons.description_outlined, AppColors.accent),
                  ],
                ),
                loading: () => const LoadingShimmer(height: 200),
                error: (e, __) => const Center(child: Text('Error loading stats')),
              ),
              const SizedBox(height: 32),
              const Text('Quick Actions', style: AppTextStyles.h3),
              const SizedBox(height: 16),
              _QuickActionTile(
                title: 'Manage Doctors',
                subtitle: 'Add or deactivate medical staff',
                icon: Icons.local_hospital_outlined,
                onTap: () => context.go('/admin/doctors'),
              ),
              _QuickActionTile(
                title: 'Manage Patients',
                subtitle: 'Register patients and assign doctors',
                icon: Icons.person_add_outlined,
                onTap: () => context.go('/admin/patients'),
              ),
              _QuickActionTile(
                title: 'Hospital Reports',
                subtitle: 'Detailed adherence analytics',
                icon: Icons.bar_chart_rounded,
                onTap: () => context.go('/admin/reports'),
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
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.h2),
          Text(label, style: AppTextStyles.bodySm),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final String title, subtitle; final IconData icon; final VoidCallback onTap;
  const _QuickActionTile({required this.title, required this.subtitle, required this.icon, required this.onTap});
  @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 12), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)), child: ListTile(leading: Icon(icon, color: AppColors.primary), title: Text(title, style: AppTextStyles.h3.copyWith(fontSize: 16)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right), onTap: onTap));
}