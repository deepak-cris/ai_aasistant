import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/services/assetmanager.dart';
import 'package:ai_assistant/widgets/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({required Key key, required this.msg, required this.index})
      : super(key: key);
  final String msg;
  final int index;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
    key:
    Key('$key');
    print('----------------------------------------------${this.key}');
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(left: 34, right: 2, top: 2, bottom: 2)
          : const EdgeInsets.all(2.0),
      child: Row(
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
              padding: const EdgeInsets.only(top: 10),
              child: Material(
                color: index == 0
                    ? scafoldbackgroundcolor
                    : scafoldbackgroundcolor,
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
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                            child: TextWidget(label: msg, fontsize: 16)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                repeatForever: false,
                                displayFullTextOnTap: true,
                                totalRepeatCount: 1,
                                animatedTexts: [TyperAnimatedText(msg)]),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
