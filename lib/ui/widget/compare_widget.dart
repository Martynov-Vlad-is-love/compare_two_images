import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:compare_two_images/algorithm/difference_painter.dart';
import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

///Compare widget
class CompareWidget extends StatelessWidget {
  bool compared = false;

  @override
  Widget build(BuildContext context) {
    final images = context.watch<ImageComparison>();
    final image1 = images.firstFileImage;
    final image2 = images.secondFileImage;
    final imageCast = image2?.readAsBytes();
    if(imageCast != null){
      final Future<Image> f = decodeImageFromList(imageCast as Uint8List) as Future<Image>;
    }
    else
      print('ono null');


    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Comparison'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image1 != null)
              SizedBox(
                height: 250,
                width: 250,
                child: Image.file(
                  image1,
                ),
              )
            else
              const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 50,
              ),
            if (compared == true && images.secondImage != null)
              CustomPaint(
                painter: DifferencePainter(images.differences, images.secondImage),
              )
            else if (image2 != null)
              SizedBox(height: 250, width: 250, child: Image.file(image2))
            else
              const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 50,
              ),
            ElevatedButton(
              onPressed: () async => images.setFirstImageFromGallery(),
              child: const Text('Select First Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                await images.setSecondImageFromGallery();
                compared = false;
              },
              child: const Text('Select Second Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                await images.compareImages();

                compared = true;
              },
              child: const Text('Compare'),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Text(
                  textAlign: TextAlign.center,
                  'Is equal: ${images.isImageDifferent}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
