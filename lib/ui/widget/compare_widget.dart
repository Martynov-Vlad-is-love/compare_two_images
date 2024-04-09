import 'package:compare_two_images/algorithm/file_extension_checker.dart';
import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/controller/history_storage_controller.dart';
import 'package:compare_two_images/ui/widget/comparison_result_dialog.dart';
import 'package:compare_two_images/ui/widget/custom_text_widget.dart';
import 'package:compare_two_images/ui/widget/different_extensions_alert_dialog.dart';
import 'package:compare_two_images/ui/widget/empty_image_widget.dart';
import 'package:compare_two_images/ui/widget/image_file_with_border.dart';
import 'package:compare_two_images/ui/widget/image_missing_alert_dialog.dart';
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
    final historyStorage = context.watch<HistoryStorageController>();

    final firstImageWidget = image1 != null
        ? ImageFileWithBorder(screenSize: size, image: image1)
        : EmptyImageWidget(screenSize: size);
    final secondImageWidget = image2 != null
        ? ImageFileWithBorder(screenSize: size, image: image2)
        : EmptyImageWidget(screenSize: size);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25, top: 25),
              child: CustomTextWidget(
                screenSize: size,
                backgroundColor: Constant.blueGreyColor,
                isImageEqual: images.isImageEqual,
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
                final fileChecker = FileExtensionChecker();
                final firstImagePath = image1?.path;
                final secondImagePath = image2?.path;

                if (firstImagePath != null && secondImagePath != null) {
                  if (fileChecker.compareFileExtensionsByImagePath(
                    firstImagePath,
                    firstImagePath,
                  )) {
                    await images.compareImages();
                    final isImagesEqual = images.isImageEqual;
                    await historyStorage.addImageComparisonToHistoryStorage(
                      images,
                      isImagesEqual: isImagesEqual,
                    );
                    if (!context.mounted) {
                      return;
                    }
                    await showDialog(
                      builder: (_) {
                        return ComparisonResultDialog(
                          context: context,
                          isEqual: isImagesEqual,
                        );
                      },
                      context: context,
                    );
                  } else {
                    await showDialog(
                      context: context,
                      builder: (_) {
                        return const DifferentExtensionsAlertDialog();
                      },
                    );
                  }
                } else {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return const ImageMissingAlertDialog();
                    },
                  );
                }
              },
              child: const Text('Compare images'),
            ),
          ],
        ),
      ),
    );
  }
}
