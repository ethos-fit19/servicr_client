//import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import "package:servicr_client/constants.dart";
import 'package:servicr_client/views/home/service_providers.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({key}) : super(key: key);
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  getData() async {
    var response = await Dio().get("$apiUrl/categories");
    print(response.data);
    Map<String, dynamic> responseJSON = await json.decode(response.toString());

    setState(() {
      serviceCategories = responseJSON['data'];
    });
    print(serviceCategories[0]);
  }

  List serviceCategories = [];
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
          title: Text("Categories"),
        ),
        body: ListView.builder(
          itemCount: serviceCategories.length,
          itemBuilder: (BuildContext context, int index) {
            print("sss");
            return GestureDetector(
              onTap: () => Get.to(ServiceProvidersPage(
                  categoryId: serviceCategories[index]['_id'])),
              child: Card(
                color: Color.fromRGBO(225, 245, 255, 10),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/I1.png',
                    scale: 12,
                  ),
                  title: Text(serviceCategories[index]['name']),
                ),
              ),
            );
          },
          shrinkWrap: true,
        ));
  }
}
