import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_firebase_flutter/models/message.dart';
import 'package:desafio_firebase_flutter/models/room.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Salas
  Stream<List<Room>> getRooms() {
    return _firestore
        .collection('rooms')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Room.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }

  Future<void> addRoom(String roomName) async {
    await _firestore.collection('rooms').add({
      'name': roomName,
      'createdAt': DateTime.now(),
    });
  }

  // Mensagens
  Stream<List<Message>> getMessages(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('sentAt', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Message.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String text,
    required String senderName,
  }) async {
    await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .add({
          'text': text,
          'senderId': senderId,
          'senderName': senderName,
          'sentAt': DateTime.now(),
        });
  }
}
