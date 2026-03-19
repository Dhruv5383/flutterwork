import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hero Animation Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
//         useMaterial3: true,
//       ),
//       home: const GalleryScreen(),
//     );
//   }
// }

// ─────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────
class PhotoItem {
  final String tag;       // Must be UNIQUE — this is the Hero tag
  final String imageUrl;
  final String title;
  final String subtitle;
  final Color accent;

  const PhotoItem({
    required this.tag,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
}

const List<PhotoItem> photos = [
  PhotoItem(
    tag: 'photo_mountain',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    title: 'Alpine Peaks',
    subtitle: 'Swiss Alps · 4,478 m',
    accent: Color(0xFF5C8FD6),
  ),
  PhotoItem(
    tag: 'photo_forest',
    imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800',
    title: 'Ancient Forest',
    subtitle: 'Pacific Northwest · Oregon',
    accent: Color(0xFF4CAF82),
  ),
  PhotoItem(
    tag: 'photo_ocean',
    imageUrl: 'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800',
    title: 'Open Ocean',
    subtitle: 'Maldives · Indian Ocean',
    accent: Color(0xFF26C6DA),
  ),
  PhotoItem(
    tag: 'photo_desert',
    imageUrl: 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800',
    title: 'Sahara Dunes',
    subtitle: 'Morocco · Erg Chebbi',
    accent: Color(0xFFFFB74D),
  ),
];

// ─────────────────────────────────────────────
// Screen 1 — Gallery (list of cards)
// ─────────────────────────────────────────────
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'EXPLORE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return GalleryCard(photo: photo);
        },
      ),
    );
  }
}

class GalleryCard extends StatelessWidget {
  final PhotoItem photo;
  const GalleryCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            // Custom page transition duration
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(photo: photo),
            // Fade the scaffold content (not the Hero — Flutter handles that)
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                ),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: photo.accent.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 🦸 Hero widget wraps the image — tag must match DetailScreen
              Hero(
                tag: photo.tag,
                child: Image.network(
                  photo.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFF1A1A2E),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: photo.accent,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
              // Text labels
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      photo.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Tap hint icon
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Screen 2 — Detail (full-screen image)
// ─────────────────────────────────────────────
class DetailScreen extends StatelessWidget {
  final PhotoItem photo;
  const DetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D14),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Hero image (full-width, larger) ──────────────
          Hero(
            tag: photo.tag, // Same tag = Flutter links the two widgets
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Image.network(
                photo.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: const Color(0xFF1A1A2E),
                    child: Center(
                      child: CircularProgressIndicator(color: photo.accent),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Detail content ────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Accent tag
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: photo.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: photo.accent.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      photo.subtitle.toUpperCase(),
                      style: TextStyle(
                        color: photo.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    photo.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A breathtaking view that captures the raw beauty of nature. '
                        'This location is one of the most photographed spots in the world, '
                        'drawing thousands of visitors every year who come to witness '
                        'its stunning landscapes and serene atmosphere.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Stats row
                  Row(
                    children: [
                      _StatChip(
                          icon: Icons.photo_camera_outlined,
                          label: '2.4k Photos',
                          accent: photo.accent),
                      const SizedBox(width: 12),
                      _StatChip(
                          icon: Icons.favorite_border_rounded,
                          label: '18.9k Likes',
                          accent: photo.accent),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Back button overlay
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;

  const _StatChip(
      {required this.icon, required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border:
        Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}