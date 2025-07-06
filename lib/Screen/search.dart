import 'package:flutter/material.dart';
import 'package:spotify_clone/Search_widgets/top_charts.dart';

import '../Search_widgets/search_widget.dart';
import '../bottom_navigation.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 80),
        body: Container(
          child: ListView(
            children: const [
              Text(
                "Search",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: 'LibreFranklin',
                    fontWeight: FontWeight.bold),
              ),
              SearchWidget(),
              TopCharts()
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(1),
      ),
    );
  }
}
