import 'dart:io';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @required
  final String title;
  final Function onPressed;

  CustomAppBar({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(
          width: 50,
        ),
      ],
    );
  }
}
