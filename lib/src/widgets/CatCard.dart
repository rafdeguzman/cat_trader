import 'package:flutter/material.dart';

import '../models/cat.dart';

class CatCard extends StatelessWidget {
  const CatCard({
    super.key,
    required this.cat,
  });
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cat.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 350,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '${cat.name}, ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${cat.age}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Text(
                  'probably going to be cat breed',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.search)),
              const SizedBox(
                width: 48.0,
              ),
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.article))
            ],
          )
        ],
      ),
    );
  }
}
