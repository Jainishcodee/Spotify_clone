import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: (BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10))),
      child: const Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Color.fromRGBO(83, 83, 83, 1),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Artists songs or podcasts",
            style: TextStyle(
              fontFamily: 'LibreFranklin',
              color: Color.fromRGBO(83, 83, 83, 1),
              fontSize: 17,
            ),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.fade,
          )
        ],
      ),
    );
  }
}
