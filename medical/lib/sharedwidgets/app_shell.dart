import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../features/auth/presentation/providers/auth_provider.dart';

class AppShell extends ConsumerWidget {
  static DateTime? _lastBackPressed;

  String _dashboardRouteForRole(String role) {
    switch (role) {
      case 'patient':
        return '/patient/dashboard';
      case 'doctor':
        return '/doctor/dashboard';
      case 'hospital_admin':
        return '/admin/dashboard';
      case 'super_admin':
        return '/super-admin/dashboard';
      default:
        return '';
    }
  }

  final Widget child;
  const AppShell({super.key, required this.child});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return child;

    final role = user.roleName;
    final tabs = _getTabsForRole(role);

    return WillPopScope(
      onWillPop: () async {
        final String location = GoRouterState.of(context).matchedLocation;
        final String dashboardRoute = _dashboardRouteForRole(role);

        // If route is unknown, avoid forcing navigation.
        if (dashboardRoute.isEmpty) return false;

        // If user is on dashboard -> double-tap to exit.
        if (location.startsWith(dashboardRoute)) {
          final now = DateTime.now();
          final last = _lastBackPressed;
          _lastBackPressed = now;
          if (last != null && now.difference(last) <= const Duration(seconds: 2)) {
            // let system handle exit
            return true;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Press back again to exit')),
          );
          return false;
        }

        // If not on dashboard -> go to dashboard.
        context.go(dashboardRoute);
        return false;
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context, tabs),
        onTap: (index) => context.go(tabs[index].route),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        items:
            tabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    label: tab.label,
                  ),
                )
                .toList(),
      ),
    ));
  }

  int _calculateSelectedIndex(BuildContext context, List<NavTab> tabs) {
    final String location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < tabs.length; i++) {
      if (location.startsWith(tabs[i].route)) {
        return i;
      }
    }
    return 0;
  }

  List<NavTab> _getTabsForRole(String role) {
    switch (role) {
      case 'patient':
        return [
          const NavTab(
            label: 'Home',
            icon: Icons.home_rounded,
            route: '/patient/dashboard',
          ),
          const NavTab(
            label: 'Schedule',
            icon: Icons.calendar_today_rounded,
            route: '/patient/schedule',
          ),
          const NavTab(
            label: 'Appointments',
            icon: Icons.people_outline_rounded,
            route: '/patient/appointments',
          ),
          const NavTab(
            label: 'Life Style',
            icon: Icons.bar_chart_rounded,
            route: '/patient/lifestyle',
          ),
          const NavTab(
            label: 'Profile',
            icon: Icons.person_outline_rounded,
            route: '/profile',
          ),
        ];
      case 'doctor':
        return [
          const NavTab(
            label: 'Home',
            icon: Icons.home_rounded,
            route: '/doctor/dashboard',
          ),
          const NavTab(
            label: 'Patients',
            icon: Icons.people_outline_rounded,
            route: '/doctor/patients',
          ),
          const NavTab(
            label: 'Appointments',
            icon: Icons.people_outline_rounded,
            route: '/doctor/appointments',
          ),
          const NavTab(
            label: 'Profile',
            icon: Icons.person_outline_rounded,
            route: '/profile',
          ),
        ];
      case 'hospital_admin':
        return [
          const NavTab(
            label: 'Home',
            icon: Icons.home_rounded,
            route: '/admin/dashboard',
          ),
          const NavTab(
            label: 'Doctors',
            icon: Icons.local_hospital_outlined,
            route: '/admin/doctors',
          ),
          const NavTab(
            label: 'Patients',
            icon: Icons.people_outline_rounded,
            route: '/admin/patients',
          ),
          const NavTab(
            label: 'Profile',
            icon: Icons.person_outline_rounded,
            route: '/profile',
          ),
        ];
      case 'super_admin':
        return [
          const NavTab(
            label: 'Home',
            icon: Icons.home_rounded,
            route: '/super-admin/dashboard',
          ),
          const NavTab(
            label: 'Hospitals',
            icon: Icons.business_rounded,
            route: '/super-admin/hospitals',
          ),
          const NavTab(
            label: 'Profile',
            icon: Icons.person_outline_rounded,
            route: '/profile',
          ),
        ];
      default:
        return [];
    }
  }
}

class NavTab {
  final String label;
  final IconData icon;
  final String route;
  const NavTab({required this.label, required this.icon, required this.route});
}
