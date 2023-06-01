import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({Key? key}) : super(key: key);

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
  String search = "lololl";

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
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                      right: 20,
                    ),
                    height: 39,
                    width: width / 4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          primary: const Color(0xff42ccc3),
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35,
                        )),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Search',
                  hintText: 'Type the name you want to Search ',
                ),
                onChanged: (text) {
                  search = text;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 0.02 * height,
                left: 0.001 * height,
                right: 0.35 * height,
              ),
              child: const Text.rich(
                TextSpan(
                  text: 'ACTIVE',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.02),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 59,
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
                    // child: Icons.search,
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
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 10),
                              child: CircleAvatar(
                                backgroundColor: Color(0xff42ccc3),
                                radius: 15,
                                child: Text((number).toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
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
              height: 59,
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
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 10),
                              child: CircleAvatar(
                                backgroundColor: Color(0xff42ccc3),
                                radius: 15,
                                child: Text((number1).toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
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
                top: 0.01 * height,
                left: 0.001 * height,
                right: 0.38 * height,
              ),
              child: const Text.rich(
                TextSpan(
                  text: 'A - D',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.02),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 59,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding:
                            //   const EdgeInsets.only(left: 150, top: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xff42ccc3),
                            //     radius: 15,
                            //     child: Text((number1).toString(),
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w600)),
                            //   ),
                            // ),
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
              height: 59,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding:
                            //   const EdgeInsets.only(left: 150, top: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xff42ccc3),
                            //     radius: 15,
                            //     child: Text((number1).toString(),
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w600)),
                            //   ),
                            // ),
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
              height: 59,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding:
                            //   const EdgeInsets.only(left: 150, top: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xff42ccc3),
                            //     radius: 15,
                            //     child: Text((number1).toString(),
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w600)),
                            //   ),
                            // ),
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
                // top: 0.03 * height,
                left: 0.001 * height,
                right: 0.38 * height,
              ),
              child: const Text.rich(
                TextSpan(
                  text: 'E - H',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.02),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 10),
              height: 59,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding:
                            //   const EdgeInsets.only(left: 150, top: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xff42ccc3),
                            //     radius: 15,
                            //     child: Text((number1).toString(),
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w600)),
                            //   ),
                            // ),
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
              height: 59,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                name3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding:
                            //   const EdgeInsets.only(left: 150, top: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xff42ccc3),
                            //     radius: 15,
                            //     child: Text((number1).toString(),
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.w600)),
                            //   ),
                            // ),
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
            // Container(
            //   margin: const EdgeInsets.only(
            //       left: 20, right: 20, bottom: 5, top: 10),
            //   height: 59,
            //   width: width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.white,
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 36,
            //         width: 36,
            //         margin: const EdgeInsets.only(
            //           left: 10,
            //         ),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(7.5),
            //           color: Colors.green,
            //           // image: DecorationImage(
            //           //   image: AssetImage("img/Doctor.jpg"),
            //           //   fit: BoxFit.cover,
            //           // )
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 SizedBox(
            //                   width: width / 1000,
            //                   child: Row(
            //                     children: const [],
            //                   ),
            //                 ),
            //                 Container(
            //                   padding: const EdgeInsets.only(top: 10),
            //                   child: Text(
            //                     name3,
            //                     style: const TextStyle(
            //                         fontWeight: FontWeight.w700, fontSize: 18),
            //                   ),
            //                 ),
            //
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 1,
            //             ),
            //             const SizedBox(
            //               height: 1,
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   ailment,
            //                   style: const TextStyle(
            //                       color: Color(0xff9E9E9E),
            //                       fontWeight: FontWeight.w500),
            //                 ),
            //                 const SizedBox(
            //                   height: 1,
            //                 ),
            //                 const SizedBox(
            //                   width: 1,
            //                 ),
            //               ],
            //             ),
            //           ])
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
