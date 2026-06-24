import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final role = ref
        .watch(authStateProvider)
        .maybeWhen(data: (u) => u?.roleName, orElse: () => null);

    if (role == 'doctor') {
      return const _DoctorAppointmentsView();
    }
    return const _PatientAppointmentsView();
  }
}

class _PatientAppointmentsView extends ConsumerWidget {
  const _PatientAppointmentsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(patientAppointmentsProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Appointments', style: AppTextStyles.h2),
          backgroundColor: AppColors.background,
          elevation: 0,
          bottom: const TabBar(
            tabs: [Tab(text: 'Upcoming'), Tab(text: 'History')],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
          ),
        ),
        body: appointmentsAsync.when(
          data: (appointments) {
            final now = DateTime.now();
            final upcoming =
                appointments
                    .where(
                      (a) =>
                          (a.status == 'scheduled' ||
                              a.status == 'requested') &&
                          DateTime.parse(a.appointmentDate).isAfter(now),
                    )
                    .toList();
            final past =
                appointments.where((a) => !upcoming.contains(a)).toList();

            upcoming.sort(
              (a, b) => DateTime.parse(
                a.appointmentDate,
              ).compareTo(DateTime.parse(b.appointmentDate)),
            );
            past.sort(
              (a, b) => DateTime.parse(
                b.appointmentDate,
              ).compareTo(DateTime.parse(a.appointmentDate)),
            );
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
          loading:
              () => const Padding(
                padding: EdgeInsets.all(20),
                child: LoadingShimmer(),
              ),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Assuming you have a route '/request-appointment' defined in your router.
            context.push('/request-appointment');
          },
          label: const Text('New Request'),
          icon: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}

class _DoctorAppointmentsView extends ConsumerWidget {
  const _DoctorAppointmentsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentsProvider());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Appointments', style: AppTextStyles.h2),
          backgroundColor: AppColors.background,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Requests'),
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
            final requests =
                appointments.where((a) => a.status == 'requested').toList();
            final upcoming =
                appointments
                    .where(
                      (a) =>
                          a.status == 'scheduled' &&
                          DateTime.parse(a.appointmentDate).isAfter(now),
                    )
                    .toList();
            final history =
                appointments
                    .where(
                      (a) => !requests.contains(a) && !upcoming.contains(a),
                    )
                    .toList();

            requests.sort(
              (a, b) => DateTime.parse(
                a.appointmentDate,
              ).compareTo(DateTime.parse(b.appointmentDate)),
            );
            upcoming.sort(
              (a, b) => DateTime.parse(
                a.appointmentDate,
              ).compareTo(DateTime.parse(b.appointmentDate)),
            );
            history.sort(
              (a, b) => DateTime.parse(
                b.appointmentDate,
              ).compareTo(DateTime.parse(a.appointmentDate)),
            );

            return TabBarView(
              children: [
                _AppointmentList(
                  appointments: requests,
                  emptyMsg: 'No new appointment requests.',
                ),
                _AppointmentList(
                  appointments: upcoming,
                  emptyMsg: 'No upcoming appointments.',
                ),
                _AppointmentList(
                  appointments: history,
                  emptyMsg: 'No past appointments.',
                ),
              ],
            );
          },
          loading:
              () => const Padding(
                padding: EdgeInsets.all(20),
                child: LoadingShimmer(),
              ),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'scheduled':
      return AppColors.primary;
    case 'requested':
      return AppColors.info;
    case 'completed':
      return AppColors.success;
    case 'cancelled':
    case 'rejected':
      return AppColors.error;
    default:
      return AppColors.textMuted;
  }
}

class _AppointmentList extends ConsumerWidget {
  final List<Appointment> appointments;
  final String emptyMsg;

  const _AppointmentList({required this.appointments, required this.emptyMsg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (appointments.isEmpty) {
      return Center(child: Text(emptyMsg, style: AppTextStyles.bodyMd));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final a = appointments[index];
        final role = ref.watch(authStateProvider).value?.roleName;

        Widget? trailing;
        if (role == 'doctor' && a.status == 'requested') {
          trailing = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.check_circle, color: AppColors.success),
                tooltip: 'Accept',
                onPressed: () {
                  ref
                      .read(appointmentActionsProvider.notifier)
                      .updateStatus(a.id, 'scheduled');
                },
              ),
              IconButton(
                icon: const Icon(Icons.cancel, color: AppColors.error),
                tooltip: 'Reject',
                onPressed: () {
                  ref
                      .read(appointmentActionsProvider.notifier)
                      .updateStatus(a.id, 'rejected');
                },
              ),
            ],
          );
        } else {
          trailing = StatusBadge(
            label: a.status,
            color: _getStatusColor(a.status),
          );
        }
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
                  Text(DateFormat('dd').format(date), style: AppTextStyles.h3),
                ],
              ),
            ),
            title: Text(
              a.purpose,
              style: AppTextStyles.h3.copyWith(fontSize: 16),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                role == 'doctor'
                    ? '${a.patientName ?? 'Patient'}\n${DateFormat('h:mm a').format(date)}'
                    : 'Dr. ${a.doctorName ?? 'General Practitioner'}\n${DateFormat('h:mm a').format(date)}',
              ),
            ),
            trailing: trailing,
          ),
        );
      },
    );
  }
}
