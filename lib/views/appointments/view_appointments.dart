// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({Key? key}) : super(key: key);

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
                          child: myDetailsContainer1(),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image(
                            fit: BoxFit.contain,
                            alignment: Alignment.topRight,
                            image: AssetImage('assets/sp1.jpg'),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xffA8CEFB),
            width: 300,
            height: 50,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Appointment ID',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xffA8CEFB),
            width: 300,
            height: 50,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Job Description',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Color(0xffA8CEFB),
            width: 300,
            height: 50,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Address',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
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
                child: Text('Mark as completed'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentListPage()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                )),
          ),
        ),
      ]),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
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
    return _steps;
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Anne Smith",
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
                "(321)",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Certified Beautician",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
        Text(
          "28th May 2021",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
        Text(
          "9.00 AM",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
