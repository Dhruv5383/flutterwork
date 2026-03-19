import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
//import '../models/gallery_image.dart';
import 'Q3 Gallery image.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  static const String _galleryFolder = 'gallery';

  /// Upload a file to Firebase Storage and return the [GalleryImage].
  Future<GalleryImage> uploadImage(
      File file, {
        void Function(double progress)? onProgress,
      }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
    final storagePath = '$_galleryFolder/$fileName';
    final ref = _storage.ref().child(storagePath);

    final uploadTask = ref.putFile(
      file,
      SettableMetadata(contentType: _mimeType(file.path)),
    );

    // Stream upload progress
    uploadTask.snapshotEvents.listen((snapshot) {
      if (snapshot.totalBytes > 0) {
        onProgress?.call(snapshot.bytesTransferred / snapshot.totalBytes);
      }
    });

    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    final metadata = await snapshot.ref.getMetadata();

    return GalleryImage(
      name: fileName,
      downloadUrl: downloadUrl,
      storagePath: storagePath,
      uploadedAt: metadata.timeCreated ?? DateTime.now(),
      sizeBytes: metadata.size,
    );
  }

  /// Fetch all images from the gallery folder in Firebase Storage.
  Future<List<GalleryImage>> fetchImages() async {
    final listResult = await _storage.ref(_galleryFolder).listAll();
    final images = <GalleryImage>[];

    for (final item in listResult.items) {
      try {
        final url = await item.getDownloadURL();
        final meta = await item.getMetadata();
        images.add(GalleryImage(
          name: item.name,
          downloadUrl: url,
          storagePath: item.fullPath,
          uploadedAt: meta.timeCreated ?? DateTime.now(),
          sizeBytes: meta.size,
        ));
      } catch (_) {
        // Skip items we can't fetch
      }
    }

    images.sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));
    return images;
  }

  /// Delete an image from Firebase Storage.
  Future<void> deleteImage(String storagePath) async {
    await _storage.ref(storagePath).delete();
  }

  String _mimeType(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    const map = {
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif',
      '.webp': 'image/webp',
      '.heic': 'image/heic',
    };
    return map[ext] ?? 'image/jpeg';
  }
}