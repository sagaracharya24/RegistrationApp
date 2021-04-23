import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String textHeading;
  final String text;

  const CustomText({Key key, this.text, this.textHeading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$textHeading :",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
