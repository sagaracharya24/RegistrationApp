import 'dart:io';

class ValidationItem {
  final String value;
  final String error;
  ValidationItem(this.value, this.error);
}

class ImageItem {
  final File file;
  final String error;
  ImageItem(this.file, this.error);
}
