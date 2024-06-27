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
    print('loading...');

    // var catBody = await CatsApi.getCats();

    // get random catBreeds
    String catBreeds = '';
    // 20 unique breeds
    List<String> savedBreeds = [];
    int randomIndex = 0;
    do {
      var currentRandomBreed = breeds[Random().nextInt(breeds.length)]['id'];
      if (!savedBreeds.contains(currentRandomBreed)) {
        savedBreeds.add(currentRandomBreed);
        catBreeds += currentRandomBreed + ',';
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
      // use lifespan to have a determination as to how old
      var age = Random().nextInt(20) + 1;
      var name = DummyData.catNames[Random().nextInt(50)];
      // clean the lifespan from form "x - y" to [x, y]
      var dirtyLifeSpan = details['lifeSpan'];
      List<dynamic> cleanLifeSpan =
          dirtyLifeSpan.split(" - ").map(int.parse).toList();

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
    print('done!');

    SnackBar snackbar = SnackBar(content: const Text('cats reloaded!'));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<dynamic> _loadBreeds() async {
    _isLoading = true;
    print('loading breeds (should only happen once)');
    final String breedsJson = await rootBundle.loadString('assets/breeds.json');
    setState(() {
      breeds = jsonDecode(breedsJson);
      _isLoading = false;
    });
    print('done!');
    print(breeds.length);
  }

  @override
  void initState() {
    super
        .initState(); // It's a good practice to call super.initState() at the beginning.
    print(
        'is breeds empty? ${breeds.length <= 0 || breeds.isEmpty}'); // Use isEmpty for clarity.

    // Using an immediately invoked async function to await _loadBreeds.
    () async {
      if (breeds.isEmpty || breeds.length <= 0) {
        // Simplified check for an empty list.
        await _loadBreeds(); // Assuming _loadBreeds is an async function.
      }
      _loadCats(); // This will now wait until _loadBreeds is done.
    }();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: const CircularProgressIndicator());

    if (!_isLoading) {
      content = Column(
        children: [
          ElevatedButton(
              onPressed: _loadCats, child: const Text('get cats neow')),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Icon(Icons.favorite_border)),
              ElevatedButton(onPressed: () {}, child: const Text('🤞'))
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catder',
          style: TextStyle(color: Colors.black),
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
