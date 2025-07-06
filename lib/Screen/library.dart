import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

import '../bottom_navigation.dart';
import '../data.dart';
import '../library_widgets/header.dart';
import '../library_widgets/library_tiles.dart';
import '../library_widgets/rounded_cards.dart';
import 'liked_songs.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    final Data data = Get.find<Data>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: ListView(
        children: [
          const Header(),
          const Row(
            children: [
              SizedBox(width: 10),
              RoundedCards('Playlists'),
              SizedBox(width: 10),
              RoundedCards('Artists'),
            ],
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.compare_arrows_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Recently played',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'LibreFranklin',
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
          Obx(
            () => GFListTile(
              avatar: GFAvatar(
                backgroundImage: AssetImage('assets/images/likedsongs.png'),
                radius: 30,
                shape: GFAvatarShape.square,
              ),
              title: Text(
                'Liked Songs',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subTitle: Text(
                '${data.likedSongs.length} songs',
                style: const TextStyle(
                  color: Color.fromRGBO(167, 167, 167, 1),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikedSongsPage(),
                  ),
                );
              },
            ),
          ),
          ...data.library.map((val) {
            return GFListTile(
              avatar: GFAvatar(
                backgroundImage: AssetImage(
                  val['image'].toString(),
                ),
                radius: 30,
                shape: val['shape'] as dynamic,
              ),
              title: Text(
                val['name'].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subTitle: Text(
                val['subtitle'].toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(167, 167, 167, 1),
                  fontSize: 14,
                ),
              ),
            );
          }),
          const Tiles('Add artists', GFAvatarShape.circle),
          const Tiles('Add podcasts & shows', GFAvatarShape.square),
        ],
      ),
      bottomNavigationBar: const BottomBar(2),
    );
  }
}
