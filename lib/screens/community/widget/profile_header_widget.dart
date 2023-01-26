import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/user.dart' as u;
import 'package:smart_recommendation_system_for_mental_health_patients/utils/constants.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final String name;
  final u.User user;

  const ProfileHeaderWidget({
    required this.name,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  String userName = '';
  int age = 0;
  DateTime accountCreated = DateTime.now();
  final usersRef = FirebaseFirestore.instance.collection('users');

  Future getUserDetails() async {
    await usersRef.doc(widget.user.uid).get().then((snapshot) => {
          setState(() {
            userName = snapshot.data()!['name'];
            age = snapshot.data()!['age'];
            accountCreated = snapshot.data()!['timestamp'].toDate();
          })
        });
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            "User's info",
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name: ",
                style: TextStyle(fontFamily: 'Lato'),
              ),
              Text(
                userName,
                style:
                    const TextStyle(fontFamily: 'Lato', color: myMediumPurple),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Age: ",
                style: TextStyle(fontFamily: 'Lato'),
              ),
              Text(
                "$age years old",
                style:
                    const TextStyle(fontFamily: 'Lato', color: myMediumPurple),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Account created: ",
                style: TextStyle(fontFamily: 'Lato'),
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(accountCreated).toString(),
                style:
                    const TextStyle(fontFamily: 'Lato', color: myMediumPurple),
                maxLines: 2,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: myDarkPurple),
                ))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 80,
        padding: const EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(color: Colors.white),
                Expanded(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getUserDetails();
                      },
                      child: buildIcon(Icons.person),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: myMediumPurple,
        ),
        child: Icon(icon, size: 30, color: Colors.white),
      );
}
