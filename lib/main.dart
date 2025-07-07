
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'Screen/home_page.dart';
// import 'Screen/library.dart';
// import 'Screen/premium.dart';
// import 'Screen/search.dart';
// import 'data.dart';
// import 'notify.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   await AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//         channelKey: 'music_playback',
//         channelName: 'Music Playback',
//         channelDescription: 'Music playback controls',
//         importance: NotificationImportance.High,
//         enableVibration: false,
//         playSound: false,
//         locked: true,
//       ),
//     ],
//   );

//   // Add @pragma('vm:entry-point') to ensure the handler works in background
//   @pragma('vm:entry-point')
//   Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//     if (!receivedAction.payload!.containsKey('notificationId')) {
//       return;
//     }
//     // Handle the action
//   }

//   // Register background action handler
//   await AwesomeNotifications().setListeners(
//     onActionReceivedMethod: Notify.onActionReceivedMethod,
//     onNotificationCreatedMethod: Notify.onNotificationCreatedMethod,
//     onNotificationDisplayedMethod: Notify.onNotificationDisplayedMethod,
//     onDismissActionReceivedMethod: Notify.onDismissActionReceivedMethod,
//   );

//   Get.put(Data());
//   Get.put(Notify());

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Notify notify = Get.put(Notify());

//   MyApp({super.key}); // Initialize GetX controller

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const HomePage(),
//         '/search': (context) => const Search(),
//         '/library': (context) => const Library(),
//         '/premium': (context) => const Premium(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Screen/home_page.dart';
import 'Screen/library.dart';
import 'Screen/premium.dart';
import 'Screen/search.dart';
import 'data.dart';
import 'notify.dart';

// Create a single instance of the local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Android notification channel definition
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'music_playback', // id
    'Music Playback', // name
    description: 'Music playback controls',
    importance: Importance.high,
    playSound: false,
    enableVibration: false,
    showBadge: false,
  );

  // Initialization settings for Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  // Initialize the plugin
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification taps when the app is in foreground/background
      final String? payload = response.payload;
      if (payload != null) {
        // Add logic here if you want to navigate or do something
        debugPrint('Notification payload: $payload');
      }
    },
  );

  // Create the channel if not already existing
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Register GetX controllers globally
  Get.put(Data());
  Get.put(Notify());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Notify notify = Get.put(Notify());

  MyApp({super.key});

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
