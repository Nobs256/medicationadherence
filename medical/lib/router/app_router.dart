import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/patient/presentation/screens/patient_dashboard.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/patient/presentation/screens/today_schedule_screen.dart';
import '../sharedwidgets/app_shell.dart';
import '../features/patient/presentation/screens/medication_detail_screen.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import '../features/adherence/presentation/screens/adherence_report_screen.dart';
import '../features/doctor/presentation/screens/doctor_dashboard.dart';
import '../features/doctor/presentation/screens/my_patients_screen.dart';
import '../features/doctor/presentation/screens/patient_detail_screen.dart';
import '../features/doctor/presentation/screens/medication_library_screen.dart';
import '../features/doctor/presentation/screens/create_prescription/create_prescription_screen.dart';
import '../features/appointments/presentation/screens/schedule_appointment_screen.dart';
import '../features/patient/presentation/screens/my_prescriptions_screen.dart';
import '../features/patient/presentation/screens/prescription_detail_screen.dart';
import '../features/appointments/presentation/screens/appointments_screen.dart';
import '../features/patient/presentation/screens/lifestyle_advice_screen.dart';

import '../features/hospital_admin/presentation/screens/admin_dashboard.dart';
import '../features/hospital_admin/presentation/screens/manage_doctors_screen.dart';
import '../features/hospital_admin/presentation/screens/add_doctor_screen.dart';
import '../features/hospital_admin/presentation/screens/manage_patients_screen.dart';
import '../features/hospital_admin/presentation/screens/add_patient_screen.dart';
import '../features/hospital_admin/presentation/screens/assign_patient_screen.dart';
import '../features/super_admin/presentation/screens/super_admin_dashboard.dart';
import '../features/super_admin/presentation/screens/hospitals_list_screen.dart';
import '../features/super_admin/presentation/screens/add_hospital_screen.dart';
import '../features/super_admin/presentation/screens/hospital_detail_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';

// Temporary screens for routing setup
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)));
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';
      final inSplash = state.matchedLocation == '/splash';

      return authState.when(
        data: (user) {
          if (user == null) {
            return (loggingIn || inSplash) ? null : '/login';
          }

          if (loggingIn || inSplash) {
            return ref.read(authStateProvider.notifier).getInitialRoute(user);
          }
          return null;
        },
        loading: () => inSplash ? null : '/splash',
        error: (_, __) => '/login',
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          // Role Dashboards
          GoRoute(
            path: '/super-admin/dashboard',
            builder: (context, state) => const SuperAdminDashboard(),
          ),
          GoRoute(
            path: '/super-admin/hospitals',
            builder: (context, state) => const HospitalsListScreen(),
          ),
          GoRoute(
            path: '/super-admin/hospitals/add',
            builder: (context, state) => const AddHospitalScreen(),
          ),
          GoRoute(
            path: '/super-admin/hospitals/:id',
            builder: (context, state) => HospitalDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/admin/dashboard',
            builder: (context, state) => const AdminDashboard(),
          ),
          GoRoute(
            path: '/admin/doctors',
            builder: (context, state) => const ManageDoctorsScreen(),
          ),
          GoRoute(
            path: '/admin/doctors/add',
            builder: (context, state) => const AddDoctorScreen(),
          ),
          GoRoute(
            path: '/admin/patients',
            builder: (context, state) => const ManagePatientsScreen(),
          ),
          GoRoute(
            path: '/admin/patients/add',
            builder: (context, state) => const AddPatientScreen(),
          ),
          GoRoute(
            path: '/admin/patients/:id/assign',
            builder: (context, state) => AssignPatientScreen(
              patientId: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/admin/reports',
            builder: (context, state) => const AdherenceReportScreen(),
          ),
          GoRoute(
            path: '/doctor/dashboard',
            builder: (context, state) => const DoctorDashboard(),
          ),
          GoRoute(
            path: '/patient/dashboard',
            builder: (context, state) => const PatientDashboard(),
          ),

          // Role specific screens (stubs)
          GoRoute(
            path: '/patient/schedule',
            builder: (context, state) => const TodayScheduleScreen(),
          ),
          GoRoute(
            path: '/patient/adherence',
            builder: (context, state) => const AdherenceReportScreen(),
          ),
          GoRoute(
            path: '/patient/medications/:id',
            builder:
                (context, state) => MedicationDetailScreen(
                  scheduleId: int.parse(state.pathParameters['id']!),
                ),
          ),
          GoRoute(
            path: '/patient/prescriptions',
            builder: (context, state) => const MyPrescriptionsScreen(),
          ),
          GoRoute(
            path: '/patient/prescriptions/:id',
            builder:
                (context, state) => PrescriptionDetailScreen(
                  id: int.parse(state.pathParameters['id']!),
                ),
          ),
          GoRoute(
            path: '/doctor/patients',
            builder: (context, state) => const MyPatientsScreen(),
          ),
          GoRoute(
            path: '/doctor/patients/:id',
            builder:
                (context, state) => PatientDetailScreen(
                  patientId: int.parse(state.pathParameters['id']!),
                ),
          ),
          GoRoute(
            path: '/doctor/medications',
            builder: (context, state) => const MedicationLibraryScreen(),
          ),
          GoRoute(
            path: '/doctor/appointments/new',
            builder: (context, state) => const ScheduleAppointmentScreen(),
          ),
          GoRoute(
            path: '/doctor/prescribe/:patientId',
            builder: (context, state) => CreatePrescriptionScreen(
              patientId: int.parse(state.pathParameters['patientId']!),
            ),
          ),

          GoRoute(
            path: '/patient/appointments',
            builder: (context, state) => const AppointmentsScreen(),
          ),
          GoRoute(
            path: '/patient/lifestyle',
            builder: (context, state) => const LifestyleAdviceScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
