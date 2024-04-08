import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/ui/widget/empty_image_widget.dart';
import 'package:compare_two_images/ui/widget/image_file_with_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Compare widget.
class CompareWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = context.watch<ImageComparison>();
    final image1 = images.firstFileImage;
    final image2 = images.secondFileImage;
    final size = MediaQuery.of(context).size;
    Color color = Constant.greyColor;

    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          width: size.width / 2,
          height: size.height / 19,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Is equal: ${images.isImageDifferent}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      if (image1 != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: ImageFileWithBorder(screenSize: size, image1: image1),
        )
      else
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: EmptyImageWidget(screenSize: size),
        ),
      if (image2 != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: ImageFileWithBorder(screenSize: size, image1: image2),
        )
      else
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: EmptyImageWidget(screenSize: size),
        ),
      ElevatedButton(
        onPressed: () async => images.setFirstImageFromGallery(),
        child: const Text('Select first Image'),
      ),
      ElevatedButton(
        onPressed: () async => images.setSecondImageFromGallery(),
        child: const Text('Select second Image'),
      ),
      ElevatedButton(
        onPressed: () async {
          await images.compareImages();
          color = images.isImageDifferent == false
              ? Constant.redColor
              : Constant.greenColor;
        },
        child: const Text('Compare images'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Comparison'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
