import 'package:desafio_firebase_flutter/models/room.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomItem({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.chat_bubble, size: 36),
        title: Text(
          room.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Criada em ${_formatDate(room.createdAt)}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
