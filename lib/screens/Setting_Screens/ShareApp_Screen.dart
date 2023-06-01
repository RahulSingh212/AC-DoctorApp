// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers/doctorUser_details.dart';

class DoctorShareApplicationScreen extends StatefulWidget {
  static const routeName = '/doctor-share-application-screen';

  int pageIndex;

  DoctorShareApplicationScreen(
    this.pageIndex,
  );

  @override
  State<DoctorShareApplicationScreen> createState() =>
      _DoctorShareApplicationScreenState();
}

class _DoctorShareApplicationScreenState
    extends State<DoctorShareApplicationScreen> {
  bool isLangEnglish = true;
  String playstoreLink =
      "https://play.google.com/store/apps/details?id=com.aurigaCare.auriga_doctor";

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(
          isLangEnglish ? "Share App" : "ऐप शेयर करें",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(15),
            color: Colors.grey,
            onPressed: () async {
              await Share.share(playstoreLink);
            },
            icon: Icon(
              Icons.share,
            ),
          ),
          Align(
            child: InkWell(
              onTap: () async {
                await Share.share(playstoreLink);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Colors.grey.shade300,
                ),
                width: screenWidth * 0.95,
                child: Text(
                  "Share",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
