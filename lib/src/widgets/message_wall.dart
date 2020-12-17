import 'package:chat_app/src/widgets/chat_message.dart';
import 'package:chat_app/src/widgets/chat_message_other.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageWall extends StatelessWidget {

  final List<QueryDocumentSnapshot> messages;
  final ValueChanged<String> onDelete;

  MessageWall({this.messages,this.onDelete});

  bool shouldDisplayAuthor(int index) {
    if(index == 0 )
      return true;

    final String previousId = messages[index - 1].data()["author_id"];
    final String authorId = messages[index].data()["author_id"];
    return authorId != previousId;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {

        final data = messages[index].data();
        final user = FirebaseAuth.instance.currentUser;

        if (user != null && user.uid == data['author_id']) {
          return Dismissible(
            onDismissed: (_) {
              onDelete(messages[index].id);
            },
            key: ValueKey(data['timestamp']),
            child: ChatMessage(
              index: index,
              data: data,
            ),
          );
        }
        
        return ChatMessageOther(
          index: index,
          data: data,
          showAvatar: shouldDisplayAuthor(index),
        );

      }
    );
  }
}