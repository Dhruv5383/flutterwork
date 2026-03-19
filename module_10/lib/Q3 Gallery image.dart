class GalleryImage {
  final String name;
  final String downloadUrl;
  final String storagePath;
  final DateTime uploadedAt;
  final int? sizeBytes;

  const GalleryImage({
    required this.name,
    required this.downloadUrl,
    required this.storagePath,
    required this.uploadedAt,
    this.sizeBytes,
  });

  String get formattedSize {
    if (sizeBytes == null) return '';
    if (sizeBytes! < 1024) return '${sizeBytes}B';
    if (sizeBytes! < 1024 * 1024) return '${(sizeBytes! / 1024).toStringAsFixed(1)}KB';
    return '${(sizeBytes! / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}