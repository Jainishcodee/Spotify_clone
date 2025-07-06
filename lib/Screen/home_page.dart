import 'package:flutter/material.dart';
import 'package:spotify_clone/widgets/jumpbackin.dart';
import 'package:spotify_clone/widgets/playlist.dart';
import 'package:spotify_clone/widgets/recent.dart';
import 'package:spotify_clone/data.dart';

import '../bottom_navigation.dart';
import '../widgets/header_actions.dart';
import '../widgets/artist_detail_page.dart';
import '../widgets/trending_music section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Data data = Data();

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(57, 90, 81, 1),
                Color.fromRGBO(46, 71, 65, 1),
                Color.fromRGBO(43, 64, 59, 1),
                Color.fromRGBO(18, 18, 18, 1),
              ],
              stops: [0.01, 0.03, 0.06, 0.2],
            ),
          ),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    "Good Evening",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LibreFranklin',
                    ),
                  ),
                  HeaderActions(),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 210,
                child: Playlists(),
              ),
              const SizedBox(height: 20),
              const RecentlyPlayed(),
              const JumpIn(),
              const SizedBox(height: 30),
              // New Artists Section
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Popular Artists",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 280,
                child: ArtistsSection(artists: data.artists),
              ),
              const SizedBox(height: 20),
              const TrendingMusic()
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(0),
      ),
    );
  }
}
