import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('themeMode') ?? 'system';
    if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      prefs.setString('themeMode', 'light');
    } else if (themeMode == ThemeMode.dark) {
      prefs.setString('themeMode', 'dark');
    } else {
      prefs.setString('themeMode', 'system');
    }
    notifyListeners();
  }
}

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
      ),
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: ((context, index) {
            return Column(children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About this app'),
                onTap: () {},
              ),
              ListTile(
                leading: Theme.of(context).brightness == Brightness.light
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.dark_mode),
                title: Theme.of(context).brightness == Brightness.light
                    ? const Text('ThemeMode(Light)')
                    : const Text('ThemeMode(Dark)'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'light') {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setThemeMode(ThemeMode.light);
                    } else if (value == 'dark') {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setThemeMode(ThemeMode.dark);
                    } else {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setThemeMode(ThemeMode.system);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'light', 'dark', 'system'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              )
            ]);
          }),
        ),
      ),
    );
  }
}
