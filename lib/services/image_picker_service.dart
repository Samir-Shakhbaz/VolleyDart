// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ImagePickerService {
//   final ImagePicker _picker = ImagePicker();
//
//   // Request permissions
//   Future<bool> _requestPermissions() async {
//     final cameraPermission = await Permission.camera.request();
//     final storagePermission = await Permission.storage.request();
//
//     return cameraPermission.isGranted && storagePermission.isGranted;
//   }
//
//   // Pick an image from the gallery
//   Future<File?> pickImageFromGallery() async {
//     if (await _requestPermissions()) {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       return pickedFile != null ? File(pickedFile.path) : null;
//     } else {
//       return null; // Handle permission denied case
//     }
//   }
//
//   // Pick an image from the camera
//   Future<File?> pickImageFromCamera() async {
//     if (await _requestPermissions()) {
//       final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//       return pickedFile != null ? File(pickedFile.path) : null;
//     } else {
//       return null; // Handle permission denied case
//     }
//   }
// }
