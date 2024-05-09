import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/config/config_theme.dart';

class RowHeader extends StatelessWidget {
  const RowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hot News",
            style: ThemeConfig.gettextStyle(
              fontWeight: FontWeight.bold,
              size: 12,
            ),
          ),
          SizedBox(
            height: 30,
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white, // your color here
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20)))),
              child: Text(
                "All",
                style: ThemeConfig.gettextStyle(
                  fontWeight: FontWeight.bold,
                  size: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
