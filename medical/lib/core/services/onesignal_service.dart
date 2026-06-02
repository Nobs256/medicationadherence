import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';
import 'storage_service.dart';

final onesignalServiceProvider = Provider((ref) => OneSignalService(
      ref.read(apiServiceProvider),
      ref.read(storageServiceProvider),
    ));

class OneSignalService {
  final ApiService _api;
  final StorageService _storage;

  OneSignalService(this._api, this._storage);

  Future<void> init() async {
    // TODO: Replace with your actual OneSignal App ID from .env
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("YOUR_ONESIGNAL_APP_ID");

    // The promptForPushNotificationsSettionsWithUserResponse function will show the iOS or Android notification prompt. 
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);

    await _syncPlayerId();
  }

  Future<void> _syncPlayerId() async {
    final hasToken = await _storage.hasToken();
    if (!hasToken) return;

    final deviceState = OneSignal.User.pushSubscription.id;
    if (deviceState != null) {
      try {
        await _api.put('/users/onesignal-id',
            data: {'onesignal_player_id': deviceState});
      } catch (e) {
        // Silent fail on sync
      }
    }
  }
}