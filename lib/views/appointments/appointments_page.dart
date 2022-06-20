import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:servicr_client/views/appointments/review_user.dart';
import 'package:dio/dio.dart';
import 'view_appointments.dart';

import '../../constants.dart';

class AppointmentsPage extends StatefulWidget {
  final String userid;
  final String objectId;
  final String name;
  AppointmentsPage(
      {Key? key,
      required this.userid,
      required this.objectId,
      required this.name})
      : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime _selectedDate = DateTime.now();
  String selected_date = '';
  String selected_time = '';
  bool isCertified = false;

  getData() async {
    var response =
        await Dio().get(apiUrl + 'serviceProvider/' + widget.objectId);
    Map<String, dynamic> responseJSON = await json.decode(response.toString());
    print('res: $responseJSON');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Appointments"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/sp1.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Color(0xff003366)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Certified Beautician',
                                    style: TextStyle(
                                        color: Color(0xff5A606A),
                                        wordSpacing: 2,
                                        letterSpacing: 2),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                //details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('2000LKR',
                            style: TextStyle(
                                color: Color(0xff5A606A),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(
                          'per hour',
                          style: TextStyle(color: Color(0xff5A606A)),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      width: 0.2,
                      height: 22,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('21KM',
                            style: TextStyle(
                                color: Color(0xff5A606A),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(
                          'Away',
                          style: TextStyle(color: Color(0xff5A606A)),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      width: 0.2,
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('4.9',
                              style: TextStyle(
                                  color: Color(0xff003366),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          Text(
                            '119 reviews',
                            style: TextStyle(color: Color(0xff5A606A)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Text(
                    "Available Dates",
                    style: TextStyle(
                        color: Color(0xff5A606A),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Container(
                  child: DatePicker(
                    DateTime.now(),
                    height: 90,
                    width: 70,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Color(0xffA8CEFB),
                    selectedTextColor: Color(0xff5A606A),
                    dateTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A606A),
                      fontFamily: 'Roboto',
                    ),
                    dayTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A606A),
                      fontFamily: 'Roboto',
                    ),
                    monthTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A606A),
                      fontFamily: 'Roboto',
                    ),
                    onDateChange: (date) {
                      _selectedDate = date;
                      setState(() {
                        selected_date = date.toString();
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 0, top: 20, right: 0),
                  child: Text(
                    "Morning",
                    style: TextStyle(
                        color: Color(0xff5A606A),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.7,
                    children: [
                      spTimings("7.30 AM", false),
                      spTimings("8.30 AM", false),
                      spTimings("9.00 AM", true),
                      spTimings("9.30 AM", false),
                      spTimings("10.00 AM", false),
                      spTimings("11.30 AM", false),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    'Evening',
                    style: TextStyle(
                      color: Color(0xff5A606A),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.7,
                    children: [
                      spTimings("2.00 PM", false),
                      spTimings("3.00 PM", false),
                      spTimings("4.00 PM", true),
                      spTimings("5.00 PM", false),
                      spTimings("6.00 PM", false),
                      spTimings("7.00 PM", false),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),

                Container(
                  child: ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        print(selected_date);
                        print(selected_time);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentListPage(
                                      time: selected_time,
                                      date: selected_date,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50))),
                ),
                SizedBox(
                  height: 12,
                ),

                ElevatedButton(
                    child: Text('Review Service Provider'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)))
              ],
            ),
          ),
        ));
  }

  spTimings(String time, bool isSelected) {
    return isSelected
        ? InkWell(
            onTap: () {
              print('clicked');
              setState(() {
                selected_time = time;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                  color: Color(0xffA8CEFB),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 0),
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Color(0xff5A606A),
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  )
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              setState(() {
                selected_time = time;
                isSelected = true;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                  color: Color(0xffEBF5FF),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Color(0xff5A606A),
                          fontSize: 18,
                          fontFamily: 'Roboto'),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
