import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Notify extends GetxController {
  final isIconPlay = false.obs;
  final currentSongName = ''.obs;
  final currentSongImage = ''.obs;
  final audioPlayer = AudioPlayer();
  final currentSongUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setupAudioPlayer();
  }

  void setupAudioPlayer() {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isIconPlay.value = state == PlayerState.playing;
      if (state == PlayerState.playing) {
        showMusicNotification();
      }
    });
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final notify = Get.find<Notify>();

    switch (receivedAction.buttonKeyPressed) {
      case 'PLAY':
        await notify.audioPlayer.resume();
        notify.setIconPlay(true);
        break;
      case 'PAUSE':
        await notify.audioPlayer.pause();
        notify.setIconPlay(false);
        break;
      case 'STOP':
        await notify.audioPlayer.stop();
        notify.setIconPlay(false);
        await AwesomeNotifications().dismiss(1);
        break;
      case 'PREVIOUS':
        // Handle previous track
        break;
      case 'NEXT':
        // Handle next track
        break;
    }
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final notify = Get.find<Notify>();
    await notify.audioPlayer.stop();
    notify.setIconPlay(false);
  }

  void setIconPlay(bool value) {
    isIconPlay.value = value;
    if (value) {
      showMusicNotification();
    } else {
      AwesomeNotifications().dismiss(1);
    }
  }

  void updateCurrentSong(String name, String image) {
    currentSongName.value = name;
    currentSongImage.value = image;
    if (isIconPlay.value) {
      showMusicNotification();
    }
  }

  Future<void> showMusicNotification() async {
    if (currentSongName.isEmpty) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'music_playback',
        title: 'Now Playing',
        body: currentSongName.value,
        category: NotificationCategory.Transport,
        displayOnBackground: true,
        displayOnForeground: true,
        notificationLayout: NotificationLayout.MediaPlayer,
        autoDismissible: false,
        largeIcon: currentSongImage.value,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PREVIOUS',
          label: 'Previous',
          actionType: ActionType.KeepOnTop,
          enabled: true,
        ),
        NotificationActionButton(
          key: isIconPlay.value ? 'PAUSE' : 'PLAY',
          label: isIconPlay.value ? 'Pause' : 'Play',
          actionType: ActionType.KeepOnTop,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'NEXT',
          label: 'Next',
          actionType: ActionType.KeepOnTop,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'STOP',
          label: 'Stop',
          actionType: ActionType.KeepOnTop,
          enabled: true,
        ),
      ],
    );
  }

  Future<void> playAudio(String url) async {
    currentSongUrl.value = url;
    await audioPlayer.play(UrlSource(url));
    setIconPlay(true);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    setIconPlay(false);
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setIconPlay(false);
    await AwesomeNotifications().dismiss(1);
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
