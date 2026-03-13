import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Q1 Pref service.dart';
//import 'pref_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.prefs,
    required this.onUpdate,
  });

  final UserPrefs prefs;
  final ValueChanged<UserPrefs> onUpdate;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserPrefs _p;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _bioCtrl;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _p = widget.prefs;
    _nameCtrl  = TextEditingController(text: _p.name);
    _emailCtrl = TextEditingController(text: _p.email);
    _bioCtrl   = TextEditingController(text: _p.bio);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  // ── Read form fields into a new UserPrefs ────
  UserPrefs _fromForm() => _p.copyWith(
    name:  _nameCtrl.text.trim(),
    email: _emailCtrl.text.trim(),
    bio:   _bioCtrl.text.trim(),
  );

  void _mutate(UserPrefs updated) {
    setState(() { _p = updated; _saved = false; });
  }

  // ── Save ─────────────────────────────────────
  Future<void> _save() async {
    final updated = _fromForm();
    await PrefService.save(updated);
    widget.onUpdate(updated);
    setState(() { _p = updated; _saved = true; });
    HapticFeedback.lightImpact();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: const [
          Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
          SizedBox(width: 10),
          Text('Preferences saved!',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: AppColors.accents[_p.accentIndex],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ── Reset ────────────────────────────────────
  Future<void> _reset() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1A1A2E)
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset all preferences?',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text(
            'This clears every saved setting. The session count will be kept.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset',
                style: TextStyle(
                    color: Color(0xFFFF6B6B), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (ok != true) return;

    await PrefService.reset();
    final fresh = await PrefService.load();
    widget.onUpdate(fresh);
    setState(() {
      _p = fresh;
      _nameCtrl.text  = '';
      _emailCtrl.text = '';
      _bioCtrl.text   = '';
      _saved = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All preferences reset'),
        backgroundColor: const Color(0xFFFF6B6B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ── Build ─────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final isDark  = theme.brightness == Brightness.dark;
    final accent  = AppColors.accents[_p.accentIndex];
    final cardBg  = isDark ? const Color(0xFF12121E) : Colors.white;
    final divC    = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.black.withOpacity(0.06);
    final labelC  = isDark ? Colors.white60 : Colors.black54;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 8),
                child: Row(children: [
                  _backBtn(isDark),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text('Settings',
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: isDark ? Colors.white : Colors.black87,
                            letterSpacing: -0.5)),
                  ),
                  _saveBtn(accent),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ── Profile ──
            _header('PROFILE', labelC),
            _card(cardBg, divC, [
              _textRow(_nameCtrl,  'Display Name',  Icons.person_outline_rounded, accent, isDark),
              _divider(divC),
              _textRow(_emailCtrl, 'Email',         Icons.mail_outline_rounded,   accent, isDark,
                  kb: TextInputType.emailAddress),
              _divider(divC),
              _textRow(_bioCtrl,   'Bio',           Icons.edit_outlined,           accent, isDark),
            ]),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ── Appearance ──
            _header('APPEARANCE', labelC),
            _card(cardBg, divC, [
              _toggleRow(Icons.dark_mode_rounded, 'Dark Mode', accent, isDark,
                  _p.darkMode, (v) => _mutate(_p.copyWith(darkMode: v))),
              _divider(divC),
              _fontRow(accent, isDark, divC),
              _divider(divC),
              _colorRow(accent, isDark),
            ]),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ── Notifications ──
            _header('NOTIFICATIONS', labelC),
            _card(cardBg, divC, [
              _toggleRow(Icons.notifications_rounded, 'Push Notifications',
                  accent, isDark, _p.notifications,
                      (v) => _mutate(_p.copyWith(notifications: v))),
              _divider(divC),
              _toggleRow(Icons.mail_rounded, 'Newsletter',
                  accent, isDark, _p.newsletter,
                      (v) => _mutate(_p.copyWith(newsletter: v))),
            ]),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ── General ──
            _header('GENERAL', labelC),
            _card(cardBg, divC, [
              _toggleRow(Icons.save_outlined, 'Auto Save',
                  accent, isDark, _p.autoSave,
                      (v) => _mutate(_p.copyWith(autoSave: v))),
              _divider(divC),
              _languageRow(accent, isDark),
            ]),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ── Data ──
            _header('DATA', labelC),
            _card(cardBg, divC, [
              _infoRow(Icons.bar_chart_rounded, 'Total Sessions',
                  '${_p.sessionCount}', accent, isDark),
              _divider(divC),
              _infoRow(Icons.storage_rounded, 'Stored Keys',
                  '9 keys', accent, isDark),
              _divider(divC),
              _resetRow(),
            ]),

            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  // ── Row Widgets ───────────────────────────────

  Widget _toggleRow(IconData icon, String label, Color accent, bool isDark,
      bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(children: [
        _iconBox(icon, accent),
        const SizedBox(width: 14),
        Expanded(child: Text(label,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14, fontWeight: FontWeight.w600))),
        Switch.adaptive(
          value: value,
          onChanged: (v) { HapticFeedback.selectionClick(); onChanged(v); },
          activeColor: accent,
          inactiveTrackColor:
          isDark ? Colors.white12 : Colors.black12,
        ),
      ]),
    );
  }

  Widget _textRow(TextEditingController ctrl, String hint, IconData icon,
      Color accent, bool isDark, {TextInputType? kb}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(children: [
        _iconBox(icon, accent),
        const SizedBox(width: 14),
        Expanded(child: TextField(
          controller: ctrl,
          keyboardType: kb,
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black87, fontSize: 14),
          onChanged: (_) => setState(() => _saved = false),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: isDark ? Colors.white38 : Colors.black26,
                fontSize: 14),
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        )),
      ]),
    );
  }

  Widget _fontRow(Color accent, bool isDark, Color divC) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(children: [
        _iconBox(Icons.format_size_rounded, accent),
        const SizedBox(width: 14),
        Expanded(child: Text('Font Size',
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14, fontWeight: FontWeight.w600))),
        Row(children: List.generate(3, (i) => GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            _mutate(_p.copyWith(fontSizeIndex: i));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: i == _p.fontSizeIndex ? accent : accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(AppColors.fontSizeNames[i],
                style: TextStyle(
                    color: i == _p.fontSizeIndex ? Colors.white : accent,
                    fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ))),
      ]),
    );
  }

  Widget _colorRow(Color accent, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _iconBox(Icons.palette_rounded, accent),
          const SizedBox(width: 14),
          Text('Accent Color',
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Container(
            width: 14, height: 14,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
        ]),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(AppColors.accents.length, (i) {
            final sel = i == _p.accentIndex;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                _mutate(_p.copyWith(accentIndex: i));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accents[i],
                  shape: BoxShape.circle,
                  border: sel
                      ? Border.all(
                      color: isDark ? Colors.white : Colors.black,
                      width: 3)
                      : null,
                  boxShadow: sel
                      ? [BoxShadow(
                      color: AppColors.accents[i].withOpacity(0.5),
                      blurRadius: 10)]
                      : null,
                ),
                child: sel
                    ? const Icon(Icons.check_rounded,
                    color: Colors.white, size: 16)
                    : null,
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(AppColors.accentNames[_p.accentIndex],
            style: TextStyle(
                color: isDark ? Colors.white38 : Colors.black38,
                fontSize: 11)),
      ]),
    );
  }

  Widget _languageRow(Color accent, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      child: Row(children: [
        _iconBox(Icons.language_rounded, accent),
        const SizedBox(width: 14),
        Expanded(child: Text('Language',
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14, fontWeight: FontWeight.w600))),
        DropdownButton<String>(
          value: _p.language,
          underline: const SizedBox(),
          dropdownColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
          style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87, fontSize: 13),
          icon: Icon(Icons.expand_more_rounded, color: accent, size: 18),
          items: AppColors.languages
              .map((l) => DropdownMenuItem(value: l, child: Text(l)))
              .toList(),
          onChanged: (v) {
            if (v != null) _mutate(_p.copyWith(language: v));
          },
        ),
      ]),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      Color accent, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        _iconBox(icon, accent),
        const SizedBox(width: 14),
        Expanded(child: Text(label,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14, fontWeight: FontWeight.w600))),
        Text(value,
            style: TextStyle(
                color: isDark ? Colors.white38 : Colors.black38,
                fontSize: 14)),
      ]),
    );
  }

  Widget _resetRow() => GestureDetector(
    onTap: _reset,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B6B).withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.delete_outline_rounded,
              color: Color(0xFFFF6B6B), size: 18),
        ),
        const SizedBox(width: 14),
        const Expanded(child: Text('Reset All Preferences',
            style: TextStyle(
                color: Color(0xFFFF6B6B),
                fontSize: 14, fontWeight: FontWeight.w600))),
        const Icon(Icons.chevron_right_rounded,
            color: Color(0xFFFF6B6B), size: 18),
      ]),
    ),
  );

  // ── Layout Helpers ────────────────────────────

  SliverToBoxAdapter _header(String title, Color color) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
          child: Text(title,
              style: TextStyle(
                  color: color,
                  fontSize: 11, fontWeight: FontWeight.w700,
                  letterSpacing: 1.2)),
        ),
      );

  SliverToBoxAdapter _card(Color bg, Color border, List<Widget> rows) =>
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
            ),
            child: Column(children: rows),
          ),
        ),
      );

  Widget _divider(Color color) =>
      Divider(height: 1, color: color, indent: 16, endIndent: 16);

  Widget _iconBox(IconData icon, Color accent) => Container(
    width: 36, height: 36,
    decoration: BoxDecoration(
      color: accent.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: accent, size: 18),
  );

  Widget _backBtn(bool isDark) => GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(Icons.arrow_back_rounded,
          color: isDark ? Colors.white : Colors.black87, size: 20),
    ),
  );

  Widget _saveBtn(Color accent) => GestureDetector(
    onTap: _save,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [accent, accent.withOpacity(0.75)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: accent.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(_saved ? Icons.check_rounded : Icons.save_rounded,
            color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(_saved ? 'Saved!' : 'Save',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13, fontWeight: FontWeight.w700)),
      ]),
    ),
  );
}