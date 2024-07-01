import 'dart:convert';
import 'dart:math';

import 'package:cat_trader/src/models/cat.dart';
import 'package:cat_trader/src/services/cats_api.dart';
import 'package:cat_trader/src/widgets/CatCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cat_trader/src/services/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cat> cats = [];
  List<dynamic> breeds = [];
  late List<dynamic> cards = [];
  var _isLoading = true;

  void _loadCats() async {
    _isLoading = true;

    String catBreeds = ''; // this is the string to query the api
    int randomIndex = 0;
    String currentRandomBreed;
    do {
      currentRandomBreed = breeds[Random().nextInt(breeds.length)]['id'];
      if (!catBreeds.contains(currentRandomBreed)) {
        catBreeds += '$currentRandomBreed,';
        randomIndex++;
      }
    } while (randomIndex < 20);

    // getCatBreedImages returns some detail, mainly the cat ID is very important
    var catBody = await CatsApi.getCatBreedImages(catBreeds);

    List<Cat> currentCats = [];
    for (var cat in catBody) {
      var image = catBody[catBody.indexOf(cat)]['url'];
      var id = catBody[catBody.indexOf(cat)]['id'];
      var details = await CatsApi.getCatDetails(id);
      var name = DummyData.catNames[Random().nextInt(50)];
      // clean the lifespan from form "x - y" to [x, y]
      var dirtyLifeSpan = details['lifeSpan'];
      List<dynamic> cleanLifeSpan =
          dirtyLifeSpan.split(" - ").map(int.parse).toList();
      var age = 1 +
          Random()
              .nextInt(cleanLifeSpan[1]); // Age from 1 to value at random index

      currentCats.add(
        // make a cat :3
        Cat(
          age: age,
          name: name,
          image: image,
          nameId: details['breedId'],
          breed: details['breed'],
          description: details['description'],
          id: id,
          lifeSpan: cleanLifeSpan,
          origin: details['origin'],
          originId: details['originId'],
        ),
      );
    }

    // cats becomes empty when loading them
    cats = currentCats;

    setState(() {
      cards = cats.map((cat) => CatCard(cat: cat)).toList();
    });
    _isLoading = false;
    SnackBar snackbar = const SnackBar(content: Text('cats reloaded!'));
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  // calls CatsApi json file, that way loading is not done in the screen
  Future<dynamic> _loadBreeds() async {
    breeds = await CatsApi.loadBreeds();
  }

  @override
  void initState() {
    super.initState();

    () async {
      if (breeds.isEmpty || breeds.isEmpty) {
        // Simplified check for an empty list.
        await _loadBreeds(); // Assuming _loadBreeds is an async function.
      }
      _loadCats(); // This will now wait until _loadBreeds is done.
    }();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());

    if (!_isLoading) {
      content = Column(
        children: [
          ElevatedButton(
              onPressed: _loadCats,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                foregroundColor: const Color.fromARGB(255, 253, 58, 115),
              ),
              child: const Text('get cats neow')),
          Flexible(
            child: SizedBox(
              height: 550,
              child: CardSwiper(
                cardsCount: cards.length,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        cards[index],
                onEnd: _loadCats,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: const CircleBorder(),
                    iconColor: const Color.fromARGB(255, 253, 58, 115),
                    minimumSize: const Size(75, 75)),
                child: const Icon(Icons.close),
              ),
              const SizedBox(
                width: 72,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: const CircleBorder(),
                    iconColor: const Color.fromARGB(255, 253, 58, 115),
                    minimumSize: const Size(75, 75)),
                child: const Icon(Icons.favorite_border),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catder 😻',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 40,
            )),
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Set the height of the border
          child: Container(
            color: Colors.grey.shade300, // Set the color of the border
            height: 1.0, // Set the thickness of the border
          ),
        ),
      ),
      body: content,
    );
  }
}
