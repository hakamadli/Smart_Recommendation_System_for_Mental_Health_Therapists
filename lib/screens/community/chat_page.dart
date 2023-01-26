import 'package:smart_recommendation_system_for_mental_health_patients/utils/constants.dart';

import '../../models/therapist.dart';
import '../../models/user.dart' as u;
import 'widget/messages_widget.dart';
import 'widget/new_message_widget.dart';
import 'widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final u.User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: myDarkPurple,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(
                name: widget.user.name,
                user: widget.user,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: MessagesWidget(uid: widget.user.uid),
                ),
              ),
              NewMessageWidget(uid: widget.user.uid)
            ],
          ),
        ),
      );
}
