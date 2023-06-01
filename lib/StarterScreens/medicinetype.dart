import 'package:doctor/HelperStuff/circle_painter.dart';
import 'package:doctor/HelperStuff/rounded_rectangle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dept.dart';

class MedicineType extends StatelessWidget {
  const MedicineType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MedicineType1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MedicineType1 extends StatefulWidget {
  const MedicineType1({Key? key}) : super(key: key);

  @override
  State<MedicineType1> createState() => _MedicineTypeState();
}

class _MedicineTypeState extends State<MedicineType1> {
  // bool ispressed_eng = false;
  // bool ispressed_hindi = false;
  String dropdownvalue = 'Ayurvedic';
  var items = [
    // 'Select Medicine Type'
    'Ayurvedic',
    'Allopathic',
    'Homeopathic',
    'Yog-Sadhana',
    'Unani',
    'Naturopathic',
    'Physiotherapy',
    'Dental',
    'General Medicine',
    'Veterinary',
  ];

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Container(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(width, height),
              painter: CirclePainter(),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.088235 * height),
              child: const Text(
                "AURIGACARE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.159846 * height),
              child: const Text(
                '24/7 Video Consultations, \nexclusively on app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            Container(
              child: CustomPaint(
                size: Size(0.7805 * width, 0.3554 * height),
                painter: RoundedRectangle(),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.36828 * height),
              child: const Text(
                "Medicine Type",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.4 * height),
              child: const Text(
                "Please select the Style of Medicine",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.42 * height),
              alignment: Alignment.topCenter,
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.48 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dept()),
                  );
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff42ccc3),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27.5))),
                    side: const BorderSide(color: Color(0xffebebeb), width: 1),
                    padding: EdgeInsets.fromLTRB(0.208333 * width,
                        0.016624 * height, 0.205555 * width, 0.016624 * height),
                    minimumSize: Size(221, 55),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: const Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFfbfcff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
