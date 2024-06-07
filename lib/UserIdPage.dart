import 'package:flutter/material.dart';
import 'package:albaladiya/chatroom.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserIdPage extends StatefulWidget {
  @override
  _UserIdPageState createState() => _UserIdPageState();
}

class _UserIdPageState extends State<UserIdPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController(); // Ajouter un nouveau TextEditingController pour roomId
  final _uuid = Uuid();
  final _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _userIdController.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  Future<bool> roomExists(String roomId) async {
    final roomSnapshot = await _firestore.collection('conversations').doc(roomId).get();
    return roomSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter User ID and Room ID'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'Enter your User ID',
              ),
            ),
            TextField(
              controller: _roomIdController,
              decoration: InputDecoration(
                labelText: 'Enter your Room ID',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Suivi de réclamation'),
              onPressed: () async {
                String roomId = _roomIdController.text;
                String userId = _userIdController.text; // Utilisez l'ID de l'utilisateur entré
                if (await roomExists(roomId)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(userId: userId, roomId: roomId), // Pass userId and roomId to ChatRoom
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Room ID does not exist')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
