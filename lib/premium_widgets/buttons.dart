import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key, required this.text});
  final String text;

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() async {
    try {
      razorpay.open({
        'name': 'Spotify Premium',
        'key': 'rzp_live_ILgsfZCZoFIKMB',
        'amount': 100,
        'description': 'General',
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prifill': {'contact': '9142400132', 'email': 'me@spotify.com'},
        'external': {
          'wallets': ['paytm']
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
        child: TextButton(
          onPressed: openCheckOut,
          style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
