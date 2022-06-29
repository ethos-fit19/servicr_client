import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicr_client/views/appointments/accepted.dart';
import 'package:servicr_client/views/appointments/ongoing.dart';
import 'package:servicr_client/views/appointments/cancelled.dart';
import 'package:servicr_client/views/home/landing.dart';

class AppointmentStatus extends StatefulWidget {
  static const routeName = '/AppointmentStatus';
  const AppointmentStatus({Key? key}) : super(key: key);

  @override
  State<AppointmentStatus> createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(LandingPage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff003366),
          elevation: 0,
          title: Text("My Appointments",
              style: TextStyle(fontSize: 25.0, color: Colors.white)),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              const Tab(text: 'Accepted'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            controller: _tabController,
            indicatorColor: Color(0xffffffff),
          ),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   // image: DecorationImage(
          //   //   image: AssetImage("'assets/images/sp1.jpg'"),
          //   //   fit: BoxFit.cover,
          //   // ),
          // ),
          child: TabBarView(
            controller: _tabController,
            children: [
              AcceptedSp(),
            ],
          ),
        ),
        backgroundColor: const Color(0xffffffff),
      ),
    );
  }
}
