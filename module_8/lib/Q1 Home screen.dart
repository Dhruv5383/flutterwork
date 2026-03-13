import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Q1 Pref service.dart';
import 'Q1 Settings screen.dart';
//import 'pref_service.dart';
//import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.prefs,
    required this.onUpdate,
  });

  final UserPrefs prefs;
  final ValueChanged<UserPrefs> onUpdate;

  Color get _accent => AppColors.accents[prefs.accentIndex];

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _appBar(context, isDark),
            SliverToBoxAdapter(child: _profileCard(isDark)),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            _sectionLabel('SAVED PREFERENCES', isDark),
            SliverToBoxAdapter(child: _prefsGrid(context, isDark)),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            _sectionLabel('ACCENT COLOR', isDark),
            SliverToBoxAdapter(child: _quickAccentPicker(isDark)),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            _sectionLabel('STATISTICS', isDark),
            SliverToBoxAdapter(child: _statsRow(isDark)),
            const SliverToBoxAdapter(child: SizedBox(height: 36)),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────
  SliverToBoxAdapter _appBar(BuildContext ctx, bool isDark) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Preferences',
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prefs.sessionCount == 1
                          ? 'Welcome! 👋'
                          : 'Session #${prefs.sessionCount}',
                      style: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _iconButton(
                icon: Icons.settings_rounded,
                isDark: isDark,
                onTap: () => _openSettings(ctx),
              ),
            ],
          ),
        ),
      );

  // ── Profile Card ─────────────────────────────
  Widget _profileCard(bool isDark) {
    final name = prefs.name.isEmpty ? 'Guest User' : prefs.name;
    final initials = name
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_accent.withOpacity(0.9), _accent.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _accent.withOpacity(0.4),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar circle
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  initials.isEmpty ? '?' : initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    prefs.email.isEmpty ? 'No email set' : prefs.email,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 13),
                  ),
                  if (prefs.bio.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      prefs.bio,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.55), fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      _badge(prefs.language, Icons.language_rounded),
                      _badge(
                        AppColors.accentNames[prefs.accentIndex],
                        Icons.palette_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Preferences Display Grid ──────────────────
  Widget _prefsGrid(BuildContext ctx, bool isDark) {
    final items = [
      _PrefItem(Icons.dark_mode_rounded,     'Theme',         prefs.darkMode ? 'Dark Mode' : 'Light Mode'),
      _PrefItem(Icons.format_size_rounded,   'Font Size',     AppColors.fontSizeNames[prefs.fontSizeIndex]),
      _PrefItem(Icons.notifications_rounded, 'Notifications', prefs.notifications ? 'Enabled' : 'Disabled'),
      _PrefItem(Icons.mail_rounded,          'Newsletter',    prefs.newsletter ? 'Subscribed' : 'Unsubscribed'),
      _PrefItem(Icons.save_outlined,         'Auto Save',     prefs.autoSave ? 'On' : 'Off'),
      _PrefItem(Icons.language_rounded,      'Language',      prefs.language),
    ];

    final cardColor = isDark ? const Color(0xFF12121E) : Colors.white;
    final divColor  = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor  = isDark ? Colors.white38 : Colors.black38;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: divColor),
        ),
        child: Column(
          children: List.generate(items.length, (i) {
            final it = items[i];
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(it.icon, color: _accent, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(it.label,
                      style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600))),
                  Text(it.value, style: TextStyle(color: subColor, fontSize: 13)),
                ]),
              ),
              if (i < items.length - 1)
                Divider(height: 1, color: divColor, indent: 16, endIndent: 16),
            ]);
          }),
        ),
      ),
    );
  }

  // ── Quick Accent Picker ───────────────────────
  Widget _quickAccentPicker(bool isDark) {
    final cardColor = isDark ? const Color(0xFF12121E) : Colors.white;
    final divColor  = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: divColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(AppColors.accents.length, (i) {
                final selected = i == prefs.accentIndex;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onUpdate(prefs.copyWith(accentIndex: i));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.accents[i],
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(
                          color: isDark ? Colors.white : Colors.black,
                          width: 3)
                          : null,
                      boxShadow: selected
                          ? [BoxShadow(
                          color: AppColors.accents[i].withOpacity(0.5),
                          blurRadius: 10)]
                          : null,
                    ),
                    child: selected
                        ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 18)
                        : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected: ${AppColors.accentNames[prefs.accentIndex]}  •  Saved automatically',
              style: TextStyle(
                color: isDark ? Colors.white30 : Colors.black38,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────
  Widget _statsRow(bool isDark) {
    final cardColor = isDark ? const Color(0xFF12121E) : Colors.white;
    final divColor  = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor  = isDark ? Colors.white38 : Colors.black38;

    final stats = [
      _Stat('Sessions',    '${prefs.sessionCount}'),
      _Stat('Preferences', '9'),
      _Stat('Language',    prefs.language.substring(0, 2).toUpperCase()),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: stats.map((s) => Expanded(
          child: Container(
            margin: EdgeInsets.only(right: s == stats.last ? 0 : 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: divColor),
            ),
            child: Column(children: [
              Text(s.value,
                  style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(s.label,
                  style: TextStyle(color: subColor, fontSize: 10, letterSpacing: 0.5)),
            ]),
          ),
        )).toList(),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────
  SliverToBoxAdapter _sectionLabel(String title, bool isDark) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
          child: Text(title,
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black54,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              )),
        ),
      );

  Widget _badge(String label, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: Colors.white70),
      const SizedBox(width: 5),
      Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _iconButton({
    required IconData icon,
    required bool isDark,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: _accent, size: 20),
        ),
      );

  void _openSettings(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(prefs: prefs, onUpdate: onUpdate),
      ),
    );
  }
}

// ── Small Data Classes ────────────────────────
class _PrefItem {
  const _PrefItem(this.icon, this.label, this.value);
  final IconData icon;
  final String label, value;
}

class _Stat {
  const _Stat(this.label, this.value);
  final String label, value;
}