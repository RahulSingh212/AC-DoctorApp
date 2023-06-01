import 'package:doctor/settings.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff42ccc3),
                      radius: 62,
                      child: Text(
                        "Icon",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Settings(),
                        ),
                      );
                    },
                    iconSize: 30,
                    icon: const Icon(
                      Icons.settings,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 0.007 * height, right: 0.01 * height),
                width: width / 2,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff42ccc3),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Change Photo',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff42ccc3),
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.001 * height,
                    left: 0.02 * height,
                    right: 0.02 * height),
                child: TextFormField(
                  controller: TextEditingController(
                    text: "Dr. Vishnu Priya",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.01 * height,
                    left: 0.02 * height,
                    right: 0.02 * height),
                child: TextFormField(
                  controller: TextEditingController(
                    text: "New Delhi",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.05 * height,
                    left: 0.02 * height,
                    right: 0.02 * height),
                child: TextFormField(
                  controller: TextEditingController(
                    text: "Diabetologist",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Speciality',
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.05 * height,
                    left: 0.02 * height,
                    right: 0.02 * height),
                child: TextFormField(
                  controller: TextEditingController(text: "Female"),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Gender',
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.05 * height,
                    left: 0.02 * height,
                    right: 0.02 * height),
                child: TextFormField(
                  controller: TextEditingController(
                    text: "MBBS",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Educations Qualifications',
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(
                  top: 0.05 * height,
                  left: 0.02 * height,
                  right: 0.02 * height,
                ),
                child: TextFormField(
                  controller: TextEditingController(
                    text: "1832002, Karnataka Medical Council",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Registration Details',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
