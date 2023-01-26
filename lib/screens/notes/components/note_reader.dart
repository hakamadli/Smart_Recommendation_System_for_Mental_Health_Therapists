import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/utils/constants.dart';
import '../../../shared/resources/font_manager.dart';
import '../../../shared/resources/styles_manager.dart' as AppStyle;
import '../../../shared/resources/styles_manager.dart';
import '../../../shared/resources/values_manager.dart';
import '../../../shared/snackbar.dart';

class NoteReaderPage extends StatefulWidget {
  const NoteReaderPage(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<NoteReaderPage> createState() => _NoteReaderPageState();
}

class _NoteReaderPageState extends State<NoteReaderPage> {
  void showDeleteOptions(DocumentSnapshot note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Do you want to delete ${note['note_title']}?',
          style: const TextStyle(
            color: myDarkPurple,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('therapist_notes')
                    .doc(note.id)
                    .delete();
                showSnackBar('Note deleted successfully!', context);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.delete_forever,
                color: myDarkPurple,
                size: AppSize.s25,
              ),
              label: Text(
                'Yes',
                style: getRegularStyle(
                  color: myDarkPurple,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
                color: myRed,
                size: AppSize.s25,
              ),
              label: Text(
                'Cancel',
                style: getRegularStyle(
                  color: myDarkPurple,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showDeleteOptions(widget.doc);
        //     },
        //     icon: const Icon(
        //       Icons.delete_forever,
        //       color: myRed,
        //     ),
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDeleteOptions(widget.doc);
        },
        child: Icon(Icons.delete_forever),
        backgroundColor: myRedAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              DateFormat.yMMMMEEEEd()
                  .format(widget.doc["creation_date"].toDate()),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
