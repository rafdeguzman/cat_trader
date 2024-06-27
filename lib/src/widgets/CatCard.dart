import 'package:flutter/material.dart';

import '../models/cat.dart';

class CatCard extends StatefulWidget {
  const CatCard({
    super.key,
    required this.cat,
  });
  final Cat cat;

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  String countryCodeToFlagEmoji(String countryCode) {
    // Ensure the country code is uppercase
    countryCode = countryCode.toUpperCase();
    // Initialize an empty string to store the flag emoji
    String flagEmoji = '';
    // Loop through each character in the country code
    for (int i = 0; i < countryCode.length; i++) {
      // Convert the character to its corresponding regional indicator symbol letter
      int flagLetter = countryCode.codeUnitAt(i) + 127397;
      // Append the symbol letter to the flag emoji string
      flagEmoji += String.fromCharCode(flagLetter);
    }
    return flagEmoji;
  }

  void _showDetails(Cat cat) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).colorScheme.surface),
            height: 250,
            width: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Row(
                      children: [
                        Text(
                          '${cat.origin}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${countryCodeToFlagEmoji(cat.originId)}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      cat.description,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.cat.image,
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
                  '${widget.cat.name}, ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.cat.age}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Text(
                  widget.cat.breed,
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(128)),
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
              ElevatedButton(
                  onPressed: () {
                    _showDetails(widget.cat);
                  },
                  child: const Icon(Icons.article))
            ],
          )
        ],
      ),
    );
  }
}
