import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/adherence_log.dart';

final adherenceLogsProvider =
    FutureProvider.family<List<AdherenceLog>, ({String from, String to})>((
      ref,
      range,
    ) async {
      final api = ref.watch(apiServiceProvider);
      final response = await api.get(
        '/adherence',
        params: {'from': range.from, 'to': range.to},
      );

      final List<dynamic> data = response['data'] ?? [];
      return data
          .map((json) => AdherenceLog.fromJson(json as Map<String, dynamic>))
          .toList();
    });
