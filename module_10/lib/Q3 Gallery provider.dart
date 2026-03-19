import 'dart:io';
import 'package:flutter/foundation.dart';

import 'Q3 Gallery image.dart';
import 'Q3 Storage service.dart';
//import '../models/gallery_image.dart';
//import '../services/storage_service.dart';

enum GalleryStatus { idle, loading, uploading, error }

class GalleryProvider extends ChangeNotifier {
  final StorageService _service = StorageService();

  List<GalleryImage> _images = [];
  GalleryStatus _status = GalleryStatus.idle;
  String? _errorMessage;
  double _uploadProgress = 0.0;

  List<GalleryImage> get images => List.unmodifiable(_images);
  GalleryStatus get status => _status;
  String? get errorMessage => _errorMessage;
  double get uploadProgress => _uploadProgress;

  bool get isLoading => _status == GalleryStatus.loading;
  bool get isUploading => _status == GalleryStatus.uploading;

  Future<void> loadImages() async {
    _setStatus(GalleryStatus.loading);
    try {
      _images = await _service.fetchImages();
      _setStatus(GalleryStatus.idle);
    } catch (e) {
      _errorMessage = 'Failed to load images: $e';
      _setStatus(GalleryStatus.error);
    }
  }

  Future<bool> uploadImage(File file) async {
    _uploadProgress = 0.0;
    _setStatus(GalleryStatus.uploading);
    try {
      final image = await _service.uploadImage(
        file,
        onProgress: (p) {
          _uploadProgress = p;
          notifyListeners();
        },
      );
      _images.insert(0, image);
      _setStatus(GalleryStatus.idle);
      return true;
    } catch (e) {
      _errorMessage = 'Upload failed: $e';
      _setStatus(GalleryStatus.error);
      return false;
    }
  }

  Future<bool> deleteImage(GalleryImage image) async {
    try {
      await _service.deleteImage(image.storagePath);
      _images.removeWhere((i) => i.storagePath == image.storagePath);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Delete failed: $e';
      _setStatus(GalleryStatus.error);
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    if (_status == GalleryStatus.error) _setStatus(GalleryStatus.idle);
  }

  void _setStatus(GalleryStatus status) {
    _status = status;
    notifyListeners();
  }
}
