import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Compare widget
class CompareWidget extends StatefulWidget {
  @override
  _CompareWidgetState createState() => _CompareWidgetState();
}

class _CompareWidgetState extends State<CompareWidget> {
  @override
  Widget build(BuildContext context) {
    final images = context.watch<ImageComparison>();
    final image1 = images.firstImage;
    final image2 = images.secondImage;

    final ImageComparison imageComparison = ImageComparison();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Comparison'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image1 != null)
              Image.file(image1)
            else
              const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 100,
              ),
            if (image2 != null)
              Image.file(image2)
            else
              const Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 100,
              ),
            ElevatedButton(
              onPressed: () async => imageComparison.getFirstImageFromGallery(),
              child: const Text('Select First Image'),
            ),
            ElevatedButton(
              onPressed: () async =>
                  imageComparison.getSecondImageFromGallery(),
              child: const Text('Select Second Image'),
            ),
          ],
        ),
      ),
    );
  }
}
