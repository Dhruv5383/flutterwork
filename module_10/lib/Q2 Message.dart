// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Message {
//   final String id;
//   final String senderId;
//   final String senderName;
//   final String senderEmail;
//   final String text;
//   final DateTime timestamp;
//   final String roomId;
//
//   Message({
//     required this.id,
//     required this.senderId,
//     required this.senderName,
//     required this.senderEmail,
//     required this.text,
//     required this.timestamp,
//     required this.roomId,
//   });
//
//   factory Message.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Message(
//       id: doc.id,
//       senderId: data['senderId'] ?? '',
//       senderName: data['senderName'] ?? 'Unknown',
//       senderEmail: data['senderEmail'] ?? '',
//       text: data['text'] ?? '',
//       timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       roomId: data['roomId'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'senderName': senderName,
//       'senderEmail': senderEmail,
//       'text': text,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'roomId': roomId,
//     };
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String text;
  final DateTime timestamp;
  final String roomId;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    required this.text,
    required this.timestamp,
    required this.roomId,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? 'Unknown',
      senderEmail: data['senderEmail'] ?? '',
      text: data['text'] ?? '',
      timestamp: _toDate(data['timestamp']) ?? DateTime.now(),
      roomId: data['roomId'] ?? '',
    );
  }

  /// Safely converts a Firestore field to DateTime.
  /// Handles Timestamp, String, and null without throwing.
  static DateTime _toDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
      'roomId': roomId,
    };
  }
}