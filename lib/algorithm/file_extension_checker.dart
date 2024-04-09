/// This class can check file extension.
class FileExtensionChecker {
  final _imageExtensions = [
    'avif',
    'gif',
    'jpg',
    'jpeg',
    'jfif',
    'pjpeg',
    'pjp',
    'png',
    'svg',
    'webp',
  ];

  String _getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  /// Checks file extension to detect non-images.
  bool isImageFileByPath(String filePath) {
    final extension = _getFileExtension(filePath);

    return _imageExtensions.contains(extension);
  }

  /// This method compares two file extensions by path.
  bool compareFileExtensionsByImagePath(
    String firstFilePath,
    String secondFilePath,
  ) {
    return _getFileExtension(firstFilePath) ==
        _getFileExtension(secondFilePath);
  }
}
