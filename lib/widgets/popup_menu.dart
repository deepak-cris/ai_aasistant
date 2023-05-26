import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/modal_provider.dart';

/// Flutter code sample for [PopupMenuButton].

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo }

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  SampleItem? selectedMenu;
  TextEditingController? popUpTextControler;

  @override
  void initState() {
    popUpTextControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    popUpTextControler!.dispose();
    super.dispose();
  }

  void setAPIKey(String key) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', key);
  }

  @override
  Widget build(BuildContext context) {
    final ModalsProvider = Provider.of<ModalProvider>(context, listen: false);
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
          print('selectedMenu $selectedMenu');
          if (selectedMenu == SampleItem.itemOne) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Open AI API Key'),
                content: TextField(
                  onSubmitted: (value) {
                    setAPIKey(value);
                  },
                  controller: popUpTextControler,
                  style: const TextStyle(color: Colors.amber, fontSize: 18),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter/Paste API key',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setAPIKey(popUpTextControler!.text);
                      Navigator.pop(context, 'Save');
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          } else if (selectedMenu == SampleItem.itemOne) {
          } else {
            // log('please Select valid option' as num);
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Enter Open AI API Key'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text('Change AI Model'),
        ),
      ],
    );
  }
}
