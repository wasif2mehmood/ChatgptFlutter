import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chatgptapp/chat_window.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [];
  late OpenAI? openAI;
  StreamSubscription? subscription;

  @override
void initState() {
  super.initState();
  initOpenAI();
}

Future<void> initOpenAI() async {
  await dotenv.load(fileName: ".env");
  openAI = OpenAI.instance.build(
    token: dotenv.env['OPENAI_API_KEY'],
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5))
  );
}

  @override
  void dispose() {
    super.dispose();
  }

  void sendMessage() async {
    try {
      if (_controller.text.isEmpty) return;
      setState(() {
        messages.add(
          Message(
            text: _controller.text,
            sender: "user",
          ),
        );
      });

      final request = ChatCompleteText(messages: [
        Messages(
            role: Role.user,
            content: _controller.text,
            name: "get_current_weather")
      ], maxToken: 200, model: GptTurbo0631Model());

      ChatCTResponse? response =
          await openAI?.onChatCompletion(request: request);
      if (response != null) {
        setState(() {
          messages.add(
            Message(
              text: response.choices?.first?.message?.content ?? '',
              sender: "bot",
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        messages.add(
          Message(
            text: e.toString(),
            sender: "bot",
          ),
        );
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Your text box and other input widgets
                  TextField(
                    controller: _controller,
                    onSubmitted: (value) => sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),

                  // Add other input widgets here if needed
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
