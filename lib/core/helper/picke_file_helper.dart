import 'dart:io';

import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:image_picker/image_picker.dart';

class PickeFileHelper {
  PickeFileHelper();
  Future<File?> pickFile(String type, String source) async {
    final ImagePicker picker = ImagePicker();
    if (type == AppStrings.image) {
      final file = await picker.pickImage(
          source: source == AppStrings.camera
              ? ImageSource.camera
              : ImageSource.gallery);
      return file?.path != null ? File(file!.path) : null;
    } else if (type == AppStrings.video) {
      final file = await picker.pickVideo(
          source: source == AppStrings.camera
              ? ImageSource.camera
              : ImageSource.gallery);
      return file?.path != null ? File(file!.path) : null;
    }
    return null;
  }
}
