//import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import "package:servicr_client/constants.dart";
import 'package:servicr_client/views/appointments/appointments_page.dart';

class ServiceProvidersPage extends StatefulWidget {
  final String categoryId;
  const ServiceProvidersPage({key, required this.categoryId}) : super(key: key);
  @override
  _ServiceProvidersPageState createState() => _ServiceProvidersPageState();
}

class _ServiceProvidersPageState extends State<ServiceProvidersPage> {
  getData() async {
    var response = await Dio().get("$apiUrl/serviceProvider");
    print(response.data);
    Map<String, dynamic> responseJSON = await json.decode(response.toString());

    setState(() {
      serviceProviders = responseJSON['data'];
    });
    print(serviceProviders[0]);
    print(widget.categoryId);
  }

  Future<String> getSPData(serviceProvider) async {
    if (serviceProvider != null) {
      var userId = serviceProvider['_id'];
      var response = await Dio().get("$apiUrl/users/" + userId);
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

  List serviceProviders = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Service Providers"),
        ),
        body: ListView.builder(
            itemCount: serviceProviders.length,
            itemBuilder: (BuildContext context, int index) {
              if (serviceProviders[index]["categoryID"] == widget.categoryId) {
                return FutureBuilder(
                    future:
                        getSPData(serviceProviders[index]["serviceProviderID"]),
                    builder: (context, snapshot) {
                      return (snapshot.data.toString() != 'NoData')
                          ? GestureDetector(
                              onTap: () {
                                Get.to(AppointmentsPage(
                                    serviceProvId: serviceProviders[index]
                                        ['_id'],
                                    name: snapshot.data.toString(),
                                    userid: serviceProviders[index]
                                            ["serviceProviderID"]['_id']
                                        .toString(),
                                    objectId: serviceProviders[index]['_id']
                                        .toString()));
                              },
                              child: Card(
                                color: Color.fromRGBO(225, 245, 255, 10),
                                child: ListTile(
                                  leading: Image.asset(
                                    'assets/images/placeholder.jpg',
                                    scale: 12,
                                  ),
                                  // title: Text(serviceProviders[index]['name']),
                                  title: Text(snapshot.data.toString()),
                                ),
                              ),
                            )
                          : Container();
                    });
              } else {
                return Container();
              }
            }));
  }
}
