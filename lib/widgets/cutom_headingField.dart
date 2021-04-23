import 'package:flutter/material.dart';

class CustomHeadingField extends StatelessWidget {
  final String heading;

  const CustomHeadingField({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 2,
              color: Colors.grey[800],
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ]);
  }
}
