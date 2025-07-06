import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import '../notify.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  final _player = AudioPlayer();
  final notify = Get.find<Notify>();
  MediaItem? _currentMedia;

  AudioPlayerHandler() {
    _player.playbackEventStream.listen(_broadcastState);

    _player.playerStateStream.listen((playerState) {
      notify.setIconPlay(playerState.playing);
    });
  }

  // Initialize with a media item
  Future<void> playMusic({
    required String url,
    required String title,
    required String artist,
    required String artUrl,
    required String duration,
  }) async {
    try {
      _currentMedia = MediaItem(
        id: url,
        title: title,
        artist: artist,
        artUri: Uri.parse(artUrl),
        duration: Duration(milliseconds: int.parse(duration)),
      );

      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: _currentMedia,
        ),
      );

      mediaItem.add(_currentMedia);
      await play();
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  @override
  Future<void> play() async {
    await _player.play();
    notify.setIconPlay(true);
    playbackState.add(playbackState.value.copyWith(playing: true));
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    notify.setIconPlay(false);
    playbackState.add(playbackState.value.copyWith(playing: false));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    notify.setIconPlay(false);
    playbackState.add(playbackState.value.copyWith(playing: false));
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: 0,
    ));
  }
}
