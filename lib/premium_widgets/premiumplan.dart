import 'package:flutter/material.dart';

import './buttons.dart';

class PremiumPlan extends StatelessWidget {
  const PremiumPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(4, 87, 71, 60),
              Color.fromRGBO(9, 110, 80, 70),
              Color.fromRGBO(17, 151, 100, 100),
              Color.fromRGBO(18, 159, 104, 1),
              Color.fromRGBO(24, 185, 115, 50),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const SingleChildScrollView(
          // Wrap content with SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size dynamically
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Premium Individual',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹719',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'FOR 9 MONTHS',
                        style: TextStyle(
                          color: Color.fromRGBO(136, 205, 180, 100),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                '3 months free with 6 months of\nPremium • Ad-free music • Download to\nlisten offline',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Buttons(
                text: 'VIEW PLANS',
              ),
              SizedBox(height: 10),
              Text(
                'Terms and conditions apply. Open only to users who aren\'t subscribed to a recurring Premium plan and who haven\'t purchased a 12-month one-time Premium plan at a promotional price. Offer ends 8/12/24.',
                style: TextStyle(
                  color: Color.fromRGBO(184, 184, 184, 10),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
