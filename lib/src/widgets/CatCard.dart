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
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 32.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cat.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 350,
              ),
            ),
            Row(
              children: [
                Text(
                  cat.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ', ${cat.age}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 64.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.access_alarm)),
                const SizedBox(
                  width: 48.0,
                ),
                ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.monitor_heart))
              ],
            )
          ],
        ),
      ),
    );
  }
}
