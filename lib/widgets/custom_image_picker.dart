import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission/permission.dart';

Future<PickedFile> mImagePickerOptions(BuildContext context) async {
  final completer = Completer<PickedFile>();
  final picker = ImagePicker();
  showModalBottomSheet(
    context: context,
    builder: (c) {
      return Container(
        color: Colors.grey,
        child: Row(
          children: <Widget>[
            _uploadOptionButton(
              title: 'From Camera',
              svgName: 'camera.svg',
              height: 50,
              textGap: 3,
              margin: EdgeInsets.only(right: 0.3),
              onTap: () async {
                Navigator.of(c).pop();
                try {
                  final image =
                      await picker.getImage(source: ImageSource.camera);
                  if (image != null) completer.complete(image);
                } on PlatformException catch (e) {
                  Navigator.of(c).pop();
                  if (e?.toString()?.contains('camera_access_denied') == true) {
                    await showDialogPermissionDenied(context,
                        'Camera permission denied. Please open settings and allow camera access.');
                  } else {
                    showSimpleDialog(context, e?.toString());
                  }
                }
              },
            ),
            _uploadOptionButton(
              title: 'From Storage',
              svgName: 'gallery.svg',
              height: 53,
              textGap: 0,
              margin: EdgeInsets.only(left: 0.3),
              onTap: () async {
                Navigator.of(c).pop();
                if (Platform.isAndroid) {
                  final allowed = await storagePermission(context);
                  if (!allowed) return null;
                }
                final image =
                    await picker.getImage(source: ImageSource.gallery);
                if (image != null) completer.complete(image);
              },
            ),
          ],
        ),
      );
    },
  );
  return completer.future;
}

Widget _uploadOptionButton({
  EdgeInsets margin,
  String title,
  String svgName,
  double height,
  double textGap,
  void Function() onTap,
}) {
  return Expanded(
    child: Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
          margin: margin,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'Assets/$svgName',
                height: height,
                color: Colors.indigo[800],
              ),
              SizedBox(height: textGap),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool> showDialogPermissionDenied(BuildContext context, String message) {
  final c = Completer<bool>();
  showDialogYesNo(
    context,
    message,
    yesText: "OPEN SETTINGS",
    yes: () {
      Permission.openSettings();
      c.complete(true);
    },
    noText: "CLOSE",
    no: () {
      c.complete(true);
    },
  );
  return c.future;
}

enum YesNo { yes, no }

Future<YesNo> showDialogYesNo(
  BuildContext context,
  String message, {
  String yesText,
  VoidCallback yes,
  String noText,
  VoidCallback no,
}) async {
  Completer<YesNo> c = Completer();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: Text(message), actions: <Widget>[
        TextButton(
          child: Text(yesText ?? "Yes"),
          onPressed: () {
            Navigator.of(context).pop();
            yes?.call();
            c.complete(YesNo.yes);
          },
        ),
        TextButton(
          child: Text(noText ?? "No"),
          onPressed: () {
            Navigator.of(context).pop();
            no?.call();
            c.complete(YesNo.no);
          },
        ),
      ]);
    },
  );
  return c.future;
}

showSimpleDialog(BuildContext context, String message,
    {VoidCallback callback}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: Text(message), actions: <Widget>[
        TextButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
            callback?.call();
          },
        ),
      ]);
    },
  );
}

Future<bool> storagePermission(BuildContext context) async {
  final permission = PermissionName.Storage;
  var statusList = await Permission.getPermissionsStatus([permission]);
  var status = statusList[0].permissionStatus;
  if (status == PermissionStatus.deny || status == PermissionStatus.notAgain) {
    if (Platform.isAndroid) {
      statusList = await Permission.requestPermissions([permission]);
      status = statusList[0].permissionStatus;
      if (status == PermissionStatus.allow ||
          status == PermissionStatus.always ||
          status == PermissionStatus.whenInUse) {
        return true;
      }
    }
    await showDialogPermissionDenied(
      context,
      'Storage permission denied before. Please open app settings and allow storage access.',
    );
    return false;
  } else {
    statusList = await Permission.requestPermissions([permission]);
    status = statusList[0].permissionStatus;
    if (status == PermissionStatus.allow ||
        status == PermissionStatus.always ||
        status == PermissionStatus.whenInUse) {
      return true;
    } else {
      return false;
    }
  }
}
