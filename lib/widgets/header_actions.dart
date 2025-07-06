import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 130),
        Icon(
          Icons.history,
          color: Colors.white,
          size: 25,
        ),
        SizedBox(width: 25),
        Icon(
          FontAwesomeIcons.gear,
          color: Colors.white,
          size: 25,
        )
      ],
    );
  }
}
