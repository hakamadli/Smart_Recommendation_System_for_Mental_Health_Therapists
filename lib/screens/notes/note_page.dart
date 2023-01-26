import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/notes/components/note_editor.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/notes/components/note_reader.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/notes/widgets/note_card.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/shared/loading.dart';

import '../../authentication/login_auth.dart';
import '../../shared/resources/styles_manager.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final noteStream = FirebaseFirestore.instance
      .collection('therapist_notes')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   elevation: 0.0,
        //   title: Text("Notes"),
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        // ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: myMediumPurple,
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => const NoteEditorPage());
          },
          label: const Text("Add Note"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your recent notes",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Lato-Bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginAuthPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.home,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: noteStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "An error occured!",
                        style: getRegularStyle(color: myRedAccent),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loading();
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No recent notes",
                        style: getRegularStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    children: snapshot.data!.docs
                        .map((note) => noteCard(
                              () {
                                Get.to(() => NoteReaderPage(note));
                              },
                              note,
                            ))
                        .toList(),
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
