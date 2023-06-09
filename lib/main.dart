import 'package:ai_assistant/constants/constants.dart';
import 'package:ai_assistant/providers/modal_provider.dart';
import 'package:ai_assistant/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ModalProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Assistant',
        theme: ThemeData(
          scaffoldBackgroundColor: cardColor,
          appBarTheme:
              AppBarTheme(color: scafoldbackgroundcolor, elevation: 10),
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
