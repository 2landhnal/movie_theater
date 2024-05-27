import 'package:flutter/material.dart';

class FullScreenCircularProgress extends StatelessWidget {
  const FullScreenCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(96, 171, 171, 171),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
