import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../providers/hospital_provider.dart';
import '../../../auth/domain/models/user_profile.dart';

class AdminDoctorDetailScreen extends ConsumerWidget {
  final int doctorId;

  const AdminDoctorDetailScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(hospitalDoctorsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        backgroundColor: AppColors.background,
      ),
      body: doctorsAsync.when(
        data: (doctors) {
          // Safely find the doctor without causing an exception
          final doctor = doctors.where((d) => d.id == doctorId).firstOrNull;
          if (doctor == null) {
            return const Center(
              child: Text('Doctor not found or error loading details.'),
            );
          }
          return _buildDoctorDetails(context, ref, doctor);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildDoctorDetails(
    BuildContext context,
    WidgetRef ref,
    UserProfile doctor,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    doctor.fullName.isNotEmpty
                        ? doctor.fullName[0].toUpperCase()
                        : '?',
                    style: AppTextStyles.h1.copyWith(color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 16),
                Text(doctor.fullName, style: AppTextStyles.h2),
                const SizedBox(height: 4),
                Text(
                  doctor.email,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.phone ?? 'No phone number',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            title: const Text('Active Account'),
            subtitle: Text(
              doctor.isActive
                  ? 'Doctor can log in and access features.'
                  : 'Doctor account is deactivated.',
            ),
            trailing: Switch(
              value: doctor.isActive,
              onChanged: (value) {
                ref
                    .read(hospitalActionsProvider.notifier)
                    .toggleUserActive(doctor.id)
                    .then((_) {
                      ref.invalidate(hospitalDoctorsProvider);
                    });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Assigned Patients', style: AppTextStyles.h3),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, _) {
            final patientsAsync = ref.watch(
              doctorAssignedPatientsProvider(doctor.id),
            );
            return patientsAsync.when(
              data: (patients) {
                if (patients.isEmpty) {
                  return const Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(color: AppColors.border),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.people_outline),
                      title: Text('No Patients Assigned'),
                      subtitle: Text(
                        'This doctor does not have any assigned patients yet.',
                      ),
                    ),
                  );
                }
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children:
                        ListTile.divideTiles(
                          context: context,
                          tiles: patients.map(
                            (patient) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.patientColor
                                    .withOpacity(0.1),
                                child: Text(
                                  patient.fullName.isNotEmpty
                                      ? patient.fullName[0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    color: AppColors.patientColor,
                                  ),
                                ),
                              ),
                              title: Text(patient.fullName),
                              subtitle: Text(patient.email),
                            ),
                          ),
                        ).toList(),
                  ),
                );
              },
              loading:
                  () => const Card(
                    elevation: 0,
                    child: Center(
                      heightFactor: 3,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              error:
                  (e, __) => Card(
                    elevation: 0,
                    child: ListTile(
                      title: const Text('Error loading patients'),
                      subtitle: Text(e.toString()),
                    ),
                  ),
            );
          },
        ),
      ],
    );
  }
}
