import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';

class LyricsView extends StatelessWidget {
  final String songName;
  final String artist;

  const LyricsView({Key? key, required this.songName, required this.artist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyricUI = UINetease();
    final lyricModel = LyricsModelBuilder.create()
        .bindLyricToMain("Your lyrics here")
        .getModel();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(songName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LyricsReader(
        model: lyricModel,
        position: 0,
        lyricUi: lyricUI,
        playing: false,
        size: Size(double.infinity, MediaQuery.of(context).size.height),
        emptyBuilder: () => Center(
          child: Text(
            "No lyrics available",
            style: lyricUI.getOtherMainTextStyle(),
          ),
        ),
      ),
    );
  }
}
