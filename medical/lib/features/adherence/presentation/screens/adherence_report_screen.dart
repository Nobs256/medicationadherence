import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/adherence_provider.dart';
import '../../../patient/presentation/providers/patient_provider.dart';

class AdherenceReportScreen extends ConsumerWidget {
  const AdherenceReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 6));
    final dateFormat = DateFormat('yyyy-MM-dd');

    final logsAsync = ref.watch(
      adherenceLogsProvider((
        from: dateFormat.format(weekAgo),
        to: dateFormat.format(now),
      )),
    );

    final summaryAsync = ref.watch(adherenceSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Adherence Report', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryStats(summaryAsync),
            const SizedBox(height: 32),
            const Text('Last 7 Days Progress', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            _buildChart(logsAsync),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStats(AsyncValue<Map<String, dynamic>> summaryAsync) {
    return summaryAsync.when(
      data: (data) {
        final monthlyAvg = data['monthly']?['monthly_avg'] ?? 0;
        final streak = data['best_streak_days'] ?? 0;

        return Row(
          children: [
            _statCard(
              'Monthly Avg',
              '$monthlyAvg%',
              Icons.trending_up,
              AppColors.primary,
            ),
            const SizedBox(width: 16),
            _statCard(
              'Day Streak',
              '$streak Days',
              Icons.local_fire_department,
              AppColors.accent,
            ),
          ],
        );
      },
      loading: () => const LoadingShimmer(height: 100),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: AppTextStyles.h2),
            Text(label, style: AppTextStyles.bodySm),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(AsyncValue<List<dynamic>> logsAsync) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const Center(child: Text('No data for this week'));
          }

          return BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= logs.length) return const SizedBox();
                      final date = DateTime.parse(logs[value.toInt()].logDate);
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat('E').format(date),
                          style: AppTextStyles.bodySm,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(logs.length, (i) {
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: logs[i].adherencePercentage,
                      color: AppColors.primary,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
