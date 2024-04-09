import 'package:flutter/material.dart';

/// Confirm dialog widget.
class ComparisonResultDialog extends StatelessWidget {
  /// Text that displace in this dialog.
  final bool isEqual;

  /// Build context.
  final BuildContext context;

  /// Constructor.
  const ComparisonResultDialog({
    required this.context,
    required this.isEqual, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Result'),
      content: Text('Is equal: $isEqual'),
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
