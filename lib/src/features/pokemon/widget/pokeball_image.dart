import 'package:flutter/material.dart';

class PokeballImage extends StatelessWidget {
  const PokeballImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pokeball.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
