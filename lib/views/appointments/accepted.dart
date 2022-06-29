import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servicr_client/constants.dart';
import 'package:servicr_client/local.dart';
import 'package:servicr_client/widgets/accepted_list.dart';

class AcceptedSp extends StatefulWidget {
  const AcceptedSp({Key? key}) : super(key: key);

  @override
  State<AcceptedSp> createState() => _AcceptedSpState();
}

class _AcceptedSpState extends State<AcceptedSp> {
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
      (element['client']['_id'] == uid &&
              element['serviceisAcceptedStatus'] == true)
          ? {
              setState(() {
                notifications.add(element);
              }),
              print('ele :' + element.toString())
            }
          : '';
    });
  }

  Future<String> getSPData(serviceProvider) async {
    if (serviceProvider != null) {
      //var serviceProvider = serviceProvider['_id'];

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
    setState(() {});
  }

  @override
  void initState() {
    GetNotificationForClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _currentUserProvider = useProvider(currentUserProvider);
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Expanded(
            //   flex: 7,
            //   child: FutureBuilder(
            //     future: UserService.getAllAcceptedSp(_currentUserProvider.state.id!),
            //     // future: UserService.getAllAcceptedSp('0981e133-1b46-4608-befa-6f10d1ff5900'),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const CircularProgressIndicator();
            //       } else if (snapshot.hasData) {
            //         List _items = snapshot.data as List;
            //         if (_items.length == 0) {
            //           // return const Text("No any AcceptedSp yet.",textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.yellow),);
            //            return Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Positioned(
            //                 left: 20,
            //                 top: 0,
            //                 right: 20,
            //                 child: Text('No Any AcceptedSp Yet! Hurry up build your community!',
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     color: Colors.amberAccent[400],
            //                   ),
            //                   textAlign: TextAlign.center,
            //                 )),
            //             Lottie.asset('assets/anims/enjoying-sloth.json', height: MediaQuery.of(context).size.width * 0.375, width: MediaQuery.of(context).size.width * 0.375),
            //           ],
            //         );

            //         } else {
            //           return ListView.builder(
            //             itemCount: _items.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return AcceptedSpListCard(index: index, userData: _items[index]);
            //             },
            //           );
            //         }
            //       } else if (snapshot.hasError) {
            //         if (snapshot.error.runtimeType == DioError) {
            //           DioError _error = snapshot.error as DioError;
            //           return Text(_error.toString());
            //         }
            //       }
            //       return const Text("Something went wrong");
            //     },
            //   ),
            // ),

            // Expanded(
            //   flex: 7,
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (BuildContext context, int index) {
            //       return AcceptedListCard(
            //         index: index,
            //       );
            //     },
            //   ),
            // ),

            Expanded(
                child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (notifications[index]["serviceProvider"] != null) {
                        return FutureBuilder(
                            future: getSPData(notifications[index]
                                ["serviceProvider"]["serviceProviderID"]),
                            builder: (context, snapshot) {
                              return (snapshot.data.toString() != 'NoData')
                                  ? AcceptedListCard(
                                      index: index,
                                      name: snapshot.data.toString(),
                                      date:notifications[index]["date"],
                                      appointmentId: notifications[index]['_id'],
                                    )
                                  : Container();
                            });
                      } else {
                        return Container();
                      }
                    }))
          ],
        ));
  }
}
