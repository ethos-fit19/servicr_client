// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppointmentListPage extends StatefulWidget {
  String date;
  String time;
  String address;
  String id;
  int reviewsCount;
  AppointmentListPage(
      {required this.date,
      required this.time,
      required this.address,
      required this.id,
      required this.reviewsCount});

  @override
  State<StatefulWidget> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentListPage> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Appointment Details ',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: FittedBox(
              child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: myDetailsContainer1(widget.reviewsCount),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            fit: BoxFit.contain,
                            alignment: Alignment.topRight,
                            image: AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 16.0, left: 16.0),
        //   child: Text(
        //     'Job Description',
        //     style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Container(
        //     color: Color(0xffA8CEFB),
        //     width: 300,
        //     height: 50,
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Text(
        //         'Facial and Makeup',
        //         style: TextStyle(
        //           fontSize: 18,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
          child: Text(
            'Appointment ID',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xffA8CEFB),
            width: 300,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                widget.id,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xffA8CEFB),
            width: 300,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                widget.address,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Job Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Stepper(
              steps: _mySteps(),
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (_currentStep < _mySteps().length - 1) {
                    _currentStep = _currentStep + 1;
                  } else {
                    print('completed,check fields');
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep = _currentStep - 1;
                  } else {
                    _currentStep = 0;
                  }
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AppointmentListPage(
                  //               date: DateTime.now().toString(),
                  //               time: "7.00 AM",
                  //             )));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text('Mark as completed')),
          ),
        ),
      ]),
    );
  }

  List<Step> _mySteps() {
    List<Step> steps = [
      Step(
        title: Text('Task-1'),
        content: Text('Service Provider accepted the appointment'),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Task-2'),
        content: Text('Service Provider marked the appointment as completed'),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Task-3'),
        content: Text('You marked the appointment as completed'),
        isActive: _currentStep >= 2,
      )
    ];
    return steps;
  }

  Widget myDetailsContainer1(count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            //SP name
            widget.id,
            style: TextStyle(
              color: Color(0xff5A606A),
              fontSize: 24.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "4.9",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.0,
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Verified Service Provider",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
        Text(
          widget.date.substring(0, 11),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
        Text(
          widget.time,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
