import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../audio.dart';
import '../data.dart';

class LikedSongsPage extends StatelessWidget {
  LikedSongsPage({Key? key}) : super(key: key);

  final Data data = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Songs'),
        backgroundColor: Colors.black,
      ),
      body: Obx(() => ListView.builder(
            itemCount: data.likedSongs.length,
            itemBuilder: (context, index) {
              final song = data.likedSongs[index];
              return ListTile(
                leading: Image.asset(song['image'], width: 50, height: 50),
                title:
                    Text(song['name'], style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioPlayerPro(
                        audioURL: song['audio'],
                        image: song['image'],
                        name: song['name'],
                      ),
                    ),
                  );
                },
              );
            },
          )),
      backgroundColor: Colors.black,
    );
  }
}
