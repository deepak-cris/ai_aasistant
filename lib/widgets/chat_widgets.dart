import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/services/assetmanager.dart';
import 'package:ai_assistant/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.index});
  final String msg;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: index == 0 ? cardColor : scafoldbackgroundcolor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            index == 0 ? AssetsManager.personImage : AssetsManager.openaiImage,
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: TextWidget(label: msg, fontsize: 16))
        ]),
      ),
    );
  }
}
