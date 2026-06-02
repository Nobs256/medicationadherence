import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/notification_polling_provider.dart';
import '../../domain/models/app_notification.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          TextButton(
            onPressed:
                () =>
                    ref
                        .read(notificationActionsProvider.notifier)
                        .markAllAsRead(),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notificationsProvider.future),
        child: notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return const Center(child: Text('No notifications yet'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return _NotificationTile(notification: n);
              },
            );
          },
          loading:
              () => Padding(
                padding: const EdgeInsets.all(16),
                child: LoadingShimmer.list(count: 6),
              ),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  final AppNotification notification;
  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        if (!notification.isRead) {
          ref
              .read(notificationActionsProvider.notifier)
              .markAsRead(notification.id);
        }
        // Navigation logic based on reference_table
        if (notification.referenceTable == 'medication_schedules') {
          context.push('/patient/schedule');
        } else if (notification.referenceTable == 'prescriptions') {
          context.push('/patient/prescriptions/${notification.referenceId}');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              notification.isRead
                  ? Colors.white
                  : AppColors.primaryLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: _getIconColor(
                notification.type,
              ).withOpacity(0.1),
              child: Icon(
                _getIcon(notification.type),
                color: _getIconColor(notification.type),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppTextStyles.h3.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(notification.body, style: AppTextStyles.bodySm),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat(
                      'MMM d, h:mm a',
                    ).format(DateTime.parse(notification.sentAt)),
                    style: AppTextStyles.label.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) =>
      type.contains('medication') ? Icons.medication : Icons.info_outline;
  Color _getIconColor(String type) =>
      type.contains('medication') ? AppColors.primary : AppColors.accent;
}
