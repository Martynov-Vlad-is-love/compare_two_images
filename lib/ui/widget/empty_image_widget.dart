import 'package:compare_two_images/constant.dart';
import 'package:flutter/widgets.dart';

/// Widget that displays the absence of image.
class EmptyImageWidget extends StatelessWidget {
  /// Constructor.
  const EmptyImageWidget({
    required this.screenSize,
    super.key,
  });

  /// Screen size
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width / 2,
      height: screenSize.height / 4,
      decoration: BoxDecoration(
        border: Border.all(color: Constant.greyColor, width: 3),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: const Center(
        child: Text(
          textAlign: TextAlign.center,
          'No image',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
