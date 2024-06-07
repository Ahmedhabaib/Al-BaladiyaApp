import 'package:flutter/material.dart';
import 'package:albaladiya/chatroom.dart';
import 'package:uuid/uuid.dart';

class UserIdPage extends StatefulWidget {
  @override
  _UserIdPageState createState() => _UserIdPageState();
}

class _UserIdPageState extends State<UserIdPage> {
  final TextEditingController _userIdController = TextEditingController();
  final _uuid = Uuid();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(userId: _userIdController.text),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('New User'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(userId: _uuid.v4()),
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