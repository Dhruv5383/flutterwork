// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ChatRoom {
//   final String id;
//   final String name;
//   final String description;
//   final String createdBy;
//   final DateTime createdAt;
//   final String? lastMessage;
//   final DateTime? lastMessageAt;
//
//   ChatRoom({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdBy,
//     required this.createdAt,
//     this.lastMessage,
//     this.lastMessageAt,
//   });
//
//   factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return ChatRoom(
//       id: doc.id,
//       name: data['name'] ?? '',
//       description: data['description'] ?? '',
//       createdBy: data['createdBy'] ?? '',
//       createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       lastMessage: data['lastMessage'],
//       lastMessageAt: (data['lastMessageAt'] as Timestamp?)?.toDate(),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'createdBy': createdBy,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'lastMessage': lastMessage,
//       'lastMessageAt':
//       lastMessageAt != null ? Timestamp.fromDate(lastMessageAt!) : null,
//     };
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final String? lastMessage;
  final DateTime? lastMessageAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    this.lastMessage,
    this.lastMessageAt,
  });

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: _toDate(data['createdAt']) ?? DateTime.now(),
      lastMessage: data['lastMessage'] as String?,
      lastMessageAt: _toDate(data['lastMessageAt']),
    );
  }

  /// Safely converts a Firestore field to DateTime.
  /// Handles Timestamp, String, and null without throwing.
  static DateTime? _toDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      return DateTime.tryParse(value); // gracefully handles "" → null
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastMessage': lastMessage,
      'lastMessageAt':
      lastMessageAt != null ? Timestamp.fromDate(lastMessageAt!) : null,
    };
  }
}