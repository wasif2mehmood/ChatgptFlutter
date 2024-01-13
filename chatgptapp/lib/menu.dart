import 'package:flutter/material.dart';
import 'package:chatgptapp/chat.dart';

class menu
 extends StatefulWidget {
  const menu
  ({Key? key}) : super(key: key);

  @override
  State<menu
  > createState() => _HomeScreenState();
}

class _HomeScreenState extends State<menu
> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EAF6),
      appBar: AppBar(
          backgroundColor: const Color(0xff3F51B5),
          title: const Center(
            child: Text(
              "CHAT APP",
              style: TextStyle(color: Colors.white),
            ),
          ),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const chat(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3F51B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('Chat',
                  style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}