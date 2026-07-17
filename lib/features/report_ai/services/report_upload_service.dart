import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ReportUploadService {
  final ImagePicker _picker = ImagePicker();

  /// Pick image from Gallery
  Future<File?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Capture using Camera
  Future<File?> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (image == null) return null;

    return File(image.path);
  }

  /// Pick PDF report
  Future<File?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final path = result.files.single.path;

    if (path == null) {
      return null;
    }

    return File(path);
  }

  /// Pick multiple report images
  Future<List<File>> pickMultipleImages() async {
    final List<XFile> images =
        await _picker.pickMultiImage(
      imageQuality: 90,
    );

    return images.map((e) => File(e.path)).toList();
  }
}