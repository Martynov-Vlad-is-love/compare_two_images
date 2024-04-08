import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/ui/screen/pick_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageComparison()),
      ],
      child: const PickImageScreen(),
    ),
  );
}
