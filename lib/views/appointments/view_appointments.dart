// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {},
          color: Color(0xff5A606A),
        ),
        title: Text(
          'Appointment #0001 ',
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff5A606A),
          ),
        ),
        elevation: 10.0,
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 180.0,
        ),
      ),
    );
  }
}
