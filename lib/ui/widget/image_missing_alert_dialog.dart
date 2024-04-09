import 'package:flutter/material.dart';

/// Image missing alert dialog.
class ImageMissingAlertDialog extends StatelessWidget {
  /// Constructor.
  const ImageMissingAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Oops'),
      content: const Text('One or two of images missing'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}