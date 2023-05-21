import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/modals/chat_model.dart';
import 'package:ai_assistant/services/assetmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:siri_wave/siri_wave.dart';
import '../providers/modal_provider.dart';
import '../services/api_services.dart';
import '../widgets/chat_widgets.dart';
import '../widgets/dropdown.dart';
import '../widgets/siri_wave.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  bool isTyping = false;
  List<ChatModal> messageList = [];
  TextEditingController? chattextEditingController;
  late FocusNode focusNode;
  late ScrollController chatscrollController;
  final siriWaveControler = SiriWaveController();

  @override
  void initState() {
    chattextEditingController = TextEditingController();
    chatscrollController = ScrollController(keepScrollOffset: false);
    //chatscrollController.keepScrollOffset;
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    chattextEditingController!.dispose();
    focusNode.dispose();
    chatscrollController.dispose();
    super.dispose();
  }

  void scrollListToBottom() {
    chatscrollController.animateTo(
      chatscrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void getApiResopnse(ModalProvider modalProvider) async {
    try {
      String txtmsg = chattextEditingController!.text;
      chattextEditingController!.clear();
      setState(() {
        isTyping = true;
        messageList.add(ChatModal(msg: txtmsg.toString(), chatInext: 0));

        focusNode.unfocus();
      });

      List<ChatModal> tempobj = await ApiServices.getChatResopnse(
          modalProvider.currentModel, txtmsg.toString());

      setState(() {
        messageList.addAll(tempobj);
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isTyping = false;
        scrollListToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ignore: non_constant_identifier_names
    final ModalsProvider = Provider.of<ModalProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiImage),
          ),
          title: const Text('AI Assistant'),
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
                  key: const Key('Chat_List'),
                  controller: chatscrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                        key: UniqueKey(),
                        msg: messageList[index].msg,
                        index: messageList[index].chatInext);
                  },
                ),
              ),
              if (isTyping) ...[
                // const SpinKitWave(
                //   color: Colors.white,
                //   size: 20,
                // ),
                //const Expanded(child: SiriWave()),
                const SizedBox(
                  height: 75,
                  child: Expanded(
                    child: SiriWaveWidget(),
                  ),
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              Material(
                color: scafoldbackgroundcolor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          onSubmitted: (value) {
                            getApiResopnse(ModalsProvider);
                          },
                          controller: chattextEditingController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                              hintText: 'How can i help you?',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            getApiResopnse(ModalsProvider);
                          },
                          child: const Icon(Icons.send, color: Colors.green)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
