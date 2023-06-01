// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'FirstTab.dart';
import 'SecondTab.dart';

class Patients extends StatelessWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            title: const Text(
              "My Patients",
              // time,

              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 24),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xff42ccc3),
              tabs: [
                Tab(
                  child: Text(
                    "Patients",
                    // time,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    "Recent",
                    // time,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FirstTab(),
              SecondTab(),
            ],
          ),
        ),
      ),
    );
  }
}
