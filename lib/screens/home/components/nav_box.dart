import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/authentication/professional_help_auth.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/community/chats_page.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/notes/note_page.dart';
import '../../../shared/loading.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/constants.dart';
import 'package:get/get.dart';

class NavBox extends StatefulWidget {
  const NavBox({super.key});

  @override
  State<NavBox> createState() => _NavBoxState();
}

class _NavBoxState extends State<NavBox> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: (Colors.grey[400])!,
            blurRadius: 10,
            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // FittedBox(
          //   child: GestureDetector(
          //     onTap: (() {}),
          //     child: Column(
          //       children: const [
          //         Icon(
          //           // CupertinoIcons.square_grid_2x2_fill,
          //           Icons.person_outline,
          //           color: Color(0xFF543E7A),
          //           size: 30,
          //         ),
          //         SizedBox(
          //           height: 2,
          //         ),
          //         Text(
          //           'Therapists',
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          FittedBox(
            child: GestureDetector(
              onTap: (() {
                Get.to(() => NotePage());
              }),
              child: Column(
                children: const [
                  Icon(
                    Ionicons.pencil_outline,
                    color: Color(0xFF543E7A),
                    size: 30,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Notes',
                  ),
                ],
              ),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfessionalHelpAuth(),
                  ),
                );
              }),
              child: Column(
                children: const [
                  Icon(
                    Ionicons.heart_outline,
                    color: Color(0xFF543E7A),
                    size: 30,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Resources',
                  ),
                ],
              ),
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: (() {
                Get.to(() => ChatsPage());
              }),
              child: Column(
                children: const [
                  Icon(
                    Ionicons.chatbubble_ellipses_outline,
                    color: Color(0xFF543E7A),
                    size: 30,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Community',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
