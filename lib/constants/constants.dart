import 'package:flutter/material.dart';

Color scafoldbackgroundcolor = const Color(0xFF2B2E2F);
Color cardColor = const Color(0xFF1B1D1F);
Color textBackGroundColor = const Color(0xFF343541);

List<String> models = ['Item1', 'Item2', 'Item3', 'Item4'];

List<DropdownMenuItem<String>>? get getDropDownMenuItems {
  List<DropdownMenuItem<String>>? items =
      List<DropdownMenuItem<String>>.generate(
    models.length,
    (index) => DropdownMenuItem(
      value: models[index],
      child: Text(
        models[index],
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
  return items;
}

final chatMessages = [
  {'msg': 'Hello AI can you help me with making money!', 'chatindex': 0},
  {
    'msg':
        'Yes! i can help you the way you want. there is lots of way to make money to ai like developing app , tutorials etc',
    'chatindex': 1
  },
  {'msg': 'which one i should choose!', 'chatindex': 0},
  {'msg': 'Any one of them you want', 'chatindex': 1},
  {'msg': 'Hello AI can you help me with making money!', 'chatindex': 0},
  {'msg': 'Hello AI can you help me with making money!', 'chatindex': 1},
  {'msg': 'Hello AI can you help me with making money!', 'chatindex': 0},
  {'msg': 'Hello AI can you help me with making money!', 'chatindex': 1}
];
