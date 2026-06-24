import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../patient/presentation/providers/patient_provider.dart';
import '../../domain/models/appointment.dart';
import '../providers/appointment_provider.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authStateProvider).maybeWhen(
          data: (u) => u?.roleName,
          orElse: () => null,
        );

    final appointmentsAsync = role == 'doctor'
        ? ref.watch(appointmentsProvider())
        : ref.watch(patientAppointmentsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Appointments', style: AppTextStyles.h2),
          backgroundColor: AppColors.background,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'History'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
          ),
        ),
        body: appointmentsAsync.when(
          data: (appointments) {
            final now = DateTime.now();
            final upcoming = appointments
                .where((a) =>
                    DateTime.parse(a.appointmentDate).isAfter(now) ||
                    a.status == 'scheduled')
                .toList();
            final past = appointments
                .where((a) =>
                    DateTime.parse(a.appointmentDate).isBefore(now) &&
                    a.status != 'scheduled')
                .toList();

            return TabBarView(
              children: [
                _AppointmentList(
                  appointments: upcoming,
                  emptyMsg: 'No upcoming appointments',
                ),
                _AppointmentList(
                  appointments: past,
                  emptyMsg: 'No past appointments',
                ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(20),
            child: LoadingShimmer(),
          ),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final String emptyMsg;

  const _AppointmentList({
    required this.appointments,
    required this.emptyMsg,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(child: Text(emptyMsg, style: AppTextStyles.bodyMd));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final a = appointments[index];
        final date = DateTime.parse(a.appointmentDate);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM').format(date).toUpperCase(),
                    style: AppTextStyles.label.copyWith(fontSize: 10),
                  ),
                  Text(
                    DateFormat('dd').format(date),
                    style: AppTextStyles.h3,
                  ),
                ],
              ),
            ),
            title:
                Text(a.purpose, style: AppTextStyles.h3.copyWith(fontSize: 16)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Dr. ${a.doctorName ?? 'General Practitioner'}\n${DateFormat('h:mm a').format(date)}',
              ),
            ),
            trailing: StatusBadge(
              label: a.status.toUpperCase(),
              color:
                  a.status == 'scheduled' ? AppColors.info : AppColors.textMuted,
            ),
          ),
        );
      },
    );
  }
}

