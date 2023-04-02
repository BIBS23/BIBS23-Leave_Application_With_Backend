import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessStorage extends ChangeNotifier {
  File? _image;
  Future<void> getAccess(context) async {
    final access = await [Permission.camera, Permission.storage].request();
    final cameraStatus = access[Permission.camera];
    final storageStatus = access[Permission.storage];
    if (storageStatus != PermissionStatus.granted ||
        cameraStatus != PermissionStatus.granted) {
      throw const SnackBar(content: Text('error'));
    }
    notifyListeners();
  }

  void chooseFromStorage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
}
