// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(const PrefsApp());
// // }
//
// // ─────────────────────────────────────────────
// //  CONSTANTS — preference keys
// // ─────────────────────────────────────────────
// class PrefKeys {
//   static const displayName   = 'display_name';
//   static const email         = 'email';
//   static const accentIndex   = 'accent_index';
//   static const fontSizeIndex = 'font_size_index';
//   static const darkMode      = 'dark_mode';
//   static const notifications = 'notifications';
//   static const newsletter    = 'newsletter';
//   static const autoSave      = 'auto_save';
//   static const language      = 'language';
//   static const sessionCount  = 'session_count';
// }
//
// // ─────────────────────────────────────────────
// //  USER PREFERENCES MODEL
// // ─────────────────────────────────────────────
// class UserPreferences {
//   String  displayName;
//   String  email;
//   int     accentIndex;
//   int     fontSizeIndex;
//   bool    darkMode;
//   bool    notifications;
//   bool    newsletter;
//   bool    autoSave;
//   String  language;
//   int     sessionCount;
//
//   UserPreferences({
//     this.displayName   = '',
//     this.email         = '',
//     this.accentIndex   = 0,
//     this.fontSizeIndex = 1,
//     this.darkMode      = true,
//     this.notifications = true,
//     this.newsletter    = false,
//     this.autoSave      = true,
//     this.language      = 'English',
//     this.sessionCount  = 0,
//   });
//
//   static Future<UserPreferences> load() async {
//     final p = await SharedPreferences.getInstance();
//     final count = (p.getInt(PrefKeys.sessionCount) ?? 0) + 1;
//     await p.setInt(PrefKeys.sessionCount, count);
//     return UserPreferences(
//       displayName:   p.getString(PrefKeys.displayName)   ?? '',
//       email:         p.getString(PrefKeys.email)         ?? '',
//       accentIndex:   p.getInt(PrefKeys.accentIndex)      ?? 0,
//       fontSizeIndex: p.getInt(PrefKeys.fontSizeIndex)    ?? 1,
//       darkMode:      p.getBool(PrefKeys.darkMode)        ?? true,
//       notifications: p.getBool(PrefKeys.notifications)   ?? true,
//       newsletter:    p.getBool(PrefKeys.newsletter)      ?? false,
//       autoSave:      p.getBool(PrefKeys.autoSave)        ?? true,
//       language:      p.getString(PrefKeys.language)      ?? 'English',
//       sessionCount:  count,
//     );
//   }
//
//   Future<void> save() async {
//     final p = await SharedPreferences.getInstance();
//     await Future.wait([
//       p.setString(PrefKeys.displayName,   displayName),
//       p.setString(PrefKeys.email,         email),
//       p.setInt   (PrefKeys.accentIndex,   accentIndex),
//       p.setInt   (PrefKeys.fontSizeIndex, fontSizeIndex),
//       p.setBool  (PrefKeys.darkMode,      darkMode),
//       p.setBool  (PrefKeys.notifications, notifications),
//       p.setBool  (PrefKeys.newsletter,    newsletter),
//       p.setBool  (PrefKeys.autoSave,      autoSave),
//       p.setString(PrefKeys.language,      language),
//     ]);
//   }
//
//   static Future<void> clear() async {
//     final p = await SharedPreferences.getInstance();
//     await p.clear();
//   }
// }
//
// // ─────────────────────────────────────────────
// //  THEME CONSTANTS
// // ─────────────────────────────────────────────
// const _accentColors = [
//   Color(0xFF6C63FF),
//   Color(0xFF00C9A7),
//   Color(0xFFFF6B6B),
//   Color(0xFFFFD166),
//   Color(0xFF56AEFF),
//   Color(0xFFFF9F43),
// ];
// const _accentNames    = ['Violet', 'Teal', 'Coral', 'Gold', 'Sky', 'Amber'];
// const _fontSizeNames  = ['Small', 'Medium', 'Large'];
// const _fontSizes      = [13.0, 15.0, 17.0];
// const _languages      = ['English', 'Spanish', 'French', 'German', 'Japanese', 'Arabic'];
//
// // ─────────────────────────────────────────────
// //  ROOT APP
// // ─────────────────────────────────────────────
// class PrefsApp extends StatefulWidget {
//   const PrefsApp({super.key});
//   @override State<PrefsApp> createState() => _PrefsAppState();
// }
//
// class _PrefsAppState extends State<PrefsApp> {
//   UserPreferences? _prefs;
//
//   @override
//   void initState() {
//     super.initState();
//     UserPreferences.load().then((p) => setState(() => _prefs = p));
//   }
//
//   void _update(UserPreferences p) { setState(() => _prefs = p); p.save(); }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_prefs == null) {
//       return const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(backgroundColor: Color(0xFF0A0A14),
//             body: Center(child: CircularProgressIndicator(color: Color(0xFF6C63FF), strokeWidth: 2))),
//       );
//     }
//     final p = _prefs!;
//     final accent = _accentColors[p.accentIndex];
//     final base   = _fontSizes[p.fontSizeIndex];
//     ThemeData theme(bool dark) => ThemeData(
//       useMaterial3: true,
//       brightness: dark ? Brightness.dark : Brightness.light,
//       colorScheme: ColorScheme.fromSeed(seedColor: accent,
//           brightness: dark ? Brightness.dark : Brightness.light).copyWith(primary: accent),
//       scaffoldBackgroundColor: dark ? const Color(0xFF0A0A14) : const Color(0xFFF4F4FB),
//       textTheme: TextTheme(
//         bodyMedium:  TextStyle(fontSize: base),
//         bodySmall:   TextStyle(fontSize: base - 2),
//         titleMedium: TextStyle(fontSize: base + 1, fontWeight: FontWeight.w600),
//         titleLarge:  TextStyle(fontSize: base + 5, fontWeight: FontWeight.w700),
//       ),
//     );
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'PrefsApp',
//       themeMode: p.darkMode ? ThemeMode.dark : ThemeMode.light,
//       darkTheme: theme(true),
//       theme: theme(false),
//       home: HomeScreen(prefs: p, onUpdate: _update),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  HOME SCREEN  (displays current preferences)
// // ─────────────────────────────────────────────
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key, required this.prefs, required this.onUpdate});
//   final UserPreferences prefs;
//   final ValueChanged<UserPreferences> onUpdate;
//
//   UserPreferences _copy() => UserPreferences(
//     displayName: prefs.displayName, email: prefs.email,
//     accentIndex: prefs.accentIndex, fontSizeIndex: prefs.fontSizeIndex,
//     darkMode: prefs.darkMode, notifications: prefs.notifications,
//     newsletter: prefs.newsletter, autoSave: prefs.autoSave,
//     language: prefs.language, sessionCount: prefs.sessionCount,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final theme  = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final accent = _accentColors[prefs.accentIndex];
//     final bgCard = isDark ? const Color(0xFF12121E) : Colors.white;
//     final divC   = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);
//     final subC   = isDark ? Colors.white60 : Colors.black54;
//
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
//           // Header
//           SliverToBoxAdapter(child: Padding(
//             padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
//             child: Row(children: [
//               Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Text('My Preferences', style: theme.textTheme.titleLarge?.copyWith(
//                     color: isDark ? Colors.white : Colors.black87, letterSpacing: -0.6)),
//                 const SizedBox(height: 4),
//                 Text(prefs.sessionCount == 1 ? 'Welcome! 👋' : 'Session #${prefs.sessionCount}',
//                     style: TextStyle(color: subC, fontSize: 12)),
//               ])),
//               _iconBtn(context, Icons.settings_rounded, accent, isDark, () =>
//                   Navigator.push(context, MaterialPageRoute(
//                       builder: (_) => SettingsScreen(prefs: prefs, onUpdate: onUpdate)))),
//             ]),
//           )),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 24)),
//
//           // Profile card
//           SliverToBoxAdapter(child: _profileCard(context, accent, isDark)),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 24)),
//
//           // Preferences display
//           SliverToBoxAdapter(child: Padding(
//             padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
//             child: Text('SAVED PREFERENCES',
//                 style: TextStyle(color: subC, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
//           )),
//
//           SliverToBoxAdapter(child: _prefsGrid(context, bgCard, divC, accent, isDark)),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//           // Quick accent picker
//           SliverToBoxAdapter(child: _accentPicker(context, bgCard, isDark)),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 36)),
//         ]),
//       ),
//     );
//   }
//
//   Widget _profileCard(BuildContext ctx, Color accent, bool isDark) {
//     final name     = prefs.displayName.isEmpty ? 'Guest User' : prefs.displayName;
//     final initials = name.trim().split(' ').take(2)
//         .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').join();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [accent.withOpacity(0.9), accent.withOpacity(0.5)],
//               begin: Alignment.topLeft, end: Alignment.bottomRight),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [BoxShadow(color: accent.withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 8))],
//         ),
//         child: Row(children: [
//           Container(width: 64, height: 64,
//               decoration: BoxDecoration(shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(0.2),
//                   border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
//               child: Center(child: Text(initials.isEmpty ? '?' : initials,
//                   style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)))),
//           const SizedBox(width: 16),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
//             const SizedBox(height: 4),
//             Text(prefs.email.isEmpty ? 'No email set' : prefs.email,
//                 style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
//             const SizedBox(height: 10),
//             Wrap(spacing: 8, children: [
//               _badge(prefs.language, Icons.language_rounded),
//               _badge(_accentNames[prefs.accentIndex], Icons.palette_outlined),
//             ]),
//           ])),
//           IconButton(
//             onPressed: () => Navigator.push(ctx, MaterialPageRoute(
//                 builder: (_) => SettingsScreen(prefs: prefs, onUpdate: onUpdate))),
//             icon: const Icon(Icons.edit_rounded, color: Colors.white70, size: 20),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Widget _prefsGrid(BuildContext ctx, Color bg, Color div, Color accent, bool isDark) {
//     final rows = [
//       _Row(Icons.dark_mode_rounded,        'Theme',         prefs.darkMode ? 'Dark Mode' : 'Light Mode'),
//       _Row(Icons.format_size_rounded,      'Font Size',     _fontSizeNames[prefs.fontSizeIndex]),
//       _Row(Icons.notifications_rounded,    'Notifications', prefs.notifications ? 'Enabled' : 'Disabled'),
//       _Row(Icons.mail_rounded,             'Newsletter',    prefs.newsletter ? 'Subscribed' : 'Unsubscribed'),
//       _Row(Icons.save_outlined,            'Auto Save',     prefs.autoSave ? 'On' : 'Off'),
//       _Row(Icons.language_rounded,         'Language',      prefs.language),
//     ];
//     final textC = isDark ? Colors.white : Colors.black87;
//     final subC  = isDark ? Colors.white38 : Colors.black38;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       child: Container(
//         decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06))),
//         child: Column(children: List.generate(rows.length, (i) => Column(children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//             child: Row(children: [
//               Container(width: 36, height: 36,
//                   decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//                   child: Icon(rows[i].icon, color: accent, size: 18)),
//               const SizedBox(width: 14),
//               Expanded(child: Text(rows[i].label,
//                   style: TextStyle(color: textC, fontSize: 14, fontWeight: FontWeight.w600))),
//               Text(rows[i].value, style: TextStyle(color: subC, fontSize: 13)),
//             ]),
//           ),
//           if (i < rows.length - 1) Divider(height: 1, color: div, indent: 18, endIndent: 18),
//         ]))),
//       ),
//     );
//   }
//
//   Widget _accentPicker(BuildContext ctx, Color bg, bool isDark) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22),
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06))),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text('QUICK ACCENT', style: TextStyle(
//               color: isDark ? Colors.white60 : Colors.black54,
//               fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
//           const SizedBox(height: 14),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(_accentColors.length, (i) {
//               final sel = i == prefs.accentIndex;
//               return GestureDetector(
//                 onTap: () { HapticFeedback.selectionClick(); onUpdate(_copy()..accentIndex = i); },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 220),
//                   width: 44, height: 44,
//                   decoration: BoxDecoration(
//                     color: _accentColors[i], shape: BoxShape.circle,
//                     border: sel ? Border.all(color: isDark ? Colors.white : Colors.black, width: 3) : null,
//                     boxShadow: sel ? [BoxShadow(color: _accentColors[i].withOpacity(0.5), blurRadius: 12)] : null,
//                   ),
//                   child: sel ? const Icon(Icons.check_rounded, color: Colors.white, size: 18) : null,
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 8),
//           Text('Tap to instantly change accent — saved automatically',
//               style: TextStyle(color: isDark ? Colors.white24 : Colors.black26, fontSize: 11)),
//         ]),
//       ),
//     );
//   }
//
//   Widget _badge(String label, IconData icon) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//     decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
//     child: Row(mainAxisSize: MainAxisSize.min, children: [
//       Icon(icon, size: 11, color: Colors.white70),
//       const SizedBox(width: 5),
//       Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
//     ]),
//   );
//
//   Widget _iconBtn(BuildContext ctx, IconData icon, Color accent, bool isDark, VoidCallback cb) =>
//       GestureDetector(onTap: cb,
//           child: Container(width: 42, height: 42,
//               decoration: BoxDecoration(
//                   color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
//                   borderRadius: BorderRadius.circular(13)),
//               child: Icon(icon, color: accent, size: 20)));
// }
//
// class _Row {
//   const _Row(this.icon, this.label, this.value);
//   final IconData icon; final String label, value;
// }
//
// // ─────────────────────────────────────────────
// //  SETTINGS SCREEN  (edit + save preferences)
// // ─────────────────────────────────────────────
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key, required this.prefs, required this.onUpdate});
//   final UserPreferences prefs;
//   final ValueChanged<UserPreferences> onUpdate;
//   @override State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   late UserPreferences _p;
//   late TextEditingController _nameCtrl;
//   late TextEditingController _emailCtrl;
//   bool _saved = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _p = widget.prefs;
//     _nameCtrl  = TextEditingController(text: _p.displayName);
//     _emailCtrl = TextEditingController(text: _p.email);
//   }
//   @override void dispose() { _nameCtrl.dispose(); _emailCtrl.dispose(); super.dispose(); }
//
//   UserPreferences _copy() => UserPreferences(
//     displayName: _nameCtrl.text, email: _emailCtrl.text,
//     accentIndex: _p.accentIndex, fontSizeIndex: _p.fontSizeIndex,
//     darkMode: _p.darkMode, notifications: _p.notifications,
//     newsletter: _p.newsletter, autoSave: _p.autoSave,
//     language: _p.language, sessionCount: _p.sessionCount,
//   );
//
//   void _mut(UserPreferences p) => setState(() { _p = p; _saved = false; });
//
//   Future<void> _save() async {
//     final updated = _copy();
//     await updated.save();
//     widget.onUpdate(updated);
//     setState(() => _saved = true);
//     HapticFeedback.lightImpact();
//     if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: const Row(children: [
//         Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
//         SizedBox(width: 10),
//         Text('Preferences saved!', style: TextStyle(fontWeight: FontWeight.w600)),
//       ]),
//       backgroundColor: _accentColors[_p.accentIndex],
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       margin: const EdgeInsets.all(16),
//       duration: const Duration(seconds: 2),
//     ));
//   }
//
//   Future<void> _reset() async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1A1A2E) : Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text('Reset all preferences?', style: TextStyle(fontWeight: FontWeight.w700)),
//         content: const Text('This clears every saved setting and cannot be undone.'),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
//           TextButton(onPressed: () => Navigator.pop(context, true),
//               child: const Text('Reset', style: TextStyle(color: Color(0xFFFF6B6B), fontWeight: FontWeight.w700))),
//         ],
//       ),
//     );
//     if (ok == true) {
//       await UserPreferences.clear();
//       final fresh = await UserPreferences.load();
//       widget.onUpdate(fresh);
//       setState(() { _p = fresh; _nameCtrl.text = ''; _emailCtrl.text = ''; });
//       if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('All preferences reset'),
//         backgroundColor: Color(0xFFFF6B6B),
//         behavior: SnackBarBehavior.floating,
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme  = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final accent = _accentColors[_p.accentIndex];
//     final bgCard = isDark ? const Color(0xFF12121E) : Colors.white;
//     final divC   = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06);
//     final lblC   = isDark ? Colors.white60 : Colors.black54;
//
//     return Scaffold(
//       body: SafeArea(child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
//         // Header
//         SliverToBoxAdapter(child: Padding(
//           padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
//           child: Row(children: [
//             GestureDetector(onTap: () => Navigator.pop(context),
//                 child: Container(width: 40, height: 40,
//                     decoration: BoxDecoration(
//                         color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
//                         borderRadius: BorderRadius.circular(13)),
//                     child: Icon(Icons.arrow_back_rounded,
//                         color: isDark ? Colors.white : Colors.black87, size: 20))),
//             const SizedBox(width: 14),
//             Expanded(child: Text('Settings', style: theme.textTheme.titleLarge?.copyWith(
//                 color: isDark ? Colors.white : Colors.black87, letterSpacing: -0.5))),
//             GestureDetector(onTap: _save,
//                 child: AnimatedContainer(duration: const Duration(milliseconds: 250),
//                     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: [accent, accent.withOpacity(0.7)]),
//                       borderRadius: BorderRadius.circular(14),
//                       boxShadow: [BoxShadow(color: accent.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
//                     ),
//                     child: Row(mainAxisSize: MainAxisSize.min, children: [
//                       Icon(_saved ? Icons.check_rounded : Icons.save_rounded, color: Colors.white, size: 16),
//                       const SizedBox(width: 6),
//                       Text(_saved ? 'Saved!' : 'Save',
//                           style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
//                     ]))),
//           ]),
//         )),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 28)),
//
//         // ── PROFILE ──
//         _lbl('PROFILE', lblC),
//         _card(bgCard, isDark, [
//           _field(_nameCtrl,  'Display Name',   Icons.person_outline_rounded,  accent, isDark),
//           Divider(height: 1, color: divC),
//           _field(_emailCtrl, 'Email Address',   Icons.mail_outline_rounded,   accent, isDark, kb: TextInputType.emailAddress),
//         ]),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//         // ── APPEARANCE ──
//         _lbl('APPEARANCE', lblC),
//         _card(bgCard, isDark, [
//           _toggle(Icons.dark_mode_rounded,    'Dark Mode',  accent, isDark, _p.darkMode,      (v) => _mut(_copy()..darkMode = v)),
//           Divider(height: 1, color: divC),
//           _fontPicker(accent, isDark),
//           Divider(height: 1, color: divC),
//           _colorPicker(accent, isDark),
//         ]),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//         // ── NOTIFICATIONS ──
//         _lbl('NOTIFICATIONS', lblC),
//         _card(bgCard, isDark, [
//           _toggle(Icons.notifications_rounded, 'Push Notifications', accent, isDark, _p.notifications, (v) => _mut(_copy()..notifications = v)),
//           Divider(height: 1, color: divC),
//           _toggle(Icons.mail_rounded,          'Newsletter',         accent, isDark, _p.newsletter,    (v) => _mut(_copy()..newsletter = v)),
//         ]),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//         // ── GENERAL ──
//         _lbl('GENERAL', lblC),
//         _card(bgCard, isDark, [
//           _toggle(Icons.save_outlined, 'Auto Save', accent, isDark, _p.autoSave, (v) => _mut(_copy()..autoSave = v)),
//           Divider(height: 1, color: divC),
//           _langPicker(accent, isDark),
//         ]),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//         // ── DATA ──
//         _lbl('DATA', lblC),
//         _card(bgCard, isDark, [
//           _infoRow(Icons.bar_chart_rounded, 'Sessions', '${_p.sessionCount}', accent, isDark),
//           Divider(height: 1, color: divC),
//           GestureDetector(onTap: _reset,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//                 child: Row(children: [
//                   Container(width: 36, height: 36,
//                       decoration: BoxDecoration(color: const Color(0xFFFF6B6B).withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF6B6B), size: 18)),
//                   const SizedBox(width: 14),
//                   const Expanded(child: Text('Reset All Preferences',
//                       style: TextStyle(color: Color(0xFFFF6B6B), fontSize: 14, fontWeight: FontWeight.w600))),
//                   const Icon(Icons.chevron_right_rounded, color: Color(0xFFFF6B6B), size: 18),
//                 ]),
//               )),
//         ]),
//
//         const SliverToBoxAdapter(child: SizedBox(height: 48)),
//       ])),
//     );
//   }
//
//   // ── Row widgets ──
//   Widget _toggle(IconData icon, String label, Color accent, bool isDark, bool val, ValueChanged<bool> cb) =>
//       Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
//           child: Row(children: [
//             Container(width: 36, height: 36,
//                 decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//                 child: Icon(icon, color: accent, size: 18)),
//             const SizedBox(width: 14),
//             Expanded(child: Text(label, style: TextStyle(
//                 color: isDark ? Colors.white : Colors.black87, fontSize: 14, fontWeight: FontWeight.w600))),
//             Switch.adaptive(value: val, onChanged: cb, activeColor: accent,
//                 inactiveTrackColor: isDark ? Colors.white12 : Colors.black12),
//           ]));
//
//   Widget _fontPicker(Color accent, bool isDark) => Padding(
//     padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
//     child: Row(children: [
//       Container(width: 36, height: 36,
//           decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//           child: Icon(Icons.format_size_rounded, color: accent, size: 18)),
//       const SizedBox(width: 14),
//       Expanded(child: Text('Font Size', style: TextStyle(
//           color: isDark ? Colors.white : Colors.black87, fontSize: 14, fontWeight: FontWeight.w600))),
//       Row(children: List.generate(3, (i) => GestureDetector(
//         onTap: () { HapticFeedback.selectionClick(); _mut(_copy()..fontSizeIndex = i); },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           margin: const EdgeInsets.only(left: 6),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: i == _p.fontSizeIndex ? accent : accent.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(_fontSizeNames[i], style: TextStyle(
//               color: i == _p.fontSizeIndex ? Colors.white : accent,
//               fontSize: 11, fontWeight: FontWeight.w700)),
//         ),
//       ))),
//     ]),
//   );
//
//   Widget _colorPicker(Color accent, bool isDark) => Padding(
//     padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Row(children: [
//         Container(width: 36, height: 36,
//             decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//             child: Icon(Icons.palette_rounded, color: accent, size: 18)),
//         const SizedBox(width: 14),
//         Text('Accent Color', style: TextStyle(
//             color: isDark ? Colors.white : Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)),
//         const SizedBox(width: 8),
//         Container(width: 14, height: 14, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
//       ]),
//       const SizedBox(height: 14),
//       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(_accentColors.length, (i) {
//           final sel = i == _p.accentIndex;
//           return GestureDetector(
//             onTap: () { HapticFeedback.selectionClick(); _mut(_copy()..accentIndex = i); },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               width: 40, height: 40,
//               decoration: BoxDecoration(
//                 color: _accentColors[i], shape: BoxShape.circle,
//                 border: sel ? Border.all(color: isDark ? Colors.white : Colors.black, width: 3) : null,
//                 boxShadow: sel ? [BoxShadow(color: _accentColors[i].withOpacity(0.5), blurRadius: 10)] : null,
//               ),
//               child: sel ? const Icon(Icons.check_rounded, color: Colors.white, size: 16) : null,
//             ),
//           );
//         }),
//       ),
//       const SizedBox(height: 6),
//       Text(_accentNames[_p.accentIndex],
//           style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 11)),
//     ]),
//   );
//
//   Widget _langPicker(Color accent, bool isDark) => Padding(
//     padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
//     child: Row(children: [
//       Container(width: 36, height: 36,
//           decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//           child: Icon(Icons.language_rounded, color: accent, size: 18)),
//       const SizedBox(width: 14),
//       Expanded(child: Text('Language', style: TextStyle(
//           color: isDark ? Colors.white : Colors.black87, fontSize: 14, fontWeight: FontWeight.w600))),
//       DropdownButton<String>(
//         value: _p.language, underline: const SizedBox(),
//         dropdownColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
//         style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, fontSize: 13),
//         icon: Icon(Icons.expand_more_rounded, color: accent, size: 18),
//         items: _languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
//         onChanged: (v) { if (v != null) _mut(_copy()..language = v); },
//       ),
//     ]),
//   );
//
//   Widget _infoRow(IconData icon, String label, String val, Color accent, bool isDark) =>
//       Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//           child: Row(children: [
//             Container(width: 36, height: 36,
//                 decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//                 child: Icon(icon, color: accent, size: 18)),
//             const SizedBox(width: 14),
//             Expanded(child: Text(label, style: TextStyle(
//                 color: isDark ? Colors.white : Colors.black87, fontSize: 14, fontWeight: FontWeight.w600))),
//             Text(val, style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14)),
//           ]));
//
//   Widget _field(TextEditingController ctrl, String hint, IconData icon, Color accent, bool isDark,
//       {TextInputType? kb}) =>
//       Padding(padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
//           child: Row(children: [
//             Container(width: 36, height: 36,
//                 decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
//                 child: Icon(icon, color: accent, size: 18)),
//             const SizedBox(width: 14),
//             Expanded(child: TextField(
//               controller: ctrl, keyboardType: kb,
//               style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
//               onChanged: (_) => setState(() => _saved = false),
//               decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: TextStyle(color: isDark ? Colors.white30 : Colors.black38, fontSize: 14),
//                 border: InputBorder.none, isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             )),
//           ]));
//
//   // ── Layout helpers ──
//   SliverToBoxAdapter _lbl(String t, Color c) => SliverToBoxAdapter(child: Padding(
//     padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
//     child: Text(t, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
//   ));
//
//   SliverToBoxAdapter _card(Color bg, bool isDark, List<Widget> children) => SliverToBoxAdapter(
//       child: Padding(padding: const EdgeInsets.symmetric(horizontal: 22),
//           child: Container(
//               decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06))),
//               child: Column(children: children))));
// }