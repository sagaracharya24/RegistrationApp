import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

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
