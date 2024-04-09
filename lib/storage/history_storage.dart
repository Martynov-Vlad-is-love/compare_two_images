import 'package:hive_flutter/hive_flutter.dart';

/// History comparison storage based on Hive database.
class HistoryStorage {
  /// Method to add comparison results to storage.
  Future<void> addImageComparisonToHistoryStorage(
      Map<String, dynamic> comparisonResult,) async {
    final imagesHistoryBox = await Hive.openBox('imagesHistoryBox');
    await imagesHistoryBox.add(comparisonResult);
    await imagesHistoryBox.close();
  }

  /// Method to get comparison history from storage
  Future<Iterable<dynamic>> getImageComparisonHistoryFromStorage() async {
    final imagesHistoryBox = await Hive.openBox('imagesHistoryBox');

    return imagesHistoryBox.values;

  }

  /// Method to delete comparison results to storage.
  Future<void> deleteImageComparisonFromStorage(
    int indexOfComparisonBox,
  ) async {
    final imagesHistoryBox = await Hive.openBox('imagesHistoryBox');
    await imagesHistoryBox.deleteAt(indexOfComparisonBox);
    await imagesHistoryBox.close();
  }
}
