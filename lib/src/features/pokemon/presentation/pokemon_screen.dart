import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:random_pokemon/src/features/pokemon/widget/pokeball_image.dart';
import 'package:random_pokemon/src/features/pokemon/widget/pokemon_logo.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String? pokemonStandardImage;
  String? pokemonShinyImage;
  String? pokemonName;
  int? pokemonNumber;
  String? pokemonTyp;
  String? pokemonTyp2;

  Future<void> randomPokemon() async {
    final int randomIndex = Random().nextInt(1025) + 1;
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$randomIndex/'));

    if (response.statusCode == 200) {
      final pokemonView = jsonDecode(response.body);
      setState(() {
        pokemonName = pokemonView['name'][0].toUpperCase() +
            pokemonView['name'].substring(1);
        pokemonStandardImage = pokemonView['sprites']['other']
            ['official-artwork']['front_default'];
        pokemonShinyImage =
            pokemonView['sprites']['other']['official-artwork']['front_shiny'];
        pokemonNumber = pokemonView['id'];
        pokemonTyp = pokemonView['types'][0]['type']['name'][0].toUpperCase() +
            pokemonView['types'][0]['type']['name'].substring(1);
        pokemonTyp2 = pokemonView['types'].length > 1
            ? pokemonView['types'][1]['type']['name'][0].toUpperCase() +
                pokemonView['types'][1]['type']['name'].substring(1)
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const PokeballLogo(),
                  const SizedBox(height: 16),
                  if (pokemonStandardImage != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Normal',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Image.network(
                              pokemonStandardImage!,
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Text(
                              'Shiny',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            Image.network(
                              pokemonShinyImage!,
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (pokemonName != null)
                    Text('Name: $pokemonName',
                        style: const TextStyle(fontSize: 20)),
                  if (pokemonNumber != null)
                    Text('Number: $pokemonNumber',
                        style: const TextStyle(fontSize: 20)),
                  if (pokemonTyp != null)
                    Text(
                      '''Typ: $pokemonTyp 
${pokemonTyp2 != null ? 'Typ2: $pokemonTyp2' : ''}''',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 40),
              const PokeballImage(),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: randomPokemon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 47, 67),
                ),
                child: const Text(
                  'Get New Pokemon',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              const PokeballImage(),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}
