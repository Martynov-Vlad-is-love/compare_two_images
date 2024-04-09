import 'package:flutter/widgets.dart';

/// Custom text widget.
class CustomTextWidget extends StatelessWidget {
  /// Constructor.
  const CustomTextWidget({
    required this.screenSize,
    required this.backgroundColor,
    required this.isImageEqual,
    super.key,
  });

  /// Screen size.
  final Size screenSize;

  /// Background color of this widget
  final Color backgroundColor;

  /// Is images equal.
  final bool isImageEqual;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width / 2,
      height: screenSize.height / 19,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          'Is equal: $isImageEqual',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
