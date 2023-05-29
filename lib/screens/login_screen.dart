import 'package:flutter/material.dart';
import 'package:ai_assistant/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scafoldbackgroundcolor,
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                decoration: InputDecoration(border: const OutlineInputBorder()v),),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              height: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // <-- Radius
                ),
                padding: const EdgeInsets.all(20),
              ),
              child: const Text('Guest User'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40), // <-- Radius
                ),
                padding: const EdgeInsets.all(20),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
