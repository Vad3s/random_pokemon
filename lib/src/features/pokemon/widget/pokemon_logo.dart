import 'package:flutter/material.dart';

class PokeballLogo extends StatelessWidget {
  const PokeballLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.contain,
          alignment: Alignment(-1.0, 0),
        ),
      ),
    );
  }
}
