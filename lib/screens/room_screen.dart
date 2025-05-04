import 'package:desafio_firebase_flutter/providers/chat_provider.dart';
import 'package:desafio_firebase_flutter/screens/chat_screen.dart';
import 'package:desafio_firebase_flutter/widgets/room_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salas de Chat')),
      body: StreamBuilder(
        stream: Provider.of<ChatProvider>(context).getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final rooms = snapshot.data ?? [];

          if (rooms.isEmpty) {
            return const Center(child: Text('Nenhuma sala disponível'));
          }

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder:
                (context, index) => RoomItem(
                  room: rooms[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(room: rooms[index]),
                      ),
                    );
                  },
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRoomDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddRoomDialog(BuildContext context) {
    final roomNameController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Criar nova sala'),
            content: TextField(
              controller: roomNameController,
              decoration: const InputDecoration(labelText: 'Nome da sala'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (roomNameController.text.isNotEmpty) {
                    Provider.of<ChatProvider>(
                      context,
                      listen: false,
                    ).addRoom(roomNameController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Criar'),
              ),
            ],
          ),
    );
  }
}
