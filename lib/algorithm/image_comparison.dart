import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Image comparison class
class ImageComparison extends ChangeNotifier {
  File? _firstFileImage;
  File? _secondFileImage;

  /// Difference of images in bool value
  bool isImageDifferent = false;

  /// Get first image file
  File? get firstFileImage => _firstFileImage;

  /// Get second image file
  File? get secondFileImage => _secondFileImage;

  /// Method to set image from gallery.
  Future<void> setFirstImageFromGallery() async {
    _firstFileImage = await _getImageFromGallery();
    notifyListeners();
  }

  /// Method to set image from gallery.
  Future<void> setSecondImageFromGallery() async {
    _secondFileImage = await _getImageFromGallery();
    notifyListeners();
  }

  /// Method to take image from gallery.
  Future<File?> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }

    return null;
  }

  /// Method to compare two images.
  Future<void> compareImages() async {
    final Uint8List? bytes1 = await firstFileImage?.readAsBytes();
    final Uint8List? bytes2 = await secondFileImage?.readAsBytes();
    isImageDifferent = await _compareImagesBytes(bytes1, bytes2);

    notifyListeners();
  }

  Future<bool> _compareImagesBytes(
    Uint8List? image1Bytes,
    Uint8List? image2Bytes,
  ) async {
    bool isEqual = true;
    if (image1Bytes != null && image2Bytes != null) {
      int pixelLengthInBytes = 0;
      final firstPixelLengthInBytes = image1Bytes.length;
      final secondPixelLengthInBytes = image2Bytes.length;

      pixelLengthInBytes = firstPixelLengthInBytes < secondPixelLengthInBytes
          ? firstPixelLengthInBytes
          : secondPixelLengthInBytes;

      for (int i = 0; i < pixelLengthInBytes; i++) {
        if (image1Bytes[i] != image2Bytes[i]) {
          isEqual = false;
        }
      }
    }

    return isEqual;
  }
}
