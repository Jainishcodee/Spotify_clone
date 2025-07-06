import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

import '../notify.dart';

class NotificationController {
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // Default icon for notifications
      [
        NotificationChannel(
          channelKey: 'music_player',
          channelName: 'Music Player',
          channelDescription: 'Music player controls notification',
          defaultColor: const Color(0xFF1DB954), // Spotify green
          ledColor: const Color(0xFF1DB954),
          importance: NotificationImportance.High,
          playSound: false,
          enableVibration: false,
          locked: true, // Makes notification persistent
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
      ],
    );
  }

  static Future<void> createMusicNotification({
    required String songName,
    required String artistName,
    required bool isPlaying,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'music_player',
        title: songName,
        body: artistName,
        category: NotificationCategory.Transport,
        notificationLayout: NotificationLayout.MediaPlayer,
        autoDismissible: false,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PREVIOUS',
          label: 'Previous',
          showInCompactView: false,
          actionType: ActionType.Default,
          icon: 'resource://drawable/ic_previous',
        ),
        NotificationActionButton(
          key: isPlaying ? 'PAUSE' : 'PLAY',
          label: isPlaying ? 'Pause' : 'Play',
          showInCompactView: true,
          actionType: ActionType.Default,
          icon: isPlaying
              ? 'resource://drawable/ic_pause'
              : 'resource://drawable/ic_play',
        ),
        NotificationActionButton(
          key: 'NEXT',
          label: 'Next',
          showInCompactView: false,
          actionType: ActionType.Default,
          icon: 'resource://drawable/ic_next',
        ),
      ],
    );
  }

  static Future<void> handleNotificationActions(ReceivedAction action) async {
    final buttonKey = action.buttonKeyPressed;

    switch (buttonKey) {
      case 'PLAY':
        // Handle play action
        Get.find<Notify>().setIconPlay(true);
        await createMusicNotification(
          songName: action.title ?? '',
          artistName: action.body ?? '',
          isPlaying: true,
        );
        break;

      case 'PAUSE':
        // Handle pause action
        Get.find<Notify>().setIconPlay(false);
        await createMusicNotification(
          songName: action.title ?? '',
          artistName: action.body ?? '',
          isPlaying: false,
        );
        break;

      case 'PREVIOUS':
        // Handle previous track
        break;

      case 'NEXT':
        // Handle next track
        break;
    }
  }
}
