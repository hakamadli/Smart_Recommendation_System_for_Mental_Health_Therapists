import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/utils/constants.dart';
import '../../../shared/resources/styles_manager.dart' as AppStyle;

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  DateTime date = DateTime.now();
  String dateInString = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        title: const Text(
          "New note",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FirebaseFirestore.instance.collection('therapist_notes').add({
            'uid': user.uid,
            'note_title': _titleController.text,
            'creation_date': date,
            'note_content': _mainController.text,
            'color_id': color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print(error));
        },
        label: const Text("Save"),
        backgroundColor: myMediumPurple,
        icon: const Icon(Icons.done),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note title',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              DateFormat.yMMMMEEEEd().format(date),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note content',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
