import 'package:flutter/material.dart';
import 'package:spotify_clone/Search_widgets/tiles.dart';
import 'package:spotify_clone/utils/data.dart';

class TopCharts extends StatelessWidget {
  const TopCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Your Top Genres",
          style: TextStyle(
              fontFamily: 'LibreFranklin',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Tiles(Data().genres),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Browse all",
          style: TextStyle(
              fontFamily: 'LibreFranklin',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Tiles(Data().browseall)
      ],
    );
  }
}
