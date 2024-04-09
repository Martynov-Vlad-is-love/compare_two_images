import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/controller/history_storage_controller.dart';
import 'package:compare_two_images/ui/widget/comparison_result_dialog.dart';
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
    final historyStorage = context.watch<HistoryStorageController>();

    final firstImageWidget = image1 != null
        ? ImageFileWithBorder(screenSize: size, image: image1)
        : EmptyImageWidget(screenSize: size);
    final secondImageWidget = image2 != null
        ? ImageFileWithBorder(screenSize: size, image: image2)
        : EmptyImageWidget(screenSize: size);

    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 25, top: 25),
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
              'Is equal: ${images.isImageEqual}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: firstImageWidget,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: secondImageWidget,
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
          final isImagesEqual = images.isImageEqual;

          color =
              isImagesEqual == false ? Constant.redColor : Constant.greenColor;

          await historyStorage.addImageComparisonToHistoryStorage(
            images,
            isImagesEqual: isImagesEqual,
          );

          await showDialog(
            builder: (_) {
              return ComparisonResultDialog(
                context: context,
                isEqual: isImagesEqual,
              );
            },
            context: context,
          );
        },
        child: const Text('Compare images'),
      ),
    ];

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
