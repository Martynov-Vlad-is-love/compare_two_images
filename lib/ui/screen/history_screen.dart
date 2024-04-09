import 'dart:io';

import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/controller/history_storage_controller.dart';
import 'package:compare_two_images/ui/widget/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// History screen.
class HistoryScreen extends StatefulWidget {
  /// Constructor.
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryStorageController historyStorageController =
      context.read<HistoryStorageController>();

  @override
  void initState() {
    super.initState();
    initHistory();
  }

  Future<void> initHistory() async {
    await historyStorageController.getImageComparisonHistoryFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const contentText = 'Do you really want to delete this comparison?';
    final historyList = historyStorageController.historyList;
    final itemCount = historyList.length;
    context.watch<HistoryStorageController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.blueGreyColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Image Comparison History'),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (__, index) {
                final historyItem = historyList[index];
                final firstImage =
                    File(historyItem[Constant.firstImageKey] as String);
                final secondImage =
                    File(historyItem[Constant.secondImageKey] as String);
                final isEqual = historyItem[Constant.isEqualKey] as bool;
                final Color colorOfComparison =
                    isEqual ? Colors.green : Colors.red;
                final comparisonResult = isEqual ? 'Equal' : 'Not equal';

                return SizedBox(
                  width: size.width / 2,
                  child: Card(
                    key: ValueKey(historyItem),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Constant.blueGreyColor,
                                width: 4,
                              ),
                            ),
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.file(firstImage),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Image.file(secondImage),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Container(
                                    height: size.height,
                                    width: size.width,
                                    color: colorOfComparison,
                                    child: Center(
                                      child: Text(
                                        comparisonResult,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                            height: 40,
                            width: size.width,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final dialogResult = await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return ConfirmDialog(
                                        contentText: contentText,
                                        context: context,
                                      );
                                    },
                                  );
                                  if (dialogResult == 'OK') {
                                    await historyStorageController
                                        .deleteImageComparisonFromStorage(
                                      index,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
