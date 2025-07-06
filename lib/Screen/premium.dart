import 'package:flutter/material.dart';
import 'package:spotify_clone/premium_widgets/premiumplan.dart';

import '../bottom_navigation.dart';
import '../premium_widgets/buttons.dart';
import '../premium_widgets/carousel.dart';
import '../premium_widgets/currentplan.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 50),
      body: ListView(
        children: const [
          SizedBox(
            height: 70,
          ),
          Text(
            'Get 9 months of \n Premium for ₹ 100',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'LibreFranklin',
                fontWeight: FontWeight.bold),
          ),
          Cards(),
          Buttons(text: "GET PREMIUM"),
          SizedBox(
            height: 10,
          ),
          Text(
            "Terms and conditions apply. Open only to users who aren't subscribed to a recurring Premium plan and who haven't purchased a 12-month one-time Premium plan at a promotional price. Offer ends 8/12/24.",
            style: TextStyle(
                color: Color.fromRGBO(184, 184, 184, 10), fontSize: 14),
            textAlign: TextAlign.center,
          ),
          CurrentPlan(),
          PremiumPlan()
        ],
      ),
      bottomNavigationBar: const BottomBar(3),
    ));
  }
}
