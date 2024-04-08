import 'dart:io';

import 'package:compare_two_images/constant.dart';
import 'package:flutter/widgets.dart';

/// Widget that displace given Image with border.
class ImageFileWithBorder extends StatelessWidget {
  /// Constructor.
  const ImageFileWithBorder({
    required this.screenSize,
    required this.image1,
    super.key,
  });

  /// Screen size.
  final Size screenSize;

  /// Given image
  final File image1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constant.greyColor, width: 4),
      ),
      width: screenSize.width * 2 / 3,
      height: Image.file(image1).height,
      child: Image.file(
        image1,
      ),
    );
  }
}
