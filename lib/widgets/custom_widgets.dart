import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

showTextField({
  FocusNode focusNode,
  TextEditingController controller,
  @required String hintText,
  @required String textFieldHeading,
  @required Function onSubmitted,
  @required IconData icon,
  String errorText,
  TextInputType textInputType,
  int maxLength,
  bool isPasswordField = false,
  bool isVisible = false,
  Function onSuffixIconPressed,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
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
          obscureText: isVisible,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.indigo[800],
            ),
            suffixIcon: isPasswordField ?? null
                ? IconButton(
                    onPressed: onSuffixIconPressed,
                    icon: Icon(
                      !isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.indigo[800],
                    ),
                  )
                : null,
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

showRadioGroup({
  String value,
  Function onChanged,
}) {
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

void showPicker(
    {String pickerHeading,
    List<String> items,
    Function(PickerController) onConfirm,
    BuildContext context,
    Function() onCancel}) {
  PickerViewPopup.showMode(
    PickerShowMode.BottomSheet,
    controller: PickerController(
      count: 1,
    ),
    context: context,
    title: Text(
      pickerHeading,
      style: TextStyle(fontSize: 14),
    ),
    cancel: Text(
      'Cancel',
      style: TextStyle(color: Colors.grey),
    ),
    onCancel: onCancel,
    confirm: Text(
      'Confirm',
      style: TextStyle(color: Colors.blue),
    ),
    onConfirm: onConfirm,
    builder: (context, popup) {
      return Container(
        height: 150,
        child: popup,
      );
    },
    itemExtent: 40,
    numberofRowsAtSection: (section) {
      return items.length;
    },
    itemBuilder: (section, row) {
      return Text(
        '${items[row]}',
        style: TextStyle(fontSize: 15),
      );
    },
  );
}

customPickerField(
    {String headingMessage,
    Function() onTap,
    String value,
    double height = 40}) {
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
            height: height,
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

customTextField(
    {FocusNode focusNode,
    @required TextEditingController controller,
    String headingMessage,
    String hintMessage,
    String errorText,
    TextInputType textInputType,
    @required Function onSubmitted,
    bool isIconVisible = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            headingMessage,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(right: 10),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[800])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextField(
                focusNode: focusNode,
                controller: controller,
                keyboardType: textInputType ?? TextInputType.text,
                onChanged: onSubmitted,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintMessage,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 14),
                  contentPadding: const EdgeInsets.only(left: 5, bottom: 10),
                ),
              )),
              if (isIconVisible)
                Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                )
            ],
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

Widget customAppBar({@required String title, Function() onPressed}) {
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
