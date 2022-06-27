import 'package:flutter/material.dart';
import 'package:servicr_client/views/utils/aboutUI.dart';
import 'package:fluttertoast/fluttertoast.dart';

 

class ResetPwUI extends StatefulWidget {
  // const HelpPageUI({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  State<ResetPwUI> createState() => _ResetPwUIState();
}

class _ResetPwUIState extends State<ResetPwUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password",
            style: TextStyle(
              fontSize: 22,
            )),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(


          
        ),
      ),
    );
    // ignore: dead_code
    
  }
}

@override
Widget build(BuildContext context) {
  //return Scaffold(
  return Column(
    children: <Widget>[
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {},
        child: const Text('TextButton'),
      ),
    ],
  );
}
