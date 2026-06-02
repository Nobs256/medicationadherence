import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/services/api_service.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../../domain/models/medication_schedule.dart';
import '../providers/patient_provider.dart';
import '../../../notifications/presentation/providers/notification_polling_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:fl_chart/fl_chart.dart';


class PatientDashboard extends ConsumerWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final schedulesAsync = ref.watch(todaySchedulesProvider);
    final summaryAsync = ref.watch(adherenceSummaryProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider).value ?? 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(apiServiceProvider).triggerInternalTasks();
          ref.invalidate(todaySchedulesProvider);
          ref.invalidate(adherenceSummaryProvider);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                title: Text(
                  'Hello, ${user?.fullName.split(' ')[0] ?? 'Patient'}',
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Badge(
                    label: Text('$unreadCount'),
                    isLabelVisible: unreadCount > 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: () => context.push('/notifications'),
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAdherenceCard(summaryAsync),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today\'s Schedule',
                          style: AppTextStyles.h3,
                        ),
                        TextButton(
                          onPressed: () => context.go('/patient/schedule'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildSchedulePreview(schedulesAsync, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdherenceCard(AsyncValue<Map<String, dynamic>> summaryAsync) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: summaryAsync.when(
        data: (data) {
          final double percentage =
              double.tryParse(
                data['weekly']?['weekly_avg']?.toString() ?? '0',
              ) ??
              0;
          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Weekly Adherence', style: AppTextStyles.bodySm),
                    const SizedBox(height: 4),
                    Text(
                      '$percentage%',
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      percentage >= 80 ? 'Excellent progress!' : 'Keep it up!',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: [
                      PieChartSectionData(
                        color: AppColors.primary,
                        value: percentage,
                        radius: 8,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        color: AppColors.primaryLight,
                        value: 100 - percentage,
                        radius: 8,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingShimmer(height: 100),
        error: (_, __) => const Text('Unable to load adherence data'),
      ),
    );
  }

  Widget _buildSchedulePreview(
    AsyncValue<List<MedicationSchedule>> schedulesAsync,
    BuildContext context,
  ) {
    return schedulesAsync.when(
      data: (schedules) {
        if (schedules.isEmpty) {
          return const Center(
            child: Text('No medications scheduled for today.'),
          );
        }
        final upcoming =
            schedules.where((s) => s.status == 'pending').take(3).toList();

        return Column(
          children:
              upcoming
                  .map(
                    (s) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.medication,
                            color: AppColors.primary,
                          ),
                        ),
                        title: Text(s.medicationName, style: AppTextStyles.h3),
                        subtitle: Text(
                          '${s.dosage} • ${s.scheduledTime.split(' ')[1].substring(0, 5)}',
                        ),
                        trailing: StatusBadge.medication(s.status),
                        onTap:
                            () => context.push('/patient/medications/${s.id}'),
                      ),
                    ),
                  )
                  .toList(),
        );
      },
      loading: () => LoadingShimmer.list(count: 3),
      error: (_, __) => const Text('Unable to load schedule'),
    );
  }
}
