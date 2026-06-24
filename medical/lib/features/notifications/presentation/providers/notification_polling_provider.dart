import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/app_notification.dart';
import 'dart:async';

part 'notification_polling_provider.g.dart';

int _intFromAny(dynamic val) {
  if (val == null) return 0;
  if (val is int) return val;
  if (val is num) return val.toInt();
  if (val is String) return int.tryParse(val) ?? 0;
  return 0;
}

@riverpod
Stream<int> unreadNotificationCount(UnreadNotificationCountRef ref) async* {
  final api = ref.read(apiServiceProvider);

  // Immediate first fetch
  try {
    final res = await api.get('/notifications/unread-count');
    yield _intFromAny(res['data']['count']);
  } catch (_) {
    yield 0;
  }

  // Periodic poll every 30 seconds
  yield* Stream.periodic(const Duration(seconds: 30)).asyncMap((_) async {
    try {
      final res = await api.get('/notifications/unread-count');
      return _intFromAny(res['data']['count']);
    } catch (_) {
      return 0;
    }
  });
}

@riverpod
Future<List<AppNotification>> notifications(NotificationsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/notifications');
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => AppNotification.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
class NotificationActions extends _$NotificationActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> markAsRead(int id) async {
    final api = ref.read(apiServiceProvider);
    await api.post('/notifications/$id/read');
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadNotificationCountProvider);
  }

  Future<void> markAllAsRead() async {
    state = const AsyncValue.loading();
    final api = ref.read(apiServiceProvider);
    await api.post('/notifications/read-all');
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadNotificationCountProvider);
    state = const AsyncValue.data(null);
  }
}
