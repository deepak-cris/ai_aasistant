import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/screens/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Assistant',
      theme: ThemeData(
        scaffoldBackgroundColor: cardColor,
        appBarTheme: AppBarTheme(color: scafoldbackgroundcolor, elevation: 10),
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}
