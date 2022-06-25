import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:servicr_client/views/appointments/review_user.dart';
import 'package:dio/dio.dart';
import '../../local.dart';
import 'view_appointments.dart';

import '../../constants.dart';

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

      print('res: $responseJSON');
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
      element['servicer'].contains(spData['serviceProviderID'])
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
        "date": selected_date.toString(),
        "price": '1000', //spData['hourlyCharge'].toString(),
        "status": "true"
      }).then(
        (value) {
          Map<String, dynamic> responseJSON = json.decode(value.toString());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentListPage(
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
        body: spData != null
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
                                AssetImage('assets/images/sp1.jpg'),
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
                                          isCertified ? 'Certified' : '',
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('', //spData['hourlyCharge']!,
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
                                Text(providerReviews()[1],
                                    style: TextStyle(
                                        color: Color(0xff003366),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(
                                  providerReviews()[0].toString() + ' Reviews',
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
                            spTimings(
                              "7.30 AM",
                            ),
                            spTimings(
                              "8.30 AM",
                            ),
                            spTimings(
                              "9.00 AM",
                            ),
                            spTimings(
                              "9.30 AM",
                            ),
                            spTimings(
                              "10.00 AM",
                            ),
                            spTimings(
                              "11.30 AM",
                            ),
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
                            spTimings(
                              "2.00 PM",
                            ),
                            spTimings(
                              "3.00 PM",
                            ),
                            spTimings(
                              "4.00 PM",
                            ),
                            spTimings(
                              "5.00 PM",
                            ),
                            spTimings(
                              "6.00 PM",
                            ),
                            spTimings(
                              "7.00 PM",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
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
    String time,
  ) {
    return selected_time == time
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
