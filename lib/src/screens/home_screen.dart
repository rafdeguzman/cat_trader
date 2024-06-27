import 'package:cat_trader/src/services/cats_api.dart';
import 'package:cat_trader/src/widgets/CatCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cats;
  late List<dynamic> cards = [];
  var _isLoading = true;

  void _loadCats() async {
    _isLoading = true;
    print('loading...');
    var catBody = await CatsApi.getCats();
    print('got catbody:');
    print(catBody);
    cats = catBody;
    setState(() {
      cards = cats.map((cat) => CatCard(catImageUrl: cat['url'])).toList();
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
