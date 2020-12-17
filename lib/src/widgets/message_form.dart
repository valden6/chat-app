import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {

  final ValueChanged<String> onSubmit;

  MessageForm({this.onSubmit});

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {

  final _textController = TextEditingController();
  String _messageWritten = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              minLines: 1,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  _messageWritten = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none
                )
              )
            )
          ),
          IconButton(
            onPressed: () {
              if(_messageWritten == null || _messageWritten.isEmpty)
                return null;
              else {
                widget.onSubmit(_messageWritten);
                _textController.clear();
                _messageWritten = "";
                setState(() {});
              }
            },
            padding: EdgeInsets.symmetric(horizontal: 15),
            color: _messageWritten == null || _messageWritten.isEmpty
              ? Colors.blueGrey
              : Theme.of(context).primaryColor,
            icon: Icon(Icons.send)
          )
        ]
      )
    );
  }
}