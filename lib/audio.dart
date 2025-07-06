import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import 'data.dart';
import 'lyrics_view.dart';
import 'notify.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
//import 'package:spotifyui/state_management/notify.dart';

class AudioPlayerPro extends StatefulWidget {
  const AudioPlayerPro(
      {super.key,
      required this.audioURL,
      required this.image,
      required this.name});

  final String audioURL;
  final String image;
  final String name;

  @override
  AudioPlayerProSetup createState() => AudioPlayerProSetup();
}

class AudioPlayerProSetup extends State<AudioPlayerPro> {
  final Data data = Get.find<Data>();
  Notify notify = Get.find();

  bool isHeartPressed = false;
  bool isPlayPressed = false;

  // double _value = 0;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  static AudioPlayer advancedPlayer = AudioPlayer();

  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerStateSubscription;

  String song1Name = 'Daadario classical';

  String altImage =
      "https://www.music-for-music-teachers.com/images/xgirl-with-guitar-black-and-white-502-height.jpg.pagespeed.ic.ok6HIO6Pb2.jpg";

  bool isNext = false;
  bool isIconPressed = false;

  @override
  void initState() {
    super.initState();
    setupAudioPlayer();
    initPlayer();
  }

  void setupAudioPlayer() {
    advancedPlayer.setReleaseMode(ReleaseMode.stop);

    durationSubscription = advancedPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });

    positionSubscription = advancedPlayer.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });

    playerStateSubscription =
        advancedPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        notify.isIconPlay.value = state == PlayerState.playing;
      }
    });
  }

  Future<void> handlePlayPause() async {
    if (!mounted) return;

    try {
      if (notify.isIconPlay.value) {
        await advancedPlayer.pause();
        notify.setIconPlay(false);
      } else {
        if (advancedPlayer.state == PlayerState.paused) {
          await advancedPlayer.resume();
        } else {
          await advancedPlayer.play(UrlSource(widget.audioURL));
        }
        notify.setIconPlay(true);
      }
    } catch (e) {
      print('Error handling play/pause: $e');
    }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  void dispose() {
    durationSubscription?.cancel();
    positionSubscription?.cancel();
    playerStateSubscription?.cancel();
    advancedPlayer.dispose();
    super.dispose();
  }

  Future<void> initNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'music_playback',
          channelName: 'Music Playback',
          channelDescription: 'Music playback controls',
          defaultColor: Colors.green,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: false,
          enableVibration: false,
        ),
      ],
    );

    // Request notification permissions
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // Handle app lifecycle changes
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // App going to background
      if (notify.isIconPlay.value) {
        showMusicNotification();
      }
    }
  }

  Future<void> showMusicNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'music_playback',
        title: 'Now Playing',
        body: widget.name,
        category: NotificationCategory.Transport,
        notificationLayout: NotificationLayout.MediaPlayer,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PREVIOUS',
          label: 'Previous',
          actionType: ActionType.KeepOnTop,
        ),
        NotificationActionButton(
          key: notify.isIconPlay.value ? 'PAUSE' : 'PLAY',
          label: notify.isIconPlay.value ? 'Pause' : 'Play',
          actionType: ActionType.KeepOnTop,
        ),
        NotificationActionButton(
          key: 'NEXT',
          label: 'Next',
          actionType: ActionType.KeepOnTop,
        ),
      ],
    );
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    advancedPlayer.setReleaseMode(ReleaseMode.loop);
    advancedPlayer.onDurationChanged
        .listen((d) => setState(() => _duration = d));

    advancedPlayer.onPositionChanged
        .listen((p) => setState(() => _position = p));

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        switch (receivedAction.buttonKeyPressed) {
          case 'PLAY':
            await advancedPlayer.resume();
            notify.setIconPlay(true);
            break;
          case 'PAUSE':
            await advancedPlayer.pause();
            notify.setIconPlay(false);
            break;
          case 'PREVIOUS':
          case 'NEXT':
            // Implement previous/next functionality
            break;
        }

        // Update notification with new play state
        showMusicNotification();
      },
    );
  }

  double setChanged() {
    Duration newDuration = const Duration(seconds: 0);
    advancedPlayer.seek(newDuration);
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 40,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.brown,
              Colors.black87,
            ],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(
                    LineIcons.angleDown,
                    color: Colors.white,
                    size: 24,
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        "PLAYING FROM ALBUM",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        isNext ? song1Name : widget.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontFamily: "ProximaNova",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    LineIcons.verticalEllipsis,
                    // LineIcons.ellipsis_v,
                    color: Colors.white,
                    size: 24,
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              isNext
                  ? SizedBox(
                      width: 325,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(altImage,
                            height: 325, width: 50, fit: BoxFit.cover),
                      ),
                    )
                  : SizedBox(
                      width: 325,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(widget.image)),
                    ),
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          isNext ? song1Name : widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "ProximaNova",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 0.2,
                          ),
                        ),
                        Text(
                          "Classics",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.lyrics_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Show lyrics view
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LyricsView(
                              songName: widget.name,
                              artist:
                                  "Artist Name", // Add artist name parameter
                            ),
                          ),
                        );
                        // Fetch lyrics when viewing
                        data.fetchLyrics(widget.name, "Artist Name");
                      },
                    ),
                    Obx(() => IconButton(
                          icon: (data.likedSongs
                                  .any((song) => song['name'] == widget.name))
                              ? const Icon(Icons.favorite,
                                  color: Colors.green, size: 30)
                              : Icon(LineIcons.heart,
                                  color: Colors.grey.shade400, size: 30),
                          onPressed: () {
                            setState(() {
                              data.toggleLikedSong({
                                'name': widget.name,
                                'image': widget.image,
                                'audio': widget.audioURL,
                              });
                            });
                          },
                        )),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade600,
                        activeTickMarkColor: Colors.white,
                        thumbColor: Colors.white,
                        trackHeight: 3,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 4,
                        ),
                      ),
                      child: Slider(
                        value: (_position.inSeconds.toDouble() !=
                                _duration.inSeconds.toDouble())
                            ? _position.inSeconds.toDouble()
                            : setChanged(),
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            seekToSecond(value.toInt());
                            value = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${_position.inMinutes.toInt()}:${(_position.inSeconds % 60).toString().padLeft(2, "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${_duration.inMinutes.toInt()}:${(_duration.inSeconds % 60).toString().padLeft(2, "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 22, right: 22),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      LineIcons.random,
                      color: Colors.grey.shade400,
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () {
                        setState(() {
                          isNext = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: Center(
                        child: IconButton(
                          iconSize: 70,
                          alignment: Alignment.center,
                          icon: Obx(
                            () => (notify.isIconPlay.value)
                                ? const Icon(
                                    Icons.pause_circle_filled,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.play_circle_filled,
                                    color: Colors.white,
                                  ),
                          ),
                          // onPressed: () {
                          //   notify.isIconPlay.value =
                          //       notify.isIconPlay.value ? false : true;
                          //   setState(() {
                          //     isPlayPressed =
                          //         isPlayPressed == false ? true : false;
                          //     print(
                          //         "state of isPlayPressed is : $isPlayPressed");
                          //     if (notify.isIconPlay.value) {
                          //       print("Playing .....");
                          //       advancedPlayer.play(UrlSource(
                          //           'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'));
                          //       if (!isNext) {
                          //         advancedPlayer.play(UrlSource(
                          //             'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'));
                          //       }
                          //     } else {
                          //       print("Paused .....");
                          //       advancedPlayer.pause();
                          //     }
                          onPressed: () {
                            notify.isIconPlay.value = !notify.isIconPlay.value;
                            setState(() {
                              isPlayPressed = !isPlayPressed;
                              if (notify.isIconPlay.value) {
                                print("Playing .....");
                                notify.updateCurrentSong(
                                    widget.name, widget.image);
                                advancedPlayer.play(UrlSource(widget.audioURL));
                                if (!isNext) {
                                  advancedPlayer
                                      .play(UrlSource(widget.audioURL));
                                }
                              } else {
                                print("Paused .....");
                                advancedPlayer.pause();
                                notify.setIconPlay(false);
                              }
                              // AwesomeNotifications().createNotification(
                              //     content: NotificationContent(
                              //         //simgple notification
                              //         id: 123,
                              //         channelKey: 'basic',
                              //         //set configuration wuth key "basic"
                              //         title: 'Now Playing - ${widget.name}',
                              //         // body: 'This simple notification with action buttons in Flutter App',
                              //         payload: {"name": "FlutterCampus"},
                              //         autoDismissible: false,
                              //         displayOnBackground: true),
                              //     actionButtons: [
                              //       NotificationActionButton(
                              //         key: "play",
                              //         label: "play",
                              //         autoDismissible: false,
                              //         showInCompactView: true,
                              //         //actionType: ActionButtonType.KeepOnTop
                              //       ),
                              //       NotificationActionButton(
                              //         key: "pause",
                              //         label: "pause",
                              //         autoDismissible: false,
                              //         //actionType: ActionButtonType.KeepOnTop
                              //       ),
                              //       NotificationActionButton(
                              //         key: "stop",
                              //         label: "stop",
                              //         autoDismissible: false,
                              //         // actionType: ActionButtonType.KeepOnTop
                              //       )
                              //     ]);
                              // final myStream = AwesomeNotifications()
                              //     .actionStream
                              //     .asBroadcastStream();
                              //
                              // myStream.listen((action)
                              // AwesomeNotifications().setListeners(
                              //     onActionReceivedMethod: (receivedAction) {
                              //   if (receivedAction.buttonKeyPressed == "play") {
                              //     print("Open button is pressed");
                              //     advancedPlayer.play(UrlSource(
                              //         'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'));
                              //     notify.setIconPlay(true);
                              //   } else if (receivedAction.buttonKeyPressed ==
                              //       "pause") {
                              //     advancedPlayer.pause();
                              //     notify.setIconPlay(false);
                              //     print("Delete button is pressed.");
                              //   } else if (receivedAction.buttonKeyPressed ==
                              //       "stop") {
                              //     advancedPlayer.stop();
                              //     notify.setIconPlay(false);
                              //     print(receivedAction
                              //         .payload); //notification was pressed
                              //   }
                              // });
                              AwesomeNotifications().setListeners(
                                onActionReceivedMethod: (receivedAction) async {
                                  if (receivedAction.buttonKeyPressed ==
                                      "play") {
                                    print("Play button pressed");
                                    advancedPlayer.play(UrlSource(
                                      'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a',
                                    ));
                                    notify.setIconPlay(true);
                                  } else if (receivedAction.buttonKeyPressed ==
                                      "pause") {
                                    print("Pause button pressed");
                                    advancedPlayer.pause();
                                    notify.setIconPlay(false);
                                  } else if (receivedAction.buttonKeyPressed ==
                                      "stop") {
                                    print("Stop button pressed");
                                    advancedPlayer.stop();
                                    notify.setIconPlay(false);
                                  }
                                  return; // Explicitly return to avoid analyzer warnings
                                },
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () {
                        setState(() {
                          isNext = true;
                        });
                      },
                    ),
                    Icon(
                      Icons.repeat,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 22, right: 22),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.speaker_group_outlined,
                      color: Colors.grey.shade400,
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Share.share("spotify_clone/95461");
                      },
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.line_weight_sharp,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
