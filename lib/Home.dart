import 'package:flutter/material.dart';
import 'package:albaladiya/widgets/my_button.dart';
import 'package:albaladiya/chatroom.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/albaladiya.png'),
                ),
                Text(
                  'Albaladiya',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            MyButton(
              color: Colors.blue[800]!,
              title: 'Espace Client',
              onPressed: () {
                Navigator.pushNamed(context, '/IdPage');
              },
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: 'Espace Admin',
              onPressed: () {
                Navigator.pushNamed(context, '/Login');
                print('Sign in button pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
