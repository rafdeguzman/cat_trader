import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  const CatCard({
    super.key,
    required this.catImageUrl,
  });
  final String catImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.network(catImageUrl),
    );
  }
}
