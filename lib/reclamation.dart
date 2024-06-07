import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(ReclamationApp());
}

class ReclamationApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Réclamation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReclamationPage(),
    );
  }
}

class ReclamationPage extends StatefulWidget {
  @override
  _ReclamationPageState createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  List<Widget> _attachments = [];
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;

  void _addAttachment() {
    setState(() {
      if (_attachments.length < 10) {
        _attachments.add(Text('Attachment ${_attachments.length + 1}'));
      }
    });
  }

  void pickFile(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileName = result.files.first.name;
          pickedFile = result.files.first;
          // Do not convert the path to a string, as it's already a string
          var fileToDisplay = File(pickedFile!.path!);
        });

        print('File name: $_fileName');
      } else {
        print('Aucun fichier sélectionné.');
      }
    } catch (e) {
      print('Erreur lors de la récupération du fichier: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la récupération du fichier.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faire une Réclamation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Objet',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Corps de la Réclamation',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pièces jointes:'),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () => pickFile(context),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _attachments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: _attachments[index],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Envoyer la réclamation
                // Implémentez votre logique d'envoi ici
              },
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
