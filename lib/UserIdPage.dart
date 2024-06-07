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
  final TextEditingController _roomIdController = TextEditingController();
  final _uuid = Uuid();
  final _firestore = FirebaseFirestore.instance;

  String generateId() {
    return _uuid.v4();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  Future<bool> roomExists(String roomId) async {
    try {
      final roomSnapshot = await _firestore.collection('conversations').doc(roomId).get();
      print('Room snapshot data: ${roomSnapshot.data()}'); // Print the snapshot data
      return roomSnapshot.exists;
    } catch (e) {
      print('Error checking room existence: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter User ID and Room ID'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _userIdController,
                      decoration: InputDecoration(
                        labelText: 'Enter your User ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _roomIdController,
                      decoration: InputDecoration(
                        labelText: 'Enter your Room ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      child: Text('Suivi de réclamation'),
                      onPressed: () async {
                        String roomId = _roomIdController.text;
                        String userId = _userIdController.text;
                        print('Checking room existence for Room ID: $roomId'); // Print roomId to debug
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
            ),
            Divider(),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text('New Room'),
                      onPressed: () async {
                        String newRoomId = generateId();
                        String newUserId = generateId();

                        // Create a new room in the 'conversations' collection
                        await _firestore.collection('conversations').doc(newRoomId).set({
                          // Add any initial data for the room here
                        });

                        // Create a new user in the 'users' collection
                        await _firestore.collection('users').doc(newUserId).set({
                          // Add any initial data for the user here
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(userId: newUserId, roomId: newRoomId),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
