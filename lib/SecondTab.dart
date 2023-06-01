import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFf3f4f5),
      title: 'Flutter Widget stuff',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const WidgetPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  String name3 = "Ankita Sharma";
  String ailment = "Dust Allergy ,Mirago 50mg..";
  int number = 2;
  int number1 = 1;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f4),
      body: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                  top: 0.03 * height,
                  left: 0.04 * height,
                  right: 0.05 * height,
                  // right: 0.17 * height
                ),
                child: const Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Patients who ',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      TextSpan(
                        text: ' recently booked an appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(
                          text: ' will be shown here. ',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.only(
                  top: 0.03 * height,
                  left: 0.001 * height,
                  right: 0.35 * height,
                  // right: 0.17 * height
                ),
                child: const Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'July',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  top: 0.03 * height,
                  left: 0.001 * height,
                  right: 0.35 * height,
                  // right: 0.17 * height
                ),
                child: const Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'June',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 67,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.green,
                      // image: DecorationImage(
                      //   image: AssetImage("img/Doctor.jpg"),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 1000,
                              child: Row(
                                children: const [],
                              ),
                            ),
                            Container(
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 150),
                              child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff42ccc3),
                                    size: 35,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ailment,
                              style: const TextStyle(
                                  color: Color(0xff9E9E9E),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                      ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
