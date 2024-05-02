import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadToStorageHelper {
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadFile(
      {required String path, required File file, required String uuid}) async {
    Reference ref = storage.ref().child('$path/$uuid');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}
