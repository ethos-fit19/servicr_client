import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servicr_client/local.dart';

import '../../constants.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List appointments = [];
  List notifications = [];

  GetNotificationForClient() async {
    var response = await Dio().get("$apiUrl/appointments");
    //print(response.data);
    Map<String, dynamic> responseJSON = await json.decode(response.toString());

    appointments = responseJSON['data'];
    // setState(() {
    //   appointments = responseJSON['data'];
    // });

    appointments.forEach((element) {
      ((element['client']['_id'] == uid) &
              (element['serviceisAcceptedStatus'] == true))
          ? {notifications.add(element), print('ele :' + element.toString())}
          : '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetNotificationForClient();
  }

  Future<String> getSPData(serviceProvider) async {
    print('sp id' + serviceProvider);
    if (serviceProvider != null) {
      var response = await Dio().get("$apiUrl/users/" + serviceProvider);
      print(response.data);
      Map<String, dynamic> responseJSON =
          await json.decode(response.toString());
      print(responseJSON);

      if (responseJSON['data']["name"] != null) {
        return responseJSON['data']["name"];
      } else {
        return "NoData";
      }
    } else {
      return "NoData";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Icon(Icons.refresh))
        ],
      ),
      body: listView(notifications, getSPData),
    );
  }
}

PreferredSizeWidget appBar() {
  return AppBar(
    title: Text("Notification Screen"),
  );
}

Widget listView(List notifications, getSPData) {
  return ListView.builder(
      itemBuilder: (contex, index) {
        return FutureBuilder(
            future: getSPData(
                notifications[index]['serviceProvider']['serviceProviderID']),
            builder: ((context, snapshot) {
              return (snapshot.data.toString() != 'NoData')
                  ? ListViewItem(notifications[index], index, snapshot.data)
                  : Container();
            }));
      },
      itemCount: notifications.length);
}

Widget ListViewItem(var item, int index, name) {
  return Container(
    padding: EdgeInsets.all(2.0),
    margin: EdgeInsets.all(3.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.amber[50]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prefixIcon(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (name != null)
                    ? Text(
                        name,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    : Container(),
                message(item, index),
                timeAndDate(item),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget prefixIcon() {
  return Container(
    height: 50,
    width: 50,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
    ),
    child: Icon(
      Icons.notifications,
      size: 25,
      color: Colors.grey.shade700,
    ),
  );
}

Widget message(var item, int index) {
  double textSize = 14;
  return Container(
    child: RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: (item['serviceCategory'] != null)
              ? item['serviceCategory']['name']
              : 'Service',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: ' costing ' + item['price'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
    ),
  );
}

Widget timeAndDate(var item) {
  String date = item['date'];
  String address = item['address'];
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date.substring(0, 9),
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Text(
          'át ' + address,
          style: TextStyle(
            fontSize: 13,
          ),
        )
      ],
    ),
  );
}
