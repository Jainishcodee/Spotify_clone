import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  RxList<Map<String, dynamic>> likedSongs = <Map<String, dynamic>>[].obs;
  RxString currentLyrics = ''.obs;
  var playlist = [
    {
      'name': 'Alicia Keys',
      'image': 'assets/images/aliciakeys.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Where the Light',
      'image': 'assets/images/johnmayer.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Pesa Nasha Pyar',
      'image': 'assets/images/bohemia.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'This is Eric',
      'image': 'assets/images/ericclapton.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Bealtes',
      'image': 'assets/images/beatles.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Gentle Guitar',
      'image': 'assets/images/gentleguitar.png',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
  ];

  var recentlyPlayed = [
    {
      'name': 'Gentle Guitar',
      'image': 'assets/images/gentleguitar.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio': 'https://www.computerhope.com/jargon/m/example.mp3'
    },
    {
      'name': 'Alicia Keys',
      'image': 'assets/images/aliciakeys.png',
      'shape': GFAvatarShape.circle,
      'alignment': CrossAxisAlignment.center,
      'audio': 'https://www.computerhope.com/jargon/m/example.mp3'
    },
    {
      'name': 'Fallin\'',
      'image': 'assets/images/fallin.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Pesa Nasha Pyar',
      'image': 'assets/images/bohemia.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Where the Light',
      'image': 'assets/images/johnmayer.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Girlfriend',
      'image': 'assets/images/girlfriend.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Thunderstruck',
      'image': 'assets/images/thunderstruck.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Hummingbird',
      'image': 'assets/images/hummingbird.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Continuum',
      'image': 'assets/images/continuum.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
  ];

  var anotherRandomList = [
    {
      'name': 'The Beatles',
      'image': 'assets/images/beatles.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Harry James',
      'image': 'assets/images/franksinatra.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'This is Eric',
      'image': 'assets/images/ericclapton.png',
      'shape': GFAvatarShape.square,
      'alignment': CrossAxisAlignment.start,
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
  ];

  var genres = [
    'assets/images/pop.jpg',
    'assets/images/hiphop.jpg',
    'assets/images/rnb.jpg',
    'assets/images/rock.jpg',
  ];

  var browseall = [
    'assets/images/podcasts.jpg',
    'assets/images/newrelease.jpg',
    'assets/images/charts.jpg',
    'assets/images/concerts.jpg',
    'assets/images/madeforyou.jpg',
    'assets/images/athome.jpg',
    'assets/images/onlyyou.jpg',
    'assets/images/covid19guide.jpg',
    'assets/images/bollywood.jpg',
    'assets/images/equal.jpg',
  ];

  var library = [
    {
      'name': 'Gentle Guitar',
      'subtitle': 'Playlist • Epidemic Sound',
      'image': 'assets/images/gentleguitar.png',
      'shape': GFAvatarShape.square,
    },
    {
      'name': 'John Mayer',
      'subtitle': 'Artist',
      'image': 'assets/images/johnmayerr.png',
      'shape': GFAvatarShape.circle,
    },
    {
      'name': 'Coldplay',
      'subtitle': 'Artist',
      'image': 'assets/images/coldplay.png',
      'shape': GFAvatarShape.circle,
    },
  ];

  var carousel = [
    {
      'free': 'Ad breaks',
      'premium': 'Ad-free music',
    },
    {
      'free': 'Streaming only',
      'premium': 'Download songs',
    },
    {
      'free': 'Listen alone',
      'premium': 'Group session',
    },
  ];

  var artists = [
    {
      'name': 'John Mayer',
      'image': 'assets/images/johnmayer.png',
      'monthlyListeners': 15482974,
      'songs': [
        {
          'name': 'Gravity',
          'image': 'assets/images/continuum.png',
          'plays': '824,584,123',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'Slow Dancing in a Burning Room',
          'image': 'assets/images/continuum.png',
          'plays': '654,789,321',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'New Light',
          'image': 'assets/images/JohnMayerNewLight.jpg',
          'plays': '524,987,654',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        }
      ]
    },
    {
      'name': 'Eric Clapton',
      'image': 'assets/images/ericclapton.png',
      'monthlyListeners': 12784569,
      'songs': [
        {
          'name': 'Tears in Heaven',
          'image': 'assets/images/ericclapton.png',
          'plays': '925,784,123',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'Wonderful Tonight',
          'image': 'assets/images/ericclapton.png',
          'plays': '854,123,789',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'Layla',
          'image': 'assets/images/ericclapton.png',
          'plays': '754,987,321',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        }
      ]
    },
    {
      'name': 'Alicia Keys',
      'image': 'assets/images/aliciakeys.png',
      'monthlyListeners': 18965432,
      'songs': [
        {
          'name': 'If I Ain\'t Got You',
          'image': 'assets/images/aliciakeys.png',
          'plays': '987,654,321',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'Girl on Fire',
          'image': 'assets/images/aliciakeys.png',
          'plays': '875,421,698',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        },
        {
          'name': 'Fallin\'',
          'image': 'assets/images/fallin.png',
          'plays': '965,874,123',
          'audio':
              'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
        }
      ]
    }
  ];

  var trendingSongs = [
    {
      'name': 'Vampire',
      'artist': 'Olivia Rodrigo',
      'image': 'assets/images/vampire.jpg',
      'weeklyPlays': '12.5M',
      'duration': '3:39',
      'audio':
          'https://open.spotify.com/track/1kuGVB7EU95pJObxwvfwKS?si=b9a290a2af5f4391'
    },
    {
      'name': 'Last Night',
      'artist': 'Morgan Wallen',
      'image': 'assets/images/lastNight.jpg',
      'weeklyPlays': '11.8M',
      'duration': '2:44',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Cruel Summer',
      'artist': 'Taylor Swift',
      'image': 'assets/images/cruelsummer.jpg',
      'weeklyPlays': '10.9M',
      'duration': '2:58',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Paint The Town Red',
      'artist': 'Doja Cat',
      'image': 'assets/images/paintthetownred.jpg',
      'weeklyPlays': '9.7M',
      'duration': '3:50',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Flowers',
      'artist': 'Miley Cyrus',
      'image': 'assets/images/flowers.jpg',
      'weeklyPlays': '9.2M',
      'duration': '3:20',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Kill Bill',
      'artist': 'SZA',
      'image': 'assets/images/killbill.jpg',
      'weeklyPlays': '8.8M',
      'duration': '2:33',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Anti-Hero',
      'artist': 'Taylor Swift',
      'image': 'assets/images/antihero.jpg',
      'weeklyPlays': '8.5M',
      'duration': '3:20',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Rich Flex',
      'artist': 'Drake & 21 Savage',
      'image': 'assets/images/richflex.jpg',
      'weeklyPlays': '8.1M',
      'duration': '3:59',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'Unholy',
      'artist': 'Sam Smith & Kim Petras',
      'image': 'assets/images/unholy.jpg',
      'weeklyPlays': '7.9M',
      'duration': '2:36',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
    {
      'name': 'about damn time',
      'artist': 'Sam Smith & Kim Petras',
      'image': 'assets/images/itsaboutdamntime.jpg',
      'weeklyPlays': '7.9M',
      'duration': '2:36',
      'audio':
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'
    },
  ];

  void toggleLikedSong(Map<String, dynamic> song) {
    if (likedSongs.any((likedSong) => likedSong['name'] == song['name'])) {
      likedSongs.removeWhere((likedSong) => likedSong['name'] == song['name']);
    } else {
      likedSongs.add(song);
    }
    likedSongs.refresh();
  }

  Future<void> fetchLyrics(String songName, String artist) async {
    try {
      currentLyrics.value = "Loading lyrics...";

      // Example API call - replace with your chosen lyrics API
      final response = await http.get(
          Uri.parse('YOUR_LYRICS_API_ENDPOINT?song=$songName&artist=$artist'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentLyrics.value = data['lyrics'] ?? 'Lyrics not found';
      } else {
        currentLyrics.value = 'Failed to load lyrics';
      }
    } catch (e) {
      currentLyrics.value = 'Error loading lyrics';
    }
  }
}
