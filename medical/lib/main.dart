import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/services/onesignal_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  
  // Initialize OneSignal
  await container.read(onesignalServiceProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MediTrackApp(),
    ),
  );
}