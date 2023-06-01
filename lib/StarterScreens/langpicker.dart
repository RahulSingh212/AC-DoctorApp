import 'package:doctor/HelperStuff/circle_painter.dart';
import 'package:doctor/HelperStuff/rounded_rectangle.dart';
import 'package:doctor/StarterScreens/qualifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LangPage extends StatelessWidget {
  const LangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LangPage1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LangPage1 extends StatefulWidget {
  const LangPage1({Key? key}) : super(key: key);

  @override
  State<LangPage1> createState() => _LangPageState1();
}

class _LangPageState1 extends State<LangPage1> {
  bool ispressed_eng = false;
  bool ispressed_hindi = false;

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
                "Welcome!",
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
                "Select Language",
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
              padding: EdgeInsets.only(top: 0.45012 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Qualifications()),
                  );
                },
                style: TextButton.styleFrom(
                    backgroundColor: ispressed_eng
                        ? const Color(0xff42ccc3)
                        : const Color(0xFFfbfcff),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27.5))),
                    side: const BorderSide(color: Color(0xffebebeb), width: 1),
                    padding: EdgeInsets.fromLTRB(0.208333 * width,
                        0.016624 * height, 0.205555 * width, 0.016624 * height),
                    minimumSize: Size(221, 55),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  "English",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: ispressed_eng
                        ? const Color(0xFFfbfcff)
                        : const Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.56393 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ispressed_hindi = !ispressed_hindi;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor: ispressed_hindi
                        ? const Color(0xff42ccc3)
                        : const Color(0xFFfbfcff),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27.5))),
                    side: const BorderSide(color: Color(0xffebebeb), width: 1),
                    padding: EdgeInsets.fromLTRB(0.208333 * width,
                        0.016624 * height, 0.205555 * width, 0.016624 * height),
                    minimumSize: Size(221, 55),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  "हिन्दी",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: ispressed_hindi
                        ? const Color(0xFFfbfcff)
                        : const Color(0xff2c2c2c),
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
