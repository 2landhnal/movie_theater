import 'package:flutter/material.dart';

class HomePagePromoList extends StatelessWidget {
  const HomePagePromoList({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.width * 0.7 * 3 / 6,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: screenSize.width * 0.7,
              )),
    );
  }
}
