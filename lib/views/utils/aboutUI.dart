// ignore_for_file: deprecated_member_use, prefer_const_constructors

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicr_client/views/appointments/review_user.dart';
import 'package:servicr_client/views/utils/help_page.dart';

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
                //backgroundImage: NetworkImage(
                //"https://www.channelfutures.com/files/2009/01/managed-service-providers-merge_0.jpg"),
                backgroundImage: NetworkImage(
                    "https://thearchitecturedesigns.com/wp-content/uploads/2022/02/Hiring-Professional-Painters-1.jpg"),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        ListTile(
          title: Center(
            child: Text(
              "Servicr",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Center(
              child: Text(
            'You press the Hire button, we do the rest!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ),
         ElevatedButton.icon(
          onPressed: () {  
             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelpPageUI()),
                        );


            // Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => ReviewPage(
            //                             servicerId: widget.userid,
            //                             servicerName: widget.name)));
          },
          icon: Icon(
            Icons.contact_phone,
            color: Colors.white,
          ),
          label: Text(
            ' Contact Us',
            style: TextStyle(color: Colors.white),
          ),
          // color: Colors.blue,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        ListTile(
          title: Text('About Us',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

          subtitle: Text(
              'We are Servicr. Get started by creating a personal account.  Clients can connect with the system through their accounts and then search and find the experts in each field accordingly. After some process, the client can book a service provider that suits his requirements and send him  a message through the application.',
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
