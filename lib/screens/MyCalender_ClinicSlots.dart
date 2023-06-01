// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/doctorAuth_details.dart';
import '../providers/doctorUser_details.dart';

class MyCalendar_ClinicSlots extends StatefulWidget {
  static const routeName = '/doctor-my-calendar-clinic-slots-screen';

  late bool isboxSelected;
  late bool isclinic;
  late bool isvideo;
  late bool isRepeat;
  late bool issaved;
  late bool isclicked;

  MyCalendar_ClinicSlots({
    Key? key,
    this.isboxSelected = false,
    this.isclinic = true,
    this.isvideo = false,
    this.isRepeat = false,
    this.issaved = true,
    this.isclicked = false,
  });

  @override
  _MyCalendar_ClinicSlotsState createState() => _MyCalendar_ClinicSlotsState();
}

class _MyCalendar_ClinicSlotsState extends State<MyCalendar_ClinicSlots> {
  late TimeOfDay _timechosen1;
  late TimeOfDay _timechosen2;
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();
    _timechosen1 = TimeOfDay.now();
    _timechosen2 = TimeOfDay.now();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  // bool value1=false;
  Color blacText = Color(0xff789E9C);
  Color blacweek = Color(0xffDCE5E4);
  Color blacbox = Color(0xff789E9C);
  Map<String, bool> RepeatedDays = {
    "M": false,
    "T": false,
    "W": false,
    "Th": false,
    "F": false,
    "S": false,
    "Su": false
  };
  List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - 50;

    return Material(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.isclicked = !(widget.isclicked);
          });
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          margin: EdgeInsets.all(10),
          width: _width,
          // height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: widget.isclicked ? Color(0xff42ccc3) : blacbox,
                        value: widget.isclinic,
                        onChanged: (bool? value1) {
                          setState(
                            () {
                              if (widget.isclicked) {
                                widget.isclinic = value1!;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                      "Clinic",
                      style: TextStyle(
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor:
                            widget.isclicked ? Color(0xff42ccc3) : blacbox,
                        value: widget.isvideo,
                        onChanged: (bool? value1) {
                          setState(
                            () {
                              if (widget.isclicked) {
                                widget.isvideo = value1!;
                                widget.isclinic = value1;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 20,
                    ),
                    child: Text(
                      "Video",
                      style: TextStyle(
                        color: Color(
                          0xff2c2c2c,
                        ),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: AssetImage("assets/images/Calendar.png"),
                        //     fit: BoxFit.fill,
                        //
                        // )
                        ),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/Calendar.png",
                      ),
                      color: widget.isclicked ? null : blacbox,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.isclicked == true) pictime1();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffCDCDCD),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Text(
                        "${_timechosen1.hour}:${_timechosen1.minute}",
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffCDCDCD),
                        width: 1.5,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.isclicked == true) pictime2();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffCDCDCD),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Text(
                        "${_timechosen2.hour}:${_timechosen2.minute}",
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor:
                            widget.isclicked ? Color(0xff42ccc3) : blacbox,
                        value: widget.isRepeat,
                        onChanged: (bool? value1) {
                          setState(
                            () {
                              if (widget.isclicked) {
                                widget.isRepeat = value1!;
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                      "Repeat",
                      style: TextStyle(
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              allweakdays(),

              widget.isclicked
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          widget.issaved = true;
                          widget.isclicked = false;
                        });
                      },
                      child: Container(
                        width: _width,
                        margin: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff42CCC3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              //  Repeat
            ],
          ),
        ),
      ),
    );
  }

  Widget allweakdays() {
    return widget.isRepeat
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 60,
                child: Wrap(
                  children: List.generate(
                    7,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.isclicked) {
                              if (widget.issaved == false) {
                                RepeatedDays[days[index]] =
                                    !(RepeatedDays[days[index]]!);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.all(6),
                          child: Text(
                            days[index],
                            style: TextStyle(
                                fontSize: 15,
                                color: widget.isclicked
                                    ? Color(0xff42CCC3)
                                    : blacText),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffCDCDCD)),
                            borderRadius: BorderRadius.circular(10),
                            color: ((RepeatedDays[days[index]])!)
                                ? (widget.isclicked
                                    ? Color(0xffdef8f5)
                                    : Color(0xffDCE5E4))
                                : Color(0xffffffff),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              widget.issaved == false
                  ? Container(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Text(
                        "Please choose the time in which you are available in your Clinic.",
                        style: TextStyle(color: Color(0xff6C757D)),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          )
        : Container(
            height: 0,
          );
  }

  pictime1() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _timechosen1,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        _timechosen1 = time;
      });
    }
  }

  pictime2() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _timechosen2,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: Color(
              0xff42CCC3,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        _timechosen2 = time;
      });
    }
  }
}
