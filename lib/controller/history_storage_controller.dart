import 'package:compare_two_images/algorithm/image_comparison.dart';
import 'package:compare_two_images/constant.dart';
import 'package:compare_two_images/storage/history_storage.dart';
import 'package:flutter/cupertino.dart';

/// Controller for [HistoryStorage].
class HistoryStorageController extends ChangeNotifier {
  final _historyStorage = HistoryStorage();
  List<Map<dynamic, dynamic>> _historyList = [];

  /// History comparison list.
  List<Map<dynamic, dynamic>> get historyList => _historyList;

  /// Controller to add comparison results to storage.
  Future<void> addImageComparisonToHistoryStorage(
    ImageComparison images, {
    required bool isImagesEqual,
  }) async {
    final Map<String, dynamic> comparisonResult = {
      Constant.firstImageKey: images.firstFileImage?.path,
      Constant.secondImageKey: images.secondFileImage?.path,
      Constant.isEqualKey: isImagesEqual,
    };
    await _historyStorage.addImageComparisonToHistoryStorage(comparisonResult);
    notifyListeners();
  }

  /// Controller to get comparison history from storage.
  Future<void> getImageComparisonHistoryFromStorage() async {
    final imageComparisonHistory =
        await _historyStorage.getImageComparisonHistoryFromStorage();
    final List<Map<dynamic, dynamic>> historyListOfComparison = [];
    for (final element in imageComparisonHistory) {
      historyListOfComparison.add(element as Map<dynamic, dynamic>);
    }
    _historyList = historyListOfComparison;
    notifyListeners();
  }

  /// Controller to delete comparison results from storage.
  Future<void> deleteImageComparisonFromStorage(
    int indexOfComparisonBox,
  ) async {
    await _historyStorage
        .deleteImageComparisonFromStorage(indexOfComparisonBox);
    await getImageComparisonHistoryFromStorage();
  }
}
