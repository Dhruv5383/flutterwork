// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// //import '../models/chat_room.dart';
// //import '../services/auth_service.dart';
// //import '../services/chat_service.dart';
// import 'Q2 Auth service.dart';
// import 'Q2 Chat room.dart';
// import 'Q2 Chat screen.dart';
// import 'Q2 Chat service.dart';
// //import 'chat_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _authService = AuthService();
//   final _chatService = ChatService();
//
//   void _showCreateRoomDialog() {
//     final nameCtrl = TextEditingController();
//     final descCtrl = TextEditingController();
//     final formKey = GlobalKey<FormState>();
//
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('New Chat Room'),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         content: Form(
//           key: formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: nameCtrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Room Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                     v == null || v.trim().isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: descCtrl,
//                 decoration: const InputDecoration(
//                   labelText: 'Description (optional)',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 2,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               if (!formKey.currentState!.validate()) return;
//               await _chatService.createRoom(
//                 name: nameCtrl.text.trim(),
//                 description: descCtrl.text.trim(),
//               );
//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: const Text('Create'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _confirmSignOut() {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Sign Out'),
//         content: const Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _authService.signOut();
//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text(
//               'Sign Out',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = _authService.currentUser;
//     final colors = Theme.of(context).colorScheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: colors.primary,
//         foregroundColor: Colors.white,
//         title: const Text(
//           'Chat Rooms',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: PopupMenuButton(
//               icon: CircleAvatar(
//                 backgroundColor: Colors.white.withOpacity(0.3),
//                 child: Text(
//                   (user?.displayName ?? 'U')[0].toUpperCase(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               itemBuilder: (_) => [
//                 PopupMenuItem(
//                   enabled: false,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user?.displayName ?? '',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         user?.email ?? '',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const PopupMenuDivider(),
//                 PopupMenuItem(
//                   onTap: _confirmSignOut,
//                   child: const Row(
//                     children: [
//                       Icon(Icons.logout, color: Colors.red),
//                       SizedBox(width: 8),
//                       Text('Sign Out'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: StreamBuilder<List<ChatRoom>>(
//         stream: _chatService.getRooms(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           final rooms = snapshot.data ?? [];
//
//           if (rooms.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.chat_bubble_outline,
//                     size: 80,
//                     color: colors.primary.withOpacity(0.4),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'No rooms yet',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Tap + to create one!',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           return ListView.separated(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             itemCount: rooms.length,
//             separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
//             itemBuilder: (context, i) {
//               final room = rooms[i];
//               return ListTile(
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 4,
//                 ),
//                 leading: CircleAvatar(
//                   backgroundColor: colors.primaryContainer,
//                   radius: 26,
//                   child: Text(
//                     room.name[0].toUpperCase(),
//                     style: TextStyle(
//                       color: colors.primary,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 title: Text(
//                   room.name,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (room.lastMessage != null)
//                       Text(
//                         room.lastMessage!,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(fontSize: 13),
//                       )
//                     else
//                       Text(
//                         room.description,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                         ),
//                       ),
//                   ],
//                 ),
//                 trailing: room.lastMessageAt != null
//                     ? Text(
//                         _formatTime(room.lastMessageAt!),
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                       )
//                     : null,
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ChatScreen(room: room)),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _showCreateRoomDialog,
//         icon: const Icon(Icons.add),
//         label: const Text('New Room'),
//       ),
//     );
//   }
//
//   String _formatTime(DateTime dt) {
//     final now = DateTime.now();
//     if (now.difference(dt).inDays == 0) {
//       return DateFormat.jm().format(dt);
//     } else if (now.difference(dt).inDays == 1) {
//       return 'Yesterday';
//     }
//     return DateFormat.MMMd().format(dt);
//   }
// }







import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import '../models/chat_room.dart';
//import '../services/auth_service.dart';
//import '../services/chat_service.dart';
import 'Q2 Auth service.dart';
import 'Q2 Chat room.dart';
import 'Q2 Chat screen.dart';
import 'Q2 Chat service.dart';
//import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  final _chatService = ChatService();

  // ── Create Room Dialog ───────────────────────────────────────────
  void _showCreateRoomDialog() {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        // FIX: StatefulBuilder so the loading spinner inside dialog works
        builder: (ctx, setDialogState) {
          bool isCreating = false;

          return AlertDialog(
            title: const Text('New Chat Room'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Room Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.meeting_room_outlined),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Room name is required'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: descCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  nameCtrl.dispose();
                  descCtrl.dispose();
                  Navigator.pop(ctx);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isCreating
                    ? null
                    : () async {
                  if (!formKey.currentState!.validate()) return;
                  setDialogState(() => isCreating = true);
                  try {
                    await _chatService.createRoom(
                      name: nameCtrl.text.trim(),
                      description: descCtrl.text.trim(),
                    );
                    nameCtrl.dispose();
                    descCtrl.dispose();
                    if (ctx.mounted) Navigator.pop(ctx);
                  } catch (e) {
                    setDialogState(() => isCreating = false);
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(
                          content: Text('Failed to create room: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: isCreating
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child:
                  CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Sign Out ─────────────────────────────────────────────────────
  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            // FIX: close dialog FIRST, then sign out to avoid
            // "looking up deactivated widget" errors
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await _authService.signOut();
                // AuthWrapper in main.dart auto-navigates to AuthScreen
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign out failed: $e')),
                  );
                }
              }
            },
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sign Out',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // FIX: read user inside build() so it stays fresh after auth changes
    final user = _authService.currentUser;
    final displayName = user?.displayName ?? 'User';
    final email = user?.email ?? '';
    // FIX: guard against empty displayName before indexing [0]
    final initial =
    displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        title: const Text('Chat Rooms',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            // FIX: typed as PopupMenuButton<String> to fix itemBuilder
            // type-inference issues that cause runtime errors
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'signout') _confirmSignOut();
              },
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.25),
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              itemBuilder: (_) => [
                PopupMenuItem<String>(
                  enabled: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'signout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20),
                      SizedBox(width: 10),
                      Text('Sign Out',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Room List ───────────────────────────────────────────────
      body: StreamBuilder<List<ChatRoom>>(
        stream: _chatService.getRooms(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // FIX: show a proper error UI instead of a raw Text widget
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Could not load rooms',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          final rooms = snapshot.data ?? [];

          // Empty state
          if (rooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline,
                      size: 80,
                      color: colors.primary.withOpacity(0.35)),
                  const SizedBox(height: 16),
                  const Text('No rooms yet',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('Tap  +  to create the first one!',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            // FIX: bottom padding so FAB doesn't cover the last item
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: rooms.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 1, indent: 72, endIndent: 16),
            itemBuilder: (context, i) {
              final room = rooms[i];

              // FIX: guard against empty room.name before indexing [0]
              final roomInitial = room.name.isNotEmpty
                  ? room.name[0].toUpperCase()
                  : '?';

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                leading: CircleAvatar(
                  backgroundColor: colors.primaryContainer,
                  radius: 26,
                  child: Text(
                    roomInitial,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                title: Text(room.name,
                    style:
                    const TextStyle(fontWeight: FontWeight.w600)),
                // FIX: replaced nested Column in subtitle with a plain Text.
                // A Column inside ListTile subtitle causes layout overflow errors.
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    room.lastMessage ?? room.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: room.lastMessage != null
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                ),
                trailing: room.lastMessageAt != null
                    ? Text(
                  _formatTime(room.lastMessageAt!),
                  style: const TextStyle(
                      fontSize: 11, color: Colors.grey),
                )
                    : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(room: room),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRoomDialog,
        icon: const Icon(Icons.add),
        label: const Text('New Room'),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    // FIX: compare calendar dates, not Duration.inDays, which gives wrong
    // results near midnight (e.g. 11:59 PM yesterday shows as "Today")
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(dt.year, dt.month, dt.day);

    if (msgDay == today) return DateFormat.jm().format(dt);
    if (msgDay == yesterday) return 'Yesterday';
    return DateFormat.MMMd().format(dt);
  }
}