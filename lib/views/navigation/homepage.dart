import 'package:cropsight/views/navigation/cropsight.dart';
import 'package:cropsight/views/navigation/home.dart';
import 'package:cropsight/views/navigation/settings.dart';
import 'package:cropsight/views/navigation/solution.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({super.key});

  @override
  State<HomePageNav> createState() => _HomePageNavState();
}

class _HomePageNavState extends State<HomePageNav> {
  int _currentIndex = 0;
  final tabsnav = [const HomeTab(), const CropsightTab(), const SolutionTab()];

  final _iconappbar = [
    Icons.home_rounded,
    Icons.grass_rounded,
    Icons.menu_book_rounded,
  ];

  final _titleAppbar = ['Home', 'Cropsight', 'Management'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color.fromRGBO(244, 253, 255, 1)
          : const Color.fromRGBO(18, 18, 18, 1),
      appBar: PreferredSize(
        preferredSize: const Size.square(80),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color.fromRGBO(244, 253, 255, 1)
                : const Color.fromRGBO(18, 18, 18, 1),
            scrolledUnderElevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsApp()));
                  },
                  icon: const Icon(Icons.settings))
            ],
            leadingWidth: 28,
            leading: Icon(
              _iconappbar[_currentIndex],
              color: const Color.fromRGBO(2, 101, 0, 1),
              size: 42,
            ),
            title: Text(
              _titleAppbar[_currentIndex],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: tabsnav[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: GNav(
            iconSize: 30,
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabBackgroundColor: const Color.fromRGBO(2, 101, 0, 1),
            color: Theme.of(context).brightness != Brightness.light
                ? Colors.white
                : Colors.black,
            activeColor: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.grass_rounded,
                text: 'Cropsight',
              ),
              GButton(
                icon: Icons.menu_book_rounded,
                text: 'Management',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
