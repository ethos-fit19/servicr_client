import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:servicr_client/views/appointments/review_user.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../local.dart';
import 'view_appointments.dart';

import '../../constants.dart';
import './view_reviews.dart';

class AppointmentsPage extends StatefulWidget {
  final String userid;
  final String objectId;
  final String name;
  final String serviceProvId;
  const AppointmentsPage(
      {Key? key,
      required this.userid,
      required this.objectId,
      required this.name,
      required this.serviceProvId})
      : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime _selectedDate = DateTime.now();
  String selected_date = DateTime.now().toString();
  String selected_time = '';
  bool isCertified = false;
  List reviews = [];

  String address = '';

  var spData;
  getData() async {
    try {
      var response =
          await Dio().get('$apiUrl/serviceProvider/${widget.objectId}');
      Map<String, dynamic> responseJSON =
          await json.decode(response.toString());

      setState(() {
        spData = responseJSON['data'];
        isCertified = spData['isApprovedStatus'];
      });

      print('RES: $responseJSON');
    } catch (e) {
      print(e);
    }
  }

  getReviews() async {
    try {
      var response = await Dio().get('$apiUrl/reviews');
      Map<String, dynamic> responseJSON =
          await json.decode(response.toString());

      setState(() {
        reviews = responseJSON['data'];
      });

      print('res: $responseJSON');
    } catch (e) {
      print(e);
    }
  }

  List providerReviews() {
    List res = [];
    var total = 0;
    reviews.forEach((element) {
      (element['servicer'] == spData['serviceProviderID'])
          ? res.add(element)
          : '';
    });
    res.forEach((ele) {
      total += int.parse(ele['starRating']);
    });
    return [
      res.length,
      (total / res.length) > 0 ? (total / res.length).toStringAsFixed(1) : '0'
    ];
  }

  createAppointment() async {
    print("uid:" +
        uid +
        " cat:" +
        spData['categoryID'] +
        " hr:" +
        //spData['hourlyCharge'] +
        " data" +
        selected_date +
        "  " +
        widget.userid);
    try {
      print('sending $apiUrl');
      var response = await Dio().post(apiUrl + '/appointments', data: {
        "client": uid.toString(),
        "serviceProvider": widget.serviceProvId,
        "serviceCategory": spData['categoryID'].toString(),
        "address": address.toString(),
        // "date": selected_date,
        "date": _selectedDate.toIso8601String(),
        "time": selected_time.toString(),
        "price": '1000', //spData['hourlyCharge'].toString(),
        "status": "true"
      }).then(
        (value) {
          Map<String, dynamic> responseJSON = json.decode(value.toString());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentListPage(
                      name:widget.name,
                      id: responseJSON['data']['_id'],
                      time: selected_time,
                      date: selected_date,
                      address: address,
                      reviewsCount: providerReviews()[0])));
        },
      );

      // return response;
    } catch (e) {
      print(e);
      Get.snackbar("Message", "This time slot is not available!",
          backgroundColor: Colors.white);
      return 'Unable to Fetch';
    }
  }

  @override
  void initState() {
    getData();
    getReviews();
    // TODO: implement initState
    super.initState();
  }

  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Appointments"),
        ),
        body: reviews.length > 0
            ? SingleChildScrollView(
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
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          isCertified
                                              ? 'Verified Service Provider'
                                              : '',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Text('', //spData['hourlyCharge']!,
                          //         style: TextStyle(
                          //             color: Color(0xff5A606A),
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15)),
                          //     Text(
                          //       'per hour',
                          //       style: TextStyle(color: Color(0xff5A606A)),
                          //     ),
                          //   ],
                          // ),

                          InkWell(
                              onTap: () {
                                //print(reviews);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (ViewReview(reviews: reviews))));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(providerReviews()[1],
                                        style: TextStyle(
                                            color: Color(0xff003366),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Text(
                                      providerReviews()[0].toString() +
                                          ' Reviews',
                                      style:
                                          TextStyle(color: Color(0xff5A606A)),
                                    ),
                                  ],
                                ),
                              ))
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
                          ),
                          dayTextStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5A606A),
                          ),
                          monthTextStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5A606A),
                          ),
                          onDateChange: (date) {
                            setState(() {
                              _selectedDate = date;
                              selected_date = date.toIso8601String();
                              print(selected_date);
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
                            spTimings(DateTime(1990, 1, 1, 7, 30)),
                            spTimings(DateTime(1990, 1, 1, 8, 30)),
                            spTimings(DateTime(1990, 1, 1, 9, 0)),
                            spTimings(DateTime(1990, 1, 1, 9, 30)),
                            spTimings(DateTime(1990, 1, 1, 10, 0)),
                            spTimings(DateTime(1990, 1, 1, 11, 30)),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          'Evening',
                          style: TextStyle(
                            color: Color(0xff5A606A),
                            fontSize: 20,
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
                            spTimings(DateTime(1990, 1, 1, 14, 0)),
                            spTimings(DateTime(1990, 1, 1, 15, 0)),
                            spTimings(DateTime(1990, 1, 1, 16, 0)),
                            spTimings(DateTime(1990, 1, 1, 16, 30)),
                            spTimings(DateTime(1990, 1, 1, 17, 0)),
                            spTimings(DateTime(1990, 1, 1, 18, 0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   "Name",
                      //   style: TextStyle(
                      //     color: Color(0xff5A606A),
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: addressController,
                      //   onChanged: (String? text) {
                      //     address = text!;
                      //   },
                      // ),

                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Address",
                        style: TextStyle(
                          color: Color(0xff5A606A),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextFormField(
                        controller: addressController,
                        onChanged: (String? text) {
                          address = text!;
                        },
                      ),

                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              print(selected_date);
                              print(selected_time);
                              (selected_time != '' && address != '')
                                  ? {
                                      createAppointment(),
                                    }
                                  : Get.snackbar("Message",
                                      "Please select a time and insert address");
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50)),
                            child: Text('Confirm')),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewPage(
                                        servicerId: widget.userid,
                                        servicerName: widget.name)));
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)),
                          child: Text('Review Service Provider'))
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  spTimings(
    DateTime time,
  ) {
    return InkWell(
      onTap: () {
        print('clicked');
        setState(() {
          selected_time = DateFormat('hh:mm a').format(time);
          DateTime s = _selectedDate;
          _selectedDate =
              DateTime(s.year, s.month, s.day, time.hour, time.minute);
          print(_selectedDate);
          print(_selectedDate.toIso8601String());
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
            color: selected_time == DateFormat('hh:mm a').format(time)
                ? Color(0xffA8CEFB)
                : Color(0xffEBF5FF),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 0),
              child: Text(
                DateFormat('hh:mm a').format(time),
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
