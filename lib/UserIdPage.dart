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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50), // Add some space at the top
            Container(
              height: 180,
              child: Image.asset('images/albaladiya.png'),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _userIdController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your User ID',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _roomIdController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your Room ID',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[900], // background
                ),
                child: Text(
                  'Suivi de réclamation',
                  style: TextStyle(color: Colors.white), // Set the text color here
                ),
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800], // background
              ),
              child: Text(
                'Nouvelle réclamation',
                style: TextStyle(color: Colors.white), // Set the text color here
              ),
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
            SizedBox(height: 50), // Add some space at the bottom
          ],
        ),
      ),
    );
  }
}
