import 'package:flutter/material.dart';

class CustomPickerFiled extends StatelessWidget {
  final String headingMessage;
  final Function() onTap;
  final String value;
  final double height;

  const CustomPickerFiled(
      {Key key, this.headingMessage, this.onTap, this.value, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headingMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(headingMessage),
            ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: height ?? 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[800])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value == null ? "Select Your Qualification" : value,
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
