import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final _firestore = FirebaseFirestore.instance;

class ChatRoom extends StatefulWidget {
  final String userId;
  const ChatRoom({required this.userId, Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late User anonymousUser;
  late String userId;
  String? messageText;

  void _logout() {
    // Add logout logic here
    print('Logout pressed');
  }
  @override
  void initState() {
    super.initState();
    userId = widget.userId;  // Generate a unique ID for the user
  }
  @override
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
        final currentuser = userId;

        if (currentuser == userId) {
          print('This is me!');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            Image.asset('images/albaladiya.png', height: 25),
            SizedBox(width: 10),
            Text('MessageMe', style: TextStyle(color: Colors.white),),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(currentUserId: userId),


            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.blue[800]!,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        _controller.text = file.name; // Update TextField with file name

                        print(file.name);
                        print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        print(file.path);
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': userId,
                        'time': FieldValue.serverTimestamp(),
                        'userID': userId,
                      });
                      _messageController.clear(); // Clear the message field after sending
                      print('Send button pressed');
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({required this.currentUserId, Key? key}) : super(key: key);

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue[800],
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<MessageLine> messageWidgets = [];
        for (var message in messages) {
          var data = message.data() as Map<String, dynamic>;  // Cast to Map<String, dynamic>

          // Safely try to fetch 'text' and 'sender', default to an empty string if not found
          final messageText = data.containsKey('text') ? data['text'] : 'No message';
          final messageSender = data.containsKey('sender') ? data['sender'] : 'Anonymous';

          final messageWidget = MessageLine(sender: messageSender, text: messageText, isMe: currentUserId == messageSender);
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.text , this.sender, required this.isMe , Key?key}) : super(key:key);

  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text('$sender:', style: TextStyle(fontSize: 15, color: Colors.black45),),
          Material(
            elevation: 5,
            borderRadius: isMe ?BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ): BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe? Colors.blue[800]: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('$text', style: TextStyle(fontSize: 20, color: Colors.white),),
              ),),
        ],
      ),
    );
  }
}