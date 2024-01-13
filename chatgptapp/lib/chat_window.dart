import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final String sender;

  const Message({
    required this.text,
    required this.sender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            sender == "user" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (sender != "user")
            const Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7, // Set a maximum width for the container
            ),
            margin: const EdgeInsets.only(left: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: sender == "user" ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          if (sender == "user")
            const Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
