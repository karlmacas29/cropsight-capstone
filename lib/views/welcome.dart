import 'package:cropsight/models/buttons.dart';
import 'package:cropsight/views/navigation/homepage.dart';
import 'package:flutter/material.dart';

class WelcomePageOne extends StatefulWidget {
  const WelcomePageOne({super.key});

  @override
  State<WelcomePageOne> createState() => _WelcomePageOneState();
}

class _WelcomePageOneState extends State<WelcomePageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          'assets/background/BAKGROUND1.png', // Change to your image path
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  'Welcome to',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Crop',
                  style: TextStyle(
                      color: Color.fromRGBO(2, 101, 0, 1),
                      fontFamily: 'Inter',
                      fontSize: 64,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sight',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 64,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 120,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Center(
                child: Text(
                  'A mobile app for rice crop pest detection system using mobile camera.',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ClickButton(
              backgroundColor: const Color.fromRGBO(2, 101, 0, 1),
              borderColor: const Color.fromRGBO(2, 101, 0, 1),
              text: 'Lets get started',
              textColor: Colors.white,
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePageNav()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
