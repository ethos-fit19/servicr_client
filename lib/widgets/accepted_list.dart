import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servicr_client/constants.dart';
import 'package:servicr_client/views/appointments/appointment_status.dart';

class AcceptedListCard extends StatefulWidget {
  //final userData;
  int index = 0;
  String name;
  String date;
  String appointmentId;
  AcceptedListCard(
      {Key? key,
      required this.index,
      required this.name,
      required this.date,
      required this.appointmentId})
      : super(key: key);

  @override
  State<AcceptedListCard> createState() => _AcceptedListCardState();
}

class _AcceptedListCardState extends State<AcceptedListCard> {
  @override
  Widget build(BuildContext context) {
    //final _currentUserProvider = useProvider(currentUserProvider);

    Widget cancelButton = ElevatedButton(
      child: Text(
        "No",
        style: TextStyle(
          color: Colors.green,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text(
        "Yes",
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      onPressed: () async {
        //await UserService.followUser(_currentUserProvider.state.id!, userData['id']);    //  await UserService.userUnfollow(_currentUserProvider.state.id!, userData['id']);
        var res = await Dio()
            .delete(apiUrl + '/appointments/' + widget.appointmentId);
        print(res);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AppointmentStatus()));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Cancel Appointment"),
      content: Text("Are you sure you want to cancel this Appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Color(0xffA8CEFB),
        child: ListTile(
          title: Row(
            children: [
              Image.asset(
                'assets/images/avatar.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              SizedBox(
                width: 50.0,
                height: 20.0,
                child: Card(
                  color: Color(0xffA8CEFB),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  elevation: 0.0,
                  child: Text(
                    // 'Tharushi'
                    widget.name,

                    // '${userData['firstName']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80.0,
                height: 20.0,
                child: Card(
                  color: Color(0xffA8CEFB),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  elevation: 0.0,
                  child: Text(
                    // 'Tharushi'
                    widget.date.substring(0, 10),
                    // '${userData['firstName']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 50.0,
              //   height: 20.0,
              //   child: Card(
              //     color: Color(0xffA8CEFB),
              //     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              //     elevation: 0.0,
              //     child: Text(
              //       // 'Tharushi'
              //       'Time',
              //       // '${userData['firstName']} ${userData['lastName']}',
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),

              // ElevatedButton(
              //   margin: const EdgeInsets.only(top: 10.0),
              //       onPressed: () {},
              //       child: Text(
              //         'Follow',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         primary: Colors.yellow,
              //       ),
              //     ),
              Container(
                margin: const EdgeInsets.only(left: 50.0),
                child: ElevatedButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff003366),
                  ),
                  onPressed: () {
                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                ),
              )
            ],
          ),
          // trailing: Text(
          //   'Coins : ${userData["coins"]}',
          //   style: TextStyle(
          //     color: Colors.white,
          //   ),
          // ),
        ),
        elevation: 8,
        shadowColor: Colors.green,
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
