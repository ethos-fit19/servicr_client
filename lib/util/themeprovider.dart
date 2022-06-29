import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:servicr_client/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: 'LS',
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'LS',
    primaryColor: AppColor.s_blue,
    iconTheme: IconThemeData(color: AppColor.s_blue),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
        primary: AppColor.s_blue, // background (button) color
        onPrimary: Colors.white, // foreground (text) color
      ),
    ),
    appBarTheme: AppBarTheme(
    backgroundColor: AppColor.s_blue,
    )
  );
}
