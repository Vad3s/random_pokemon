import 'package:flutter/material.dart';
import 'package:random_pokemon/src/features/pokemon/presentation/pokemon_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PokemonScreen());
  }
}
