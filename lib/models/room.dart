class Room {
  final String id;
  final String name;
  final DateTime createdAt;

  Room({required this.id, required this.name, required this.createdAt});

  factory Room.fromMap(Map<String, dynamic> data, String id) {
    return Room(
      id: id,
      name: data['name'] ?? '',
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'createdAt': createdAt};
  }
}
