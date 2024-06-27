import 'dart:math';

import 'package:cat_trader/src/models/cat.dart';
import 'package:cat_trader/src/services/cats_api.dart';
import 'package:cat_trader/src/widgets/CatCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:cat_trader/src/services/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cat> cats = [];
  late List<dynamic> cards = [];
  var _isLoading = true;

  void _loadCats() async {
    _isLoading = true;
    print('loading...');
    var catBody = await CatsApi.getCats();
    print('got catbody:');
    print(catBody);
    List<Cat> currentCats = [];
    for (var cat in catBody) {
      currentCats.add(
        // make a cat :3
        Cat(
          name: DummyData.catNames[Random().nextInt(50)],
          age: Random().nextInt(20) + 1,
          image: catBody[catBody.indexOf(cat)]['url'],
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
  }

  @override
  void initState() {
    _loadCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CircularProgressIndicator();

    if (!_isLoading) {
      content = Column(
        children: [
          ElevatedButton(onPressed: _loadCats, child: Text('get cats naow')),
          Flexible(
            child: CardSwiper(
              cardsCount: cards.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) =>
                      cards[index],
              onEnd: _loadCats,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: content,
    );
  }
}
