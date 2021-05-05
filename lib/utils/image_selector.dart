import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  static Future<File> takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (imageFile != null) {
      final image = File(imageFile.path);
      return image;
    }
    return null;
  }
}
