import 'package:flutter/material.dart';

/// Confirm dialog widget.
class ConfirmDialog extends StatelessWidget {
  /// Text that displace in this dialog.
  final String contentText;

  /// Build context.
  final BuildContext context;

  /// Constructor.
  const ConfirmDialog({
    required this.contentText,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
