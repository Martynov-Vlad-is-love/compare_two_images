import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/ui/screen/pick_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageComparison()),
      ],
      child: const PickImageScreen(),
    ),
  );
}
