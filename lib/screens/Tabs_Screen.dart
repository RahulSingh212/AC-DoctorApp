// ignore_for_file: prefer__ructors, unused_import, unused_local_variable, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../providers/doctorAuth_details.dart';
import '../providers/doctorUser_details.dart';

import './Home_Screen.dart';
import './My_Patients_Screen/MyPatients_Screen.dart';
import 'My_Calendar_Screen/MyCalendar_Screen.dart';
import './UpcomingAppointments_Screen.dart';

class TabsScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-tabs-screen';

  @override
  State<TabsScreenDoctor> createState() => _TabsScreenDoctorState();
}

class _TabsScreenDoctorState extends State<TabsScreenDoctor> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  // final _auth = FirebaseAuth.instance;

  final _appScreens = [
    HomeScreenDoctor(),
    MyPatientsScreenDoctor(),
    MyCalendarScreenDoctor(),
    UpcomingAppointmentsScreenDoctor(),
  ];

  @override
  void initState() {
    super.initState();
    
    _pages = [
      {
        'page': HomeScreenDoctor(),
        'title': 'Home',
      },
      {
        'page': MyPatientsScreenDoctor(),
        'title': 'My Patients',
      },
      {
        'page': MyCalendarScreenDoctor(),
        'title': 'My Calendar',
      },
      {
        'page': UpcomingAppointmentsScreenDoctor(),
        'title': 'Upcoming Appointments'
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final iconItemsInActive = <Widget>[
       Icon(
        Icons.home_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.person_outline,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.access_time_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.work_outline_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
    ];

    final iconItemsActive = <Widget>[
       Icon(
        Icons.home_rounded,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.person,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.access_time,
        color: Color(0xff42ccc3),
        size: 30,
      ),
       Icon(
        Icons.work,
        color: Color(0xff42ccc3),
        size: 30,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     _pages[_selectedPageIndex]['title'] as String,
      //     style: TextStyle(
      //       fontStyle: FontStyle.italic,
      //       fontSize: screenWidth * 0.05,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: <Widget>[
      //     Container(
      //       padding: EdgeInsets.only(right: screenWidth * 0.05),
      //       child: GestureDetector(
      //         onTap: () async {
      //           String titleText = "Logout";
      //           String contextText = "Are you sure your want to Logout?";
      //           _checkForLogout(context, titleText, contextText, popVal: true);
      //         },
      //         child:  Icon(
      //           Icons.logout,
      //           color: Colors.white,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      // body: _pages[_selectedPageIndex]['page'] as Widget,
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _appScreens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff42ccc3),
        ),
        child: buildMyNavBar(context),
        // CurvedNavigationBar(
        //   onTap: _selectPage,
        //   backgroundColor: Colors.transparent,
        //   color: Theme.of(context).primaryColor,
        //   buttonBackgroundColor: Theme.of(context).primaryColor,
        //   index: 0,
        //   height: screenHeight * 0.070,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration:  Duration(milliseconds: 300),
        //   items: iconItemsInActive,
        // ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.5),
          topRight: Radius.circular(22.5),
          bottomRight: Radius.circular(22.5),
          bottomLeft: Radius.circular(22.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(0);
              });
            },
            icon: _selectedPageIndex == 0
                ?  Icon(
                    Icons.home_rounded,
                    color: Color(0xff42ccc3),
                    size: 30,
                  )
                :  Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(1);
              });
            },
            icon: _selectedPageIndex == 1
                ?  Icon(
                    Icons.person,
                    color: Color(0xff42ccc3),
                    size: 30,
                  )
                :  Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(2);
              });
            },
            icon: _selectedPageIndex == 2
                ?  Icon(
                    Icons.watch_later_rounded,
                    color: Color(0xff42ccc3),
                    size: 30,
                  )
                :  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(3);
              });
            },
            icon: _selectedPageIndex == 3
                ?  Icon(
                    Icons.work_rounded,
                    color: Color(0xff42ccc3),
                    size: 30,
                  )
                :  Icon(
                    Icons.work_outline_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkForLogout(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dangerous_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                  // _auth.signOut();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     SelectLanguageScreenPatient.routeName, (route) => false);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
