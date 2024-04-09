import 'dart:io';

import 'package:compare_two_images/constant.dart';
import 'package:flutter/widgets.dart';

/// Widget that displace given Image with border.
class ImageFileWithBorder extends StatelessWidget {
  /// Constructor.
  const ImageFileWithBorder({
    required this.screenSize,
    required this.image,
    super.key,
  });

  /// Screen size.
  final Size screenSize;

  /// Given image
  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constant.blueGreyColor, width: 4),
      ),
      width: screenSize.width * 2 / 3,
      height: Image.file(image).height,
      child: Image.file(
        image,
      ),
    );
  }
}
