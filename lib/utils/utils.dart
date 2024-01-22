import 'dart:io';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: imageSource);

  if (_file != null) {
    // return File(_file.path);
    return _file.readAsBytes();
  }
  print("No Image Selected");
}
