import 'dart:io';
import 'dart:ui' as ui;

import 'package:compare_two_images/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pixels/image_pixels.dart';

/// Image comparison class
class ImageComparison extends ChangeNotifier {
  File? _firstFileImage;
  File? _secondFileImage;
  ui.Image? _firstImage;
  ui.Image? _secondImage;
  ImgDetails? firstImageDetails;
  ImgDetails? secondImageDetails;
  List<ui.Offset> differences = [];

  /// Difference of images in bool value
  bool isImageDifferent = false;

  /// Get first image
  ui.Image? get firstImage => _firstImage;

  /// Get first image
  ui.Image? get secondImage => _secondImage;

  /// Get first image file
  File? get firstFileImage => _firstFileImage;

  /// Get second image file
  File? get secondFileImage => _secondFileImage;

  /// Method to set image from gallery
  Future<void> setFirstImageFromGallery() async {
    _firstFileImage = await _getImageFromGallery();
    final img = _firstFileImage?.readAsBytes();
    if (img != null) {
      _firstImage = await decodeImageFromList(img as Uint8List);
    }
    notifyListeners();
  }

  /// Method to set image from gallery
  Future<void> setSecondImageFromGallery() async {
    _secondFileImage = await _getImageFromGallery();
    final img = _firstFileImage?.readAsBytes();
    if (img != null) {
      _secondImage = await decodeImageFromList(img as Uint8List);
    }
    notifyListeners();
  }

  Future<ui.Image?> getImageFromFile(File? file) async {
    if (file != null) {
      return decodeImageFromList(file as Uint8List);
    }

    return null;
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

  Future<void> findDifferences(ImgDetails firstImageDetails, ImgDetails secondImageDetails) async {
    final details = firstImageDetails.uiImage;
    Color firstPixel = Colors.grey;
    Color secondPixel = Colors.grey;
    final int? height = firstImageDetails.height;
    final int? width = firstImageDetails.width;

    if (height != null && width != null) {
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          firstPixel = firstImageDetails.pixelColorAt!(height,width);
          firstPixel = secondImageDetails.pixelColorAt!(height,width);
          if(firstPixel != secondPixel){
            final pixel = ui.Offset(height as double, width as double);
            differences.add(pixel);
          }
        }
      }

      print('Количество отличающихся пикселей: ${differences.length}');
    }
  }

  /// Method to compare two images
  Future<void> compareImages() async {
    double differencePercentage = 0.0;

    final Uint8List? bytes1 = await firstFileImage?.readAsBytes();
    final Uint8List? bytes2 = await secondFileImage?.readAsBytes();
    differencePercentage = await _compareImagesBytes(bytes1, bytes2);

    //ignore: avoid_bool_literals_in_conditional_expressions
    isImageDifferent = differencePercentage == 0.0 ? true : false;

    notifyListeners();
  }

  Future<double> _compareImagesBytes(
    Uint8List? image1Bytes,
    Uint8List? image2Bytes,
  ) async {
    double result = 0.0;

    if (image1Bytes != null && image2Bytes != null) {
      final ui.Image image1 = await decodeImageFromList(image1Bytes);
      final ui.Image image2 = await decodeImageFromList(image2Bytes);

      int pixelLengthInBytes = 0;
      int differentPixelsCount = 0;
      final ByteData? byteData1 = await image1.toByteData();
      final ByteData? byteData2 = await image2.toByteData();
      final Uint8List? pixels1 = byteData1?.buffer.asUint8List();
      final Uint8List? pixels2 = byteData2?.buffer.asUint8List();
      final firstPixelLengthInBytes = pixels1?.length;
      final secondPixelLengthInBytes = pixels2?.length;

      if (firstPixelLengthInBytes != null && secondPixelLengthInBytes != null) {
        pixelLengthInBytes = firstPixelLengthInBytes < secondPixelLengthInBytes
            ? firstPixelLengthInBytes
            : secondPixelLengthInBytes;

        for (int i = 0; i < pixelLengthInBytes; i++) {
          if (pixels1?[i] != pixels2?[i]) {
            differentPixelsCount++;
          }
        }
      }

      result = differentPixelsCount / pixelLengthInBytes * Constant.PERCENT;

      print('$result%');
    }

    return result;
  }
}
