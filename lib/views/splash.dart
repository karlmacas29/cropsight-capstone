import 'package:cropsight/views/navigation/home.dart';
import 'package:cropsight/views/navigation/homepage.dart';
import 'package:cropsight/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Delay for 3 seconds

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const WelcomePageOne()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomePageNav()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
