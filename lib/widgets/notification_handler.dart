// import 'dart:ui';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';

// import '../notify.dart';

// class NotificationController {
//   static final NotificationController _instance =
//       NotificationController._internal();

//   factory NotificationController() {
//     return _instance;
//   }

//   NotificationController._internal();

//   static Future<void> initializeNotifications() async {
//     await AwesomeNotifications().initialize(
//       null, // Default icon for notifications
//       [
//         NotificationChannel(
//           channelKey: 'music_player',
//           channelName: 'Music Player',
//           channelDescription: 'Music player controls notification',
//           defaultColor: const Color(0xFF1DB954), // Spotify green
//           ledColor: const Color(0xFF1DB954),
//           importance: NotificationImportance.High,
//           playSound: false,
//           enableVibration: false,
//           locked: true, // Makes notification persistent
//           defaultRingtoneType: DefaultRingtoneType.Notification,
//         ),
//       ],
//     );
//   }

//   static Future<void> createMusicNotification({
//     required String songName,
//     required String artistName,
//     required bool isPlaying,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1,
//         channelKey: 'music_player',
//         title: songName,
//         body: artistName,
//         category: NotificationCategory.Transport,
//         notificationLayout: NotificationLayout.MediaPlayer,
//         autoDismissible: false,
//         displayOnBackground: true,
//         displayOnForeground: true,
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'PREVIOUS',
//           label: 'Previous',
//           showInCompactView: false,
//           actionType: ActionType.Default,
//           icon: 'resource://drawable/ic_previous',
//         ),
//         NotificationActionButton(
//           key: isPlaying ? 'PAUSE' : 'PLAY',
//           label: isPlaying ? 'Pause' : 'Play',
//           showInCompactView: true,
//           actionType: ActionType.Default,
//           icon: isPlaying
//               ? 'resource://drawable/ic_pause'
//               : 'resource://drawable/ic_play',
//         ),
//         NotificationActionButton(
//           key: 'NEXT',
//           label: 'Next',
//           showInCompactView: false,
//           actionType: ActionType.Default,
//           icon: 'resource://drawable/ic_next',
//         ),
//       ],
//     );
//   }

//   static Future<void> handleNotificationActions(ReceivedAction action) async {
//     final buttonKey = action.buttonKeyPressed;

//     switch (buttonKey) {
//       case 'PLAY':
//         // Handle play action
//         Get.find<Notify>().setIconPlay(true);
//         await createMusicNotification(
//           songName: action.title ?? '',
//           artistName: action.body ?? '',
//           isPlaying: true,
//         );
//         break;

//       case 'PAUSE':
//         // Handle pause action
//         Get.find<Notify>().setIconPlay(false);
//         await createMusicNotification(
//           songName: action.title ?? '',
//           artistName: action.body ?? '',
//           isPlaying: false,
//         );
//         break;

//       case 'PREVIOUS':
//         // Handle previous track
//         break;

//       case 'NEXT':
//         // Handle next track
//         break;
//     }
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../notify.dart';

// Singleton NotificationController using flutter_local_notifications
class NotificationController {
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'music_player',
    'Music Player',
    description: 'Music player controls notification',
    importance: Importance.high,
    playSound: false,
    enableVibration: false,
  );

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );

    // Initialize plugin
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: handleNotificationResponse,
    );

    // Create channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> createMusicNotification({
    required String songName,
    required String artistName,
    required bool isPlaying,
  }) async {
    const style = AndroidMediaStyleInformation(
      htmlFormatContent: true,
      htmlFormatTitle: true,
    );

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      playSound: false,
      enableVibration: false,
      ongoing: true,
      styleInformation: style,
      visibility: NotificationVisibility.public,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'PREVIOUS',
          'Previous',
          icon: DrawableResourceAndroidBitmap('ic_previous'),
        ),
        AndroidNotificationAction(
          isPlaying ? 'PAUSE' : 'PLAY',
          isPlaying ? 'Pause' : 'Play',
          icon: DrawableResourceAndroidBitmap(
              isPlaying ? 'ic_pause' : 'ic_play'),
          showsUserInterface: true,
        ),
        AndroidNotificationAction(
          'NEXT',
          'Next',
          icon: DrawableResourceAndroidBitmap('ic_next'),
        ),
      ],
    );

    final NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      songName,
      artistName,
      platformDetails,
      payload: isPlaying ? 'playing' : 'paused',
    );
  }

  static void handleNotificationResponse(NotificationResponse response) async {
    final buttonId = response.actionId;
    final notify = Get.find<Notify>();

    switch (buttonId) {
      case 'PLAY':
        notify.setIconPlay(true);
        await createMusicNotification(
          songName: notify.currentSongName.value,
          artistName: 'Artist', // Replace if available
          isPlaying: true,
        );
        break;

      case 'PAUSE':
        notify.setIconPlay(false);
        await createMusicNotification(
          songName: notify.currentSongName.value,
          artistName: 'Artist', // Replace if available
          isPlaying: false,
        );
        break;

      case 'PREVIOUS':
        // TODO: Implement previous logic if needed
        break;

      case 'NEXT':
        // TODO: Implement next logic if needed
        break;
    }
  }
}
