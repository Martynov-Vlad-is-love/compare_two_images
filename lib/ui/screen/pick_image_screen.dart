import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/ui/screen/history_screen.dart';
import 'package:compare_two_images/ui/widget/compare_widget.dart';
import 'package:flutter/material.dart';

/// Image picker screen.
class PickImageScreen extends StatelessWidget {
  /// Constructor.
  const PickImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.blueGreyColor,
          title: const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text('Image Comparison'),
          ),
          leading: Builder(
            builder:(context) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.history),
            ),
          ),
        ),
        body: CompareWidget(),
      ),
    );
  }
}
