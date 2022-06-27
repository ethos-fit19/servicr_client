import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class AppointmentsLandingPage extends StatefulWidget {
  const AppointmentsLandingPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsLandingPage> createState() =>
      _AppointmentsLandingPageState();
}

class _AppointmentsLandingPageState extends State<AppointmentsLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Appointments"),
      ),
      body: Container(),
    );
  }
}
