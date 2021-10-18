import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourmate1/teamMembersClass.dart';
import 'package:url_launcher/url_launcher.dart';
import 'footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'drawer.dart';

class TeamMembers extends StatefulWidget {
  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  List<Quotes> teamList = [
    Quotes(
        name: "Mr. Fahim Ullah",
        email: "fahimullah1888@gmail.com",
        image: 'assets/images/fahim1.jpg',
        rank: 'CEO',
        contact: '03428270869',
        description:
            'Fahim Ullah is an entrepreneur , speaker and YouTuber  . He is the founder and CEO at TourMate',
        facebook: 'Fahim Ullah Official',
        facebookLink: 'https://www.facebook.com/fahimullah.fahmy',
        dashes: 40),
    Quotes(
        name: "Mr. Saad Khan",
        email: "saadk9666@gmail.com",
        image: 'assets/images/saad.jpeg',
        rank: 'CO-Founder',
        contact: '03409340543',
        description:
            'What Is Chief Executive Officer (CEO)?A chief executive officer (CEO) is the highest-ranking executive in a company, whose primary responsibilities include making major corporate decisions, managing the overall operations and resources of a company, acting as the main point of communication between the board of directors (the board) and corporate operations and being the public face of the company. A CEO is elected by the board and its shareholders.',
        facebook: 'Itz Saad khanz',
        facebookLink: 'https://www.facebook.com/profile.php?id=100010622133903',
        dashes: 40),
    Quotes(
        name: "Mr. Sayed Suliman",
        email: "sulimansayed003@gmail.com",
        image: 'assets/images/Suliman.jpg',
        rank: 'App Developer',
        contact: '03469794125',
        description:
            'What Is Chief Executive Officer (CEO)?A chief executive officer (CEO) is the highest-ranking executive in a company, whose primary responsibilities include making major corporate decisions, managing the overall operations and resources of a company, acting as the main point of communication between the board of directors (the board) and corporate operations and being the public face of the company. A CEO is elected by the board and its shareholders.',
        facebook: 'Sayed Suliman',
        facebookLink: 'https://www.facebook.com/Mr.Alpha125',
        dashes: 40),
    Quotes(
        name: "Mr. Suliman Khan",
        email: "sulimank418@gmail.com",
        image: 'assets/images/Shiekh.jpg',
        rank: 'App Developer',
        contact: '03489358689',
        description:
            'What Is Chief Executive Officer (CEO)?A chief executive officer (CEO) is the highest-ranking executive in a company, whose primary responsibilities include making major corporate decisions, managing the overall operations and resources of a company, acting as the main point of communication between the board of directors (the board) and corporate operations and being the public face of the company. A CEO is elected by the board and its shareholders.',
        facebook: 'Suliman Khan',
        facebookLink: 'https://www.facebook.com/profile.php?id=100007348177845',
        dashes: 40),
    Quotes(
        name: "Mr. Bashir Ullah",
        email: "bashirshamakhail@gmail.com",
        image: 'assets/images/bashir.jpg',
        rank: 'Graphic Designer',
        contact: '03470191817',
        description:
            'What Is Chief Executive Officer (CEO)?A chief executive officer (CEO) is the highest-ranking executive in a company, whose primary responsibilities include making major corporate decisions, managing the overall operations and resources of a company, acting as the main point of communication between the board of directors (the board) and corporate operations and being the public face of the company. A CEO is elected by the board and its shareholders.',
        facebook: 'Bashir ShamaKhail',
        facebookLink: 'https://www.facebook.com/bashir.shamakhail',
        dashes: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        endDrawer: MyDrawer(),
        bottomNavigationBar: footer(),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Our Team",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
            )),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: teamList.map((e) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      color: Colors.grey[200],
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(e.image),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    e.rank,
                                    style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: DottedLine(
                                      direction: Axis.horizontal,
                                      dashLength: 10,
                                      lineLength: e.dashes,
                                      dashColor: Colors.black,
                                      lineThickness: 4,
                                      dashGapRadius: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.description),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          e.contact.toString());
                                                },
                                                child: Icon(
                                                    Icons.call_end_sharp,
                                                    size: 24,
                                                    color: Colors.green),
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(CircleBorder()),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets.all(
                                                                8)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                              ),
                                              SizedBox(width: 15),
                                              GestureDetector(
                                                onTap: () async {
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          e.contact.toString());
                                                },
                                                child: Text(e.contact,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => emailLaunch(
                                                    toEmail: e.email),
                                                child: Icon(
                                                  Icons.mail,
                                                  size: 24,
                                                  color: Colors.red,
                                                ),
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(CircleBorder()),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets.all(
                                                                8)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                              ),
                                              SizedBox(width: 15),
                                              GestureDetector(
                                                onTap: () => emailLaunch(
                                                    toEmail: e.email),
                                                child: Text(e.email,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  launch(e.facebookLink);
                                                },
                                                child: Icon(
                                                    FontAwesomeIcons.facebookF,
                                                    size: 24,
                                                    color: Colors.blue[900]),
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(CircleBorder()),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets.all(
                                                                8)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                              ),
                                              SizedBox(width: 15),
                                              GestureDetector(
                                                onTap: () {
                                                  launch(e.facebookLink);
                                                },
                                                child: Text(e.facebook,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ))),
      ),
    );

    // child: Container(

    // ),
  }
}

Future emailLaunch({
  required String toEmail,
}) async {
  final url = 'mailto:$toEmail';
  if (await canLaunch(url)) {
    await launch(url);
  }
}
