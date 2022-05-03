import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  var text;
  var isSender;

   Chat(this.text, this.isSender,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  BubbleSpecialOne(
        text: text,
        isSender: isSender,
        color: Colors.purple.shade100,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.purple,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
