import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> hasPermissions(Permission permission) async {
  try {
    final status = await permission.request();
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
      return false;
    }
    return true;
  } catch (e) {
    log("Error: $e");
    return false;
  }
}

Future<XFile?> filePicker() async {
  if (!await hasPermissions(Permission.camera)) return null;
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.camera,
    maxHeight: 1366,
    maxWidth: 1024,
  );
  return pickedFile;
}

Future<XFile?> filePickerGalery() async {
  if (!await hasPermissions(Permission.storage)) return null;
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 1366,
    maxWidth: 1024,
  );
  return pickedFile;
}
