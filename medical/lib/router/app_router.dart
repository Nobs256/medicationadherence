import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/appointments/presentation/screens/request_appointment_screen.dart';
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
import '../features/hospital_admin/presentation/screens/admin_doctor_detail_screen.dart';
import '../features/hospital_admin/presentation/screens/add_patient_screen.dart';
import '../features/hospital_admin/presentation/screens/assign_patient_screen.dart';
import '../features/super_admin/presentation/screens/super_admin_dashboard.dart';
import '../features/super_admin/presentation/screens/hospitals_list_screen.dart';
import '../features/super_admin/presentation/screens/add_hospital_screen.dart';
import '../features/super_admin/presentation/screens/hospital_detail_screen.dart';
import '../features/super_admin/presentation/screens/manage_hospital_admins_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';

final splashTimerProvider = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(seconds: 4));
});

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: _RouterRefreshListenable(ref),
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final splashTimer = ref.read(splashTimerProvider);

      final loggingIn = state.matchedLocation == '/login';
      final inSplash = state.matchedLocation == '/splash';
      final isSplashReady = !splashTimer.isLoading;

      return authState.when(
        data: (user) {
          // If on splash, stay there until timer is ready.
          if (inSplash && !isSplashReady) return null;

          if (user == null) {
            return loggingIn ? null : '/login';
          }

          // 2. If logged in and on an entry screen (splash/login), go to the dashboard.
          if (loggingIn || inSplash) {
            return ref.read(authStateProvider.notifier).getInitialRoute(user);
          }
          return null;
        },
        loading: () {
          // Don't redirect during background loading states (like signing in)
          if (loggingIn) return null;
          if (inSplash) return null;
          // Fallback for app startup
          return '/splash';
        },
        error: (err, stack) {
          if (inSplash && !isSplashReady) return null;
          return loggingIn ? null : '/login';
        },
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
            builder:
                (context, state) => HospitalDetailScreen(
                  id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
                ),
          ),
          GoRoute(
            path: '/super-admin/hospitals/:id/admins',
            builder: (context, state) => ManageHospitalAdminsScreen(
              hospitalId:
                  int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
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
            path: '/admin/doctors/:id',
            builder: (context, state) => AdminDoctorDetailScreen(
              doctorId:
                  int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
            ),
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
            builder:
                (context, state) => AssignPatientScreen(
                  patientId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
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
                  scheduleId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
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
                  id: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
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
                  patientId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
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
            builder:
                (context, state) => CreatePrescriptionScreen(
                  patientId: int.tryParse(state.pathParameters['patientId'] ?? '') ?? 0,
                ),
          ), 
          GoRoute(
            path: '/doctor/appointments',
            builder: (context, state) => const AppointmentsScreen(),
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
          GoRoute(
            path: '/request-appointment',
            builder: (context, state) => const RequestAppointmentScreen(),
          ),
        ],
      ),
    ],
  );
});

/// Helper class to convert Riverpod providers to a Listenable for GoRouter
class _RouterRefreshListenable extends ChangeNotifier {
  _RouterRefreshListenable(Ref ref) {
    // Re-evaluate redirects when auth state changes or splash timer finishes
    ref.listen(authStateProvider, (_, __) => notifyListeners());
    ref.listen(splashTimerProvider, (_, __) => notifyListeners());
  }
}
