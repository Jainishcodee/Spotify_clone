import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final List<String> something;
  const Tiles(
    this.something, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: something.map((imageUrl) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ));
        }).toList(),
      ),
    );
  }
}
