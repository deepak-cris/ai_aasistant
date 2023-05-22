import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/services/assetmanager.dart';
import 'package:ai_assistant/widgets/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {required Key key,
      required this.msg,
      required this.index,
      required this.textAnimationFlag})
      : super(key: key);
  final String msg;
  final int index;
  final bool textAnimationFlag;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
    key:
    key;
    return Row(
      mainAxisAlignment:
          index == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index == 0
            ? const SizedBox.shrink()
            : CircleAvatar(
                radius: 14,
                backgroundColor: Colors.teal,
                child: Image.asset(
                  AssetsManager.openaiImage,
                  height: 20,
                  width: 20,
                ),
              ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            //conditional todo
            child: Material(
              color:
                  index == 0 ? scafoldbackgroundcolor : scafoldbackgroundcolor,
              elevation: 10,
              borderRadius: index == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))
                  : const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
              child: index == 0
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      child: TextWidget(label: msg, fontsize: 16))
                  : textAnimationFlag
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [TyperAnimatedText(msg)]),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(8),
                          child: TextWidget(label: msg, fontsize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
