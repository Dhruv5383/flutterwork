import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'Q3 Gallery image.dart';
import 'Q3 Gallery provider.dart';
import 'Q3 Image detail screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../providers/gallery_provider.dart';
// import '../models/gallery_image.dart';
// import 'image_detail_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryProvider>().loadImages();
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUpload(ImageSource source) async {
    Navigator.pop(context); // close bottom sheet
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;

    final provider = context.read<GalleryProvider>();
    final success = await provider.uploadImage(File(picked.path));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? '✓ Image uploaded!' : provider.errorMessage ?? 'Upload failed'),
          backgroundColor: success ? const Color(0xFF00C853) : const Color(0xFFD50000),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF16213E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a source to upload from',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 24),
              _SourceTile(
                icon: Icons.photo_library_rounded,
                label: 'Photo Library',
                onTap: () => _pickAndUpload(ImageSource.gallery),
              ),
              const SizedBox(height: 12),
              _SourceTile(
                icon: Icons.camera_alt_rounded,
                label: 'Camera',
                onTap: () => _pickAndUpload(ImageSource.camera),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryProvider(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D1A),
        body: Consumer<GalleryProvider>(
          builder: (context, provider, _) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(provider),
                if (provider.isUploading)
                  SliverToBoxAdapter(child: _UploadProgressBar(progress: provider.uploadProgress)),
                if (provider.isLoading)
                  const SliverFillRemaining(child: Center(child: _LoadingSpinner()))
                else if (provider.images.isEmpty && !provider.isLoading)
                  const SliverFillRemaining(child: _EmptyState())
                else
                  _GalleryGrid(images: provider.images),
              ],
            );
          },
        ),
        floatingActionButton: Consumer<GalleryProvider>(
          builder: (context, provider, _) => FloatingActionButton.extended(
            onPressed: provider.isUploading ? null : _showUploadOptions,
            backgroundColor: const Color(0xFFE94560),
            foregroundColor: Colors.white,
            icon: provider.isUploading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
                : const Icon(Icons.add_photo_alternate_rounded),
            label: Text(provider.isUploading ? 'Uploading…' : 'Upload'),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(GalleryProvider provider) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: const Color(0xFF0D0D1A),
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gallery',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            if (provider.images.isNotEmpty)
              Text(
                '${provider.images.length} photos',
                style: const TextStyle(
                  color: Color(0xFFE94560),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
          onPressed: () => provider.loadImages(),
          tooltip: 'Refresh',
        ),
      ],
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0F3460),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFE94560), size: 28),
            const SizedBox(width: 16),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 16),
          ],
        ),
      ),
    );
  }
}

class _UploadProgressBar extends StatelessWidget {
  final double progress;
  const _UploadProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF16213E),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Uploading…', style: TextStyle(color: Colors.white70, fontSize: 13)),
              Text('${(progress * 100).toInt()}%',
                  style: const TextStyle(color: Color(0xFFE94560), fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF0F3460),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE94560)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingSpinner extends StatelessWidget {
  const _LoadingSpinner();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF16213E),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE94560).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(
              color: Color(0xFFE94560),
              strokeWidth: 3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Loading gallery…', style: TextStyle(color: Colors.white38)),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF16213E),
              border: Border.all(color: const Color(0xFFE94560).withOpacity(0.3), width: 2),
            ),
            child: const Icon(Icons.photo_library_outlined, size: 40, color: Color(0xFFE94560)),
          ),
          const SizedBox(height: 24),
          const Text('No photos yet',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Tap + Upload to add your first photo',
              style: TextStyle(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  final List<GalleryImage> images;
  const _GalleryGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) => _GalleryTile(image: images[index]),
          childCount: images.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      ),
    );
  }
}

class _GalleryTile extends StatelessWidget {
  final GalleryImage image;
  const _GalleryTile({required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, a, __) => ImageDetailScreen(image: image),
            transitionsBuilder: (_, a, __, child) =>
                FadeTransition(opacity: a, child: child),
          ),
        );
      },
      child: Hero(
        tag: image.storagePath,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            image.downloadUrl,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                color: const Color(0xFF16213E),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFE94560),
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF16213E),
              child: const Icon(Icons.broken_image_rounded, color: Colors.white38),
            ),
          ),
        ),
      ),
    );
  }
}