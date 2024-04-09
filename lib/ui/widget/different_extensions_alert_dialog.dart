import 'package:flutter/material.dart';

/// Different extensions alert dialog.
class DifferentExtensionsAlertDialog extends StatelessWidget {
  /// Constructor.
  const DifferentExtensionsAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Oops'),
      content: const Text('Image extensions are different.'),
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
