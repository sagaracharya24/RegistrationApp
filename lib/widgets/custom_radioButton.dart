import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final Function onChanged;

  const CustomRadioButton({Key key, this.value, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Radio(
                value: 'male',
                groupValue: value,
                onChanged: onChanged,
                activeColor: Colors.indigo[800],
              ),
              Text(
                "Male",
              ),
              Radio(
                value: 'female',
                groupValue: value,
                onChanged: onChanged,
                activeColor: Colors.indigo[800],
              ),
              Text(
                "Female",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
