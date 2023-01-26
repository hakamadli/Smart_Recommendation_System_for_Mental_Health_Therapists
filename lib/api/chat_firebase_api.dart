import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data.dart';
import '../models/message.dart';
import '../models/user.dart' as u;
import '../utils/utils.dart';

class FirebaseApi {
  final user = FirebaseAuth.instance.currentUser!;
  static Stream<List<u.User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(u.UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(u.User.fromJson));

  static Future uploadMessage(String uid, String message, String ownerID) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$uid/messages');
    final refMessages2 =
        FirebaseFirestore.instance.collection('chats/$ownerID/messages');

    final newMessage = Message(
      idUser: Data.myId,
      username: Data.myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());
    await refMessages2.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers.doc(uid).update({u.UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String uid) =>
      FirebaseFirestore.instance
          .collection('chats/$uid/messages')
          // .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<u.User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(uid: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
