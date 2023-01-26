import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/utils/constants.dart';
import '../../../models/therapist.dart';
import '../../../models/user.dart' as u;
import '../chat_page.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<u.User> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: myMediumPurple,
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(user.name),
            ),
          );
        },
        itemCount: users.length,
      );
}
