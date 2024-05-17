import 'package:cropsight/views/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePageOne()),
      );
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/background/Splash Screen.png', // Change to your image path
            fit: BoxFit.cover,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0, // You can adjust the font size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
