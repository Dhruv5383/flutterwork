import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../models/message.dart';
//import '../models/chat_room.dart';
import 'Q2 Chat room.dart';
import 'Q2 Message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  // ── Chat Rooms ──────────────────────────────────────────────────

  /// Stream all chat rooms ordered by last message
  Stream<List<ChatRoom>> getRooms() {
    return _firestore
        .collection('rooms')
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ChatRoom.fromFirestore).toList());
  }

  /// Create a new chat room
  Future<String> createRoom({
    required String name,
    required String description,
  }) async {
    final user = currentUser!;
    final docRef = await _firestore.collection('rooms').add({
      'name': name,
      'description': description,
      'createdBy': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': null,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // ── Messages ────────────────────────────────────────────────────

  /// Stream messages for a specific room
  Stream<List<Message>> getMessages(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map(Message.fromFirestore).toList());
  }

  /// Send a message to a room
  Future<void> sendMessage({
    required String roomId,
    required String text,
  }) async {
    final user = currentUser!;
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final batch = _firestore.batch();

    // Add the message document
    final msgRef = _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc();

    batch.set(msgRef, {
      'senderId': user.uid,
      'senderName': user.displayName ?? 'Anonymous',
      'senderEmail': user.email ?? '',
      'text': trimmed,
      'timestamp': FieldValue.serverTimestamp(),
      'roomId': roomId,
    });

    // Update room's lastMessage preview
    final roomRef = _firestore.collection('rooms').doc(roomId);
    batch.update(roomRef, {
      'lastMessage': trimmed.length > 60 ? '${trimmed.substring(0, 60)}…' : trimmed,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  /// Delete a message (only sender can delete)
  Future<void> deleteMessage({
    required String roomId,
    required String messageId,
  }) async {
    await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }
}