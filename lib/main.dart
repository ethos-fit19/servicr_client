import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicr_client/views/welcome/welcome.dart';
import 'package:servicr_client/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          fontFamily: 'LS',
          primaryColor: AppColor.s_blue,
          // inputDecorationTheme: const InputDecorationTheme(
          //   enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(width: 2, color: Colors.black),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(width: 2, color: Colors.black),
          //   ),
          // ),
          iconTheme: IconThemeData(color: AppColor.s_blue),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: AppColor.s_blue, // background (button) color
              onPrimary: Colors.white, // foreground (text) color
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.s_blue,
          )),
      title: "Servicr",
      home: WelcomePage(),
    );
  }
}
