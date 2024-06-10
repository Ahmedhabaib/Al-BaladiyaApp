import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:albaladiya/chatroom.dart';

class ReclamationPage extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réclamations'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/albaladiya.png'),
            ),
            SizedBox(height: 50),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('conversations').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final conversations = snapshot.data!.docs;
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Conversation',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: conversations.asMap().entries.map((entry) {
                          int index = entry.key;
                          var conversation = entry.value;
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Conversation${index + 1}')),
                              DataCell(Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatRoom(
                                            userId: 'yourUserId', // Remplacez par votre userId
                                            roomId: conversation.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Open'),
                                  ),
                                  SizedBox(width: 10), // Add some space between the buttons
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _firestore.collection('conversations').doc(conversation.id).delete();
                                    },
                                    child: Text('Delete',style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red, // Set the color to red for delete button
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}