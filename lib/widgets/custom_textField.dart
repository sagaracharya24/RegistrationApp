import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  @required
  final String hintText;
  @required
  final String textFieldHeading;
  @required
  final Function onSubmitted;
  @required
  final IconData icon;
  final String errorText;
  final TextInputType textInputType;
  final int maxLength;
  @required
  final bool isPasswordField;
  @required
  final bool isVisible;
  final Function onSuffixIconPressed;

  CustomTextField({
    this.focusNode,
    this.controller,
    this.hintText,
    this.textFieldHeading,
    this.onSubmitted,
    this.icon,
    this.errorText,
    this.textInputType,
    this.maxLength,
    this.isPasswordField,
    this.isVisible,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (textFieldHeading != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                textFieldHeading,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          TextField(
            focusNode: focusNode,
            controller: controller,
            maxLength: maxLength ?? null,
            autofocus: false,
            keyboardType: textInputType ?? TextInputType.text,
            onChanged: onSubmitted,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            obscureText: isVisible ?? false,
            decoration: InputDecoration(
              prefixIcon: icon == null
                  ? null
                  : Icon(
                      icon,
                      color: Colors.indigo[800],
                    ),
              suffixIcon: isPasswordField == null
                  ? null
                  : isPasswordField == false
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 30,
                          ),
                        )
                      : IconButton(
                          onPressed: onSuffixIconPressed,
                          icon: Icon(
                            !isVisible ?? false
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.indigo[800],
                          ),
                        ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                errorText ?? '',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            )
        ],
      ),
    );
  }
}
