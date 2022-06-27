import 'dart:ui';

import 'package:flutter/material.dart';

class OngoingListCard extends StatelessWidget {
  //final userData;
  int index = 0;
  OngoingListCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _currentUserProvider = useProvider(currentUserProvider);

    Widget cancelButton = FlatButton(
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
    Widget continueButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      onPressed: () async {
        //await UserService.followUser(_currentUserProvider.state.id!, userData['id']);    //  await UserService.userUnfollow(_currentUserProvider.state.id!, userData['id']);
        Navigator.of(context).pop();
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
                    'user ${index + 1}',
                    // '${userData['firstName']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
                height: 20.0,
                child: Card(
                  color: Color(0xffA8CEFB),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  elevation: 0.0,
                  child: Text(
                    // 'Tharushi'
                    'Date',
                    // '${userData['firstName']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50.0,
                height: 20.0,
                child: Card(
                  color: Color(0xffA8CEFB),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  elevation: 0.0,
                  child: Text(
                    // 'Tharushi'
                    'Time',
                    // '${userData['firstName']} ${userData['lastName']}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
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
              // Container(
              //   margin: const EdgeInsets.only(left: 70.0),
              //   child: ElevatedButton(
              //     child: Text(
              //       'Follow',
              //       style: TextStyle(color: Colors.black),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.yellow,
              //     ),
              //     onPressed: () {
              //       // show the dialog
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return alert;
              //         },
              //       );
              //     },
              //   ),
              // )
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
