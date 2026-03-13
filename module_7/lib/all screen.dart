// import 'package:flutter/material.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Bottom Nav Demo',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: const Color(0xFF6C63FF),
// //           brightness: Brightness.dark,
// //         ),
// //         useMaterial3: true,
// //         fontFamily: 'SF Pro Display',
// //       ),
// //       home: const MainScreen(),
// //     );
// //   }
// // }
//
// // ──────────────────────────────────────────────
// //  MAIN SCREEN — holds the nav bar + pages
// // ──────────────────────────────────────────────
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
//   int _currentIndex = 0;
//
//   // One AnimationController per tab for the icon bounce effect
//   late final List<AnimationController> _iconControllers;
//   late final List<Animation<double>> _iconScales;
//
//   final List<Widget> _pages = const [
//     HomePage(),
//     ExplorePageWidget(),
//     NotificationsPage(),
//     ProfilePage(),
//     SettingsPage(),
//   ];
//
//   final List<_NavItem> _navItems = const [
//     _NavItem(icon: Icons.home_rounded, activeIcon: Icons.home, label: 'Home'),
//     _NavItem(icon: Icons.explore_outlined, activeIcon: Icons.explore, label: 'Explore'),
//     _NavItem(icon: Icons.notifications_outlined, activeIcon: Icons.notifications, label: 'Alerts', badge: 3),
//     _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
//     _NavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings'),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _iconControllers = List.generate(
//       _navItems.length,
//           (_) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 300),
//       ),
//     );
//     _iconScales = _iconControllers
//         .map((c) => TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 50),
//       TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 50),
//     ]).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut)))
//         .toList();
//
//     // Trigger initial animation for index 0
//     _iconControllers[0].forward();
//   }
//
//   @override
//   void dispose() {
//     for (final c in _iconControllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onTap(int index) {
//     if (index == _currentIndex) return;
//     setState(() => _currentIndex = index);
//     _iconControllers[index]
//       ..reset()
//       ..forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0F),
//       // Use IndexedStack so pages keep their scroll position
//       body: IndexedStack(index: _currentIndex, children: _pages),
//       bottomNavigationBar: _buildNavBar(),
//     );
//   }
//
//   Widget _buildNavBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF111114),
//         border: Border(
//           top: BorderSide(color: Colors.white.withOpacity(0.07), width: 1),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.5),
//             blurRadius: 24,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(_navItems.length, (i) {
//               final item = _navItems[i];
//               final isActive = i == _currentIndex;
//               return _NavButton(
//                 item: item,
//                 isActive: isActive,
//                 scaleAnimation: _iconScales[i],
//                 onTap: () => _onTap(i),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ──────────────────────────────────────────────
// //  NAV BUTTON WIDGET
// // ──────────────────────────────────────────────
// class _NavButton extends StatelessWidget {
//   const _NavButton({
//     required this.item,
//     required this.isActive,
//     required this.scaleAnimation,
//     required this.onTap,
//   });
//
//   final _NavItem item;
//   final bool isActive;
//   final Animation<double> scaleAnimation;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final activeColor = const Color(0xFFF5F5F5);
//     final inactiveColor = const Color(0xFF3A3A40);
//
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: isActive ? Colors.white.withOpacity(0.06) : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Icon with optional badge
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 ScaleTransition(
//                   scale: scaleAnimation,
//                   child: Icon(
//                     isActive ? item.activeIcon : item.icon,
//                     color: isActive ? activeColor : inactiveColor,
//                     size: 24,
//                   ),
//                 ),
//                 if (item.badge != null && !isActive)
//                   Positioned(
//                     top: -4,
//                     right: -8,
//                     child: Container(
//                       width: 16,
//                       height: 16,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFF4757),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: const Color(0xFF111114), width: 2),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '${item.badge}',
//                           style: const TextStyle(
//                             fontSize: 8,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             // Label
//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 200),
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//                 color: isActive ? activeColor : inactiveColor,
//               ),
//               child: Text(item.label.toUpperCase()),
//             ),
//             // Active indicator dot
//             const SizedBox(height: 4),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               curve: Curves.easeOut,
//               width: isActive ? 20 : 0,
//               height: 2,
//               decoration: BoxDecoration(
//                 color: activeColor,
//                 borderRadius: BorderRadius.circular(1),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ──────────────────────────────────────────────
// //  DATA MODEL
// // ──────────────────────────────────────────────
// class _NavItem {
//   const _NavItem({
//     required this.icon,
//     required this.activeIcon,
//     required this.label,
//     this.badge,
//   });
//
//   final IconData icon;
//   final IconData activeIcon;
//   final String label;
//   final int? badge;
// }
//
// // ──────────────────────────────────────────────
// //  PAGE WIDGETS
// // ──────────────────────────────────────────────
//
// // Shared card widget
// class _InfoCard extends StatelessWidget {
//   const _InfoCard({required this.title, required this.value, required this.color});
//
//   final String title;
//   final String value;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//       decoration: BoxDecoration(
//         color: const Color(0xFF18181B),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.07)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.0,
//                   color: Colors.white.withOpacity(0.35),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFFE8E8E8),
//                   letterSpacing: -0.5,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Shared page scaffold
// class _PageShell extends StatelessWidget {
//   const _PageShell({required this.heading, required this.subtitle, required this.children, this.prefix});
//
//   final String heading;
//   final String subtitle;
//   final List<Widget> children;
//   final Widget? prefix;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (prefix != null) ...[prefix!, const SizedBox(height: 16)],
//             Text(
//               heading,
//               style: const TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w800,
//                 color: Color(0xFFF5F5F5),
//                 letterSpacing: -0.8,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.white.withOpacity(0.3),
//               ),
//             ),
//             const SizedBox(height: 28),
//             Expanded(
//               child: ListView(
//                 physics: const BouncingScrollPhysics(),
//                 children: children,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // HOME PAGE
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _PageShell(
//       heading: 'Welcome Back',
//       subtitle: "Here's what's happening today.",
//       children: const [
//         _InfoCard(title: 'Daily Summary', value: '12 updates', color: Color(0xFFF4A261)),
//         _InfoCard(title: 'New Messages', value: '4 unread', color: Color(0xFFE76F51)),
//         _InfoCard(title: 'Tasks Done', value: '7 / 10', color: Color(0xFF2A9D8F)),
//       ],
//     );
//   }
// }
//
// // EXPLORE PAGE
// class ExplorePageWidget extends StatelessWidget {
//   const ExplorePageWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _PageShell(
//       heading: 'Explore',
//       subtitle: 'Discover something new.',
//       children: const [
//         _InfoCard(title: 'Trending', value: '#design', color: Color(0xFF457B9D)),
//         _InfoCard(title: 'Popular', value: 'Motion UI', color: Color(0xFF1D3557)),
//         _InfoCard(title: 'New Arrivals', value: '23 items', color: Color(0xFFA8DADC)),
//       ],
//     );
//   }
// }
//
// // NOTIFICATIONS PAGE
// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _PageShell(
//       heading: 'Notifications',
//       subtitle: 'You have 3 new alerts.',
//       children: const [
//         _InfoCard(title: 'System', value: 'Update ready', color: Color(0xFF6A4C93)),
//         _InfoCard(title: 'Reminder', value: 'Meeting at 3pm', color: Color(0xFF8AC4FF)),
//         _InfoCard(title: 'Alert', value: 'Low storage', color: Color(0xFFFF595E)),
//       ],
//     );
//   }
// }
//
// // PROFILE PAGE
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _PageShell(
//       heading: 'Your Profile',
//       subtitle: 'Manage your account.',
//       prefix: Container(
//         width: 52,
//         height: 52,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFF72585), Color(0xFF7209B7)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: const Center(
//           child: Text('JD',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               )),
//         ),
//       ),
//       children: const [
//         _InfoCard(title: 'Followers', value: '1,204', color: Color(0xFFF72585)),
//         _InfoCard(title: 'Following', value: '340', color: Color(0xFF7209B7)),
//         _InfoCard(title: 'Posts', value: '89', color: Color(0xFF3A0CA3)),
//       ],
//     );
//   }
// }
//
// // SETTINGS PAGE
// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return _PageShell(
//       heading: 'Settings',
//       subtitle: 'Customize your experience.',
//       children: const [
//         _InfoCard(title: 'Theme', value: 'Dark Mode', color: Color(0xFF444444)),
//         _InfoCard(title: 'Privacy', value: 'Public', color: Color(0xFF556B2F)),
//         _InfoCard(title: 'Language', value: 'English', color: Color(0xFF8B6914)),
//       ],
//     );
//   }
// }

















import 'package:flutter/material.dart';

import 'all movie screen.dart';
import 'all news screen.dart';
import 'all weather screen.dart';
//import 'weather_screen.dart';
//import 'news_screen.dart';
//import 'movie_screen.dart';

// void main() => runApp(const TriApp());
//
// class TriApp extends StatelessWidget {
//   const TriApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AppSuite',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF08080F),
//         fontFamily: 'Georgia',
//       ),
//       home: const MainShell(),
//     );
//   }
// }

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late final AnimationController _animCtrl;
  late final List<AnimationController> _iconCtrl;

  static const _tabs = [
    _Tab('Weather', Icons.wb_sunny_outlined, Icons.wb_sunny_rounded,
        Color(0xFF56AEFF), Color(0xFF1A6DCC)),
    _Tab('News', Icons.newspaper_outlined, Icons.newspaper_rounded,
        Color(0xFFE8C56D), Color(0xFFB8943D)),
    _Tab('Movies', Icons.movie_outlined, Icons.movie_rounded,
        Color(0xFFE55050), Color(0xFFFF6B35)),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onTap(int i) {
    if (i == _index) return;
    setState(() => _index = i);
    _animCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08080F),
      body: IndexedStack(
        index: _index,
        children: const [
          AllWeatherScreen(),
          NewsScreen(),
          MovieScreen(),
        ],
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E0E18),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.06)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (i) {
              final tab = _tabs[i];
              final isActive = i == _index;
              return GestureDetector(
                onTap: () => _onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                      horizontal: isActive ? 20 : 14, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? LinearGradient(
                      colors: [
                        tab.color1.withOpacity(0.2),
                        tab.color2.withOpacity(0.1),
                      ],
                    )
                        : null,
                    borderRadius: BorderRadius.circular(18),
                    border: isActive
                        ? Border.all(color: tab.color1.withOpacity(0.3))
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? tab.activeIcon : tab.icon,
                        color: isActive
                            ? tab.color1
                            : Colors.white.withOpacity(0.3),
                        size: 20,
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        Text(
                          tab.label,
                          style: TextStyle(
                            color: tab.color1,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _Tab {
  const _Tab(this.label, this.icon, this.activeIcon, this.color1, this.color2);
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Color color1;
  final Color color2;
}