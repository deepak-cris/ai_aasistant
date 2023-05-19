import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/services/assetmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ai_assistant/services/api_services.dart';

import '../widgets/chat_widgets.dart';
import '../widgets/dropdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController? chattextEditingController;
  @override
  void initState() {
    chattextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    chattextEditingController!.dispose();
    super.dispose();
  }

  bool isTyping = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiImage),
          ),
          title: const Text('ChatGPT'),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Material(
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Select Model :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Flexible(child: CustomDropDown()),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                        msg: chatMessages[index]['msg'].toString(),
                        index: int.parse(
                            chatMessages[index]['chatindex'].toString()));
                  },
                ),
              ),
              if (isTyping) ...[
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                )
              ],
              Material(
                color: scafoldbackgroundcolor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) {},
                          controller: chattextEditingController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'How can i help you?',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.send, color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
