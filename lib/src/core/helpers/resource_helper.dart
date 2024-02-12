import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ResourceHelper {
  static Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom,allowedExtensions: ["pdf", "doc"]);
      if (result == null) {
        return null;
      }
      return File(result.files.single.path!);
    } catch (ex) {
      return null;
    }
  }

  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (ex) {
      return null;
    }
  }
}
