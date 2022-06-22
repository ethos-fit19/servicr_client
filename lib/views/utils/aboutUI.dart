// ignore_for_file: deprecated_member_use, prefer_const_constructors

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aboutUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMEpUpzx7b1_ZgqmyVy-oqcOuvdWYQmu6h5w&usqp=CAU'),
            ),
            Positioned(
                bottom: -50.0,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      "data:image/png;base64,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"),
                ))
          ],
        ),
        SizedBox(
          height: 60,
        ),
        ListTile(
          title: Center(
            child: Text(
              "Servicr",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Center(
              child: Text(
            'You press the Book button, we do the rest!',
            style: TextStyle(
                color: Colors.purple,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
        ),
        FlatButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          label: Text(
            ' Rate Us',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        ListTile(
          title: Text('About Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

          subtitle: Text(
              'We are Servicr. There are standard functions that users can perform in the app, and they also have their unique functions according to their requirements. Before connecting with the system,users must create a personal account and register.',
              style: TextStyle(fontSize: 16)),
          //  '' their account through Facebook and Google as well as using their mobile number.''
          //   Clients can connect with the system through their accounts and then search and find the
          //   experts in each field accordingly. Then the details of the service providers are filtered and
          //   displayed according to their rating and reviews, location, and availability status. Then after
          //   some process, the client can book a service provider that suits his requirements and send him
          //   a message through the application.'),
        ),
      ],
    );
  }
}
