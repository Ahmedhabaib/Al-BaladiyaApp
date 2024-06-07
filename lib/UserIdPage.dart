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
  final _uuid = Uuid();
  final _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  Future<bool> userExists(String userId) async {
    final userSnapshot = await _firestore.collection('users').doc(userId).get();
    return userSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter User ID'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'Enter your old User ID',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Start Discussion'),
              onPressed: () async {
                String userId = _userIdController.text;
                if (await userExists(userId)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(userId: userId),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User ID does not exist')),
                  );
                }
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('New User'),
              onPressed: () {
                String newUserId = _uuid.v4();
                _firestore.collection('users').doc(newUserId).set({});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(userId: newUserId),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
