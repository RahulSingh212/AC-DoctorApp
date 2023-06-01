import 'package:doctor/patients.dart';
import 'package:doctor/upcomingappointments.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';
import 'home.dart';

class MainPageV2 extends StatefulWidget {
  MainPageV2({Key? key, required String name}) : super(key: key);

  @override
  _MainPageStateV2 createState() => _MainPageStateV2();
}

class _MainPageStateV2 extends State<MainPageV2> {
  int index = 0;
  List navigationpages = [
    HomePage(),
    Patients(),
    Calendar(),
    UpcomingAppointments(),
  ];

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Scaffold(
      body: navigationpages[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.08333 * _width),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 0.02777 * _width),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.08333 * _width),
          child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            currentIndex: index,
            elevation: 12,
            selectedItemColor: Color(0xff42ccc3),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_time_outlined), label: "Schedule"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.work_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
