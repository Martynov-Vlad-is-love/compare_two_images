import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:compare_two_images/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Image comparison class
class ImageComparison extends ChangeNotifier {
  /// First image
  File? firstImage;
  /// SecondImage
  File? secondImage;

  //ignore: unused_field
  double _differencePercentage = 0.0;

  /// Method to take image from gallery
  Future<void> getFirstImageFromGallery() async {
    firstImage = await _getImageFromGallery();
    notifyListeners();
  }

  /// Method to take image from gallery
  Future<void> getSecondImageFromGallery() async {
    secondImage = await _getImageFromGallery();
    notifyListeners();
  }

  /// Method to take image from gallery
  Future<File?> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }

    return null;
  }

  /// Method to compare two images
  Future<void> compareImages() async {
    if (firstImage != null && secondImage != null) {
      final Uint8List? bytes1 = await firstImage?.readAsBytes();
      final Uint8List? bytes2 = await secondImage?.readAsBytes();
      _differencePercentage = await _compareImagesBytes(bytes1, bytes2);
    }

  }

  Future<double> _compareImagesBytes(
    Uint8List? image1Bytes,
    Uint8List? image2Bytes,
  ) async {
    double result = 0.0;

    if (image1Bytes != null && image2Bytes != null) {
      final ui.Image image1 = await decodeImageFromList(image1Bytes);
      final ui.Image image2 = await decodeImageFromList(image2Bytes);

      if (image1.width != image2.width || image1.height != image2.height) {
        throw ArgumentError("Images must have the same dimensions");
      }

      int differentPixelsCount = 0;
      final ByteData? byteData1 = await image1.toByteData();
      final ByteData? byteData2 = await image2.toByteData();
      final Uint8List? pixels1 = byteData1?.buffer.asUint8List();
      final Uint8List? pixels2 = byteData2?.buffer.asUint8List();
      final pixelLengthInBytes = pixels1?.lengthInBytes;

      if (pixelLengthInBytes != null) {
        for (int i = 0; i < pixelLengthInBytes; i++) {
          if (pixels1?[i] != pixels2?[i]) {
            differentPixelsCount++;
          }
        }
      }

      if (pixelLengthInBytes != null) {
        result = differentPixelsCount /
            (pixelLengthInBytes / Constant.COUNT_OF_BYTES_PER_PIXEl) *
            Constant.PERCENT;
      }
    }

    return result;
  }
}
