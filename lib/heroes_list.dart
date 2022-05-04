import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'app_widget.dart';
import 'package:flutter/material.dart';
import 'models/character_model.dart';
import 'package:http/http.dart' as http;

class HeroesList extends StatefulWidget {
  const HeroesList({
    Key? key,
  }) : super(key: key);

  @override
  State<HeroesList> createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  bool isLoading = false;
  bool isError = false;

  List<CharacterModel> listCharacters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();

                /*FirebaseAuth.instance.sendPasswordResetEmail(
                    email: 'giovane.goularte@gmail.com');*/

                Navigator.popAndPushNamed(context, '/login');
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text("Marvel Heroes"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : listCharacters.isEmpty
                ? const Text('vazio')
                : isError
                    ? _stateError()
                    : _loadCharacters(context),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          listCharacters = await getCharacters();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _stateError() {
    return Column(
      children: [
        const Text('Error!'),
        ElevatedButton(
            onPressed: () async {
              await getCharacters();
            },
            child: const Text('Try again!'))
      ],
    );
  }

  Widget _loadCharacters(context) {
    return ListView.builder(
      itemCount: listCharacters.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                Text(
                  listCharacters[index].name,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  listCharacters[index].description,
                  style: const TextStyle(fontSize: 12),
                ),
                Image.network(
                    '${listCharacters[index].thumbnail.path}.${listCharacters[index].thumbnail.extension}',
                    fit: BoxFit.fill),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
          ),
        );
      },
    );
  }

  Future<List<CharacterModel>> getCharacters() async {
    var url = Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?apikey=bbc8698be2f66bacea8539c4228f27e7&hash=9033d3960f625a607ed18eeb6d276617&ts=1&limit=50');

    setState(() {
      isLoading = true;
    });
    var response = await http.get(url);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        isError = false;
      });
      final result = json.decode(response.body);

      final characters = List.from(result['data']['results'])
          .map((data) => CharacterModel.fromJson(data))
          .toList();

      listCharacters = characters;

      return characters;
    } else {
      setState(() {
        isError = true;
      });
      throw Exception();
    }
  }
}
