import 'package:flutter/material.dart';
import 'package:movie_theater/config/config_theme.dart';

class BorderedButton extends StatelessWidget {
  BorderedButton({
    super.key,
    required this.content,
  });

  String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ThemeConfig.nearlyWhiteColor,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
        child: GestureDetector(
          onTap: () {},
          child: Text(content,
              style:
                  TextStyle(color: ThemeConfig.nearlyWhiteColor, fontSize: 12)),
        ),
      ),
    );
  }
}
