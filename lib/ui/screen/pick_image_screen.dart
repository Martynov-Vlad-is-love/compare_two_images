import 'package:compare_two_images/ui/widget/compare_widget.dart';
import 'package:flutter/material.dart';

/// Image picker screen
class PickImageScreen extends StatelessWidget {
  /// Constructor
  const PickImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CompareWidget());
  }
}
