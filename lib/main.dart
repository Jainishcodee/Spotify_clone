import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'Screen/home_page.dart';
import 'Screen/library.dart';
import 'Screen/premium.dart';
import 'Screen/search.dart';
import 'data.dart';
import 'notify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'music_playback',
        channelName: 'Music Playback',
        channelDescription: 'Music playback controls',
        importance: NotificationImportance.High,
        enableVibration: false,
        playSound: false,
        locked: true,
      ),
    ],
  );

  // Add @pragma('vm:entry-point') to ensure the handler works in background
  @pragma('vm:entry-point')
  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (!receivedAction.payload!.containsKey('notificationId')) {
      return;
    }
    // Handle the action
  }

  // Register background action handler
  await AwesomeNotifications().setListeners(
    onActionReceivedMethod: Notify.onActionReceivedMethod,
    onNotificationCreatedMethod: Notify.onNotificationCreatedMethod,
    onNotificationDisplayedMethod: Notify.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod: Notify.onDismissActionReceivedMethod,
  );

  Get.put(Data());
  Get.put(Notify());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Notify notify = Get.put(Notify());

  MyApp({super.key}); // Initialize GetX controller

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const Search(),
        '/library': (context) => const Library(),
        '/premium': (context) => const Premium(),
      },
    );
  }
}
