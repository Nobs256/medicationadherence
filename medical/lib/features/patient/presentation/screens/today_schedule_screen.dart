import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/patient_provider.dart';
import '../widgets/schedule_timeline_card.dart';

class TodayScheduleScreen extends ConsumerWidget {
  const TodayScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(todaySchedulesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daily Schedule', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(todaySchedulesProvider.future),
        child: schedulesAsync.when(
          data: (schedules) {
            if (schedules.isEmpty) {
              return const Center(
                child: Text('No medications scheduled for today.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return ScheduleTimelineCard(schedule: schedules[index]);
              },
            );
          },
          loading:
              () => Padding(
                padding: const EdgeInsets.all(20),
                child: LoadingShimmer.list(count: 5),
              ),
          error:
              (error, _) => Center(
                child: Text(
                  'Error: ${error.toString()}',
                  textAlign: TextAlign.center,
                ),
              ),
        ),
      ),
    );
  }
}
