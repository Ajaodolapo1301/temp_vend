import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class GetImageUtils {
  static Future<File?> pickedMedia(
      {required Future<File> Function(File file) cropImage}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      File file = File(pickedFile.path);
      return cropImage(file);
    }
  }
}

Future<File?> getFile({File? file}) async {
  // appState.selectingFile = true;
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    File file = File(imageFile.path);
    int sizeInBytes = file.lengthSync();
    if (sizeInBytes < 5000000) {
      return file;
    } else {
      toast("Files too large, maximum is 5mb");
    }
  } else {
    return null;
  }
}
