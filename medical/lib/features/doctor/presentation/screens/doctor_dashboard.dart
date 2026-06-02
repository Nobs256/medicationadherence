import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/services/api_service.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/doctor_providers.dart';
import '../../../auth/domain/models/user_profile.dart';

class DoctorDashboard extends ConsumerWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final statsAsync = ref.watch(doctorStatsProvider);
    final patientsAsync = ref.watch(myPatientsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome,', style: AppTextStyles.bodySm),
            Text('Dr. ${user?.fullName.split(' ').last ?? ''}', style: AppTextStyles.h2),
          ],
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(apiServiceProvider).triggerInternalTasks();
          ref.invalidate(doctorStatsProvider);
          ref.invalidate(myPatientsProvider);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsGrid(statsAsync, user),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Patients', style: AppTextStyles.h3),
                  TextButton(
                    onPressed: () => context.go('/doctor/patients'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildPatientPreview(patientsAsync, context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/doctor/appointments/new'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Appointment', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildStatsGrid(AsyncValue<Map<String, dynamic>> statsAsync, UserProfile? user) {
    return statsAsync.when(
      data: (stats) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _statCard('Total Patients', stats['patients']?.toString() ?? '0', Icons.people_outline, AppColors.doctorColor),
          _statCard('Appointments', stats['todayAppts']?.toString() ?? '0', Icons.calendar_today, AppColors.info),
          _statCard('Active Meds', stats['prescriptions']?.toString() ?? '0', Icons.medication_outlined, AppColors.accent),
          _statCard('Hospital', user?.hospitalName ?? 'N/A', Icons.local_hospital_outlined, AppColors.adminColor),
        ],
      ),
      loading: () => const LoadingShimmer(height: 200),
      error: (err, _) => const Center(child: Text('Error loading stats')),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.h2, overflow: TextOverflow.ellipsis),
          Text(label, style: AppTextStyles.bodySm, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildPatientPreview(AsyncValue<List<UserProfile>> patientsAsync, BuildContext context) {
    return patientsAsync.when(
      data: (patients) {
        if (patients.isEmpty) return const Center(child: Text('No patients assigned yet.'));
        return Column(
          children: patients.take(4).map((patient) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                backgroundImage: patient.avatarUrl != null ? NetworkImage(patient.avatarUrl!) : null,
                child: patient.avatarUrl == null ? Text(patient.fullName[0], style: const TextStyle(color: AppColors.primary)) : null,
              ),
              title: Text(patient.fullName, style: AppTextStyles.h3.copyWith(fontSize: 16)),
              subtitle: Text(patient.diagnosis ?? 'General Checkup', style: AppTextStyles.bodySm),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.push('/doctor/patients/${patient.id}'),
            ),
          )).toList(),
        );
      },
      loading: () => LoadingShimmer.list(count: 3),
      error: (_, __) => const Text('Unable to load patients'),
    );
  }
}