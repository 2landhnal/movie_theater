import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/config/config_theme.dart';

class HomePageNearTheater extends StatelessWidget {
  const HomePageNearTheater({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(color: Colors.amber),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Find theater near u",
            style: ThemeConfig.gettextStyle(),
          ),
          const Icon(
            Icons.local_activity,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
