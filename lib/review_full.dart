import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourmate1/Register.dart';
import 'package:tourmate1/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  late String date;
  var reviewStream;
  var reviewDisplayStream;
  getData() async {
    Map data;
    Response response =
        await get(Uri.http('worldtimeapi.org', '/api/timezone/Asia/Karachi'));
    await (data = jsonDecode(response.body));
    date = data['datetime'].substring(0, 19);
    // time = data['datetime'].substring(11, 19);
    return data['datetime'].substring(0, 10);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";
  var user;
  @override
  void initState() {
    super.initState();
    getData();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('Kas loginn nadi yar....');
      } else {
        final User? user = auth.currentUser;
        final uid = user!.uid;
        userId = uid;
      }
      reviewDisplayStream = FirebaseFirestore.instance
          .collection("customer")
          .where("uid", isEqualTo: userId)
          .snapshots();
    });
    reviewStream = reviewStreamF();
  }

  // Stream<QuerySnapshot> reviewDisplayStream = FirebaseFirestore.instance
  //     .collection("customer")
  //     .where("uid", isEqualTo: userId)
  //     .snapshots();
  Stream<QuerySnapshot> reviewStreamF() => FirebaseFirestore.instance
      .collection("Review")
      .orderBy("date and time", descending: false)
      .snapshots();

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Builder(builder: (context) {
              return Container(
                height: 145,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "To make a review, you need to be Logged In",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => register()));
                      },
                      child: const Text('Sign Up'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("or", style: TextStyle(color: Colors.grey)),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            child: Text("Login",
                                style: TextStyle(color: Colors.blue))),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] == '' ||
                              data[i]['pic'] == null
                          ? "https://firebasestorage.googleapis.com/v0/b/fir-prictice-81c0f.appspot.com/o/profile.png?alt=media&token=8fdf702b-8f5a-4a12-b46a-091758812a5d"
                          : data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  Widget logincommentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(height: 5),
        Center(
            child: TextButton(
          style: TextButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue)),
          child: Text("Rate Your Experience"),
          onPressed: () {
            createAlertDialog(context);
          },
        )),
        SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.black,
              )),
          title: Text(
            "Review Page",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: StreamBuilder(
              stream: reviewStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final List reviewList = [];
                snapshot.data!.docs.map((DocumentSnapshot e) {
                  Map dataList = e.data() as Map<String, dynamic>;
                  reviewList.add(dataList);
                }).toList();
                return SafeArea(
                  child: userId == ""
                      ? logincommentChild(reviewList)
                      : StreamBuilder(
                          stream: reviewDisplayStream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final List reviewDisplayList = [];
                            snapshot.data!.docs.map((DocumentSnapshot e) {
                              Map dataList = e.data() as Map<String, dynamic>;
                              reviewDisplayList.add(dataList);
                            }).toList();
                            return Container(
                                child: CommentBox(
                              userImage: reviewDisplayList[0]['image'] != ''
                                  ? reviewDisplayList[0]['image']
                                  : "https://firebasestorage.googleapis.com/v0/b/fir-prictice-81c0f.appspot.com/o/profile.png?alt=media&token=8fdf702b-8f5a-4a12-b46a-091758812a5d",
                              child: commentChild(
                                  reviewList), //display review of cusotmer....
                              labelText: 'Write a breif review...',
                              withBorder: true,
                              errorText: 'Review cannot be blank',
                              sendButtonMethod: () {
                                if (formKey.currentState!.validate()) {
                                  print(commentController.text);
                                  setState(() {
                                    Map<String, dynamic> value = {
                                      'name': reviewDisplayList[0]['name'],
                                      'pic': reviewDisplayList[0]['image'] != ''
                                          ? reviewDisplayList[0]['image']
                                          : "https://firebasestorage.googleapis.com/v0/b/fir-prictice-81c0f.appspot.com/o/profile.png?alt=media&token=8fdf702b-8f5a-4a12-b46a-091758812a5d",
                                      'message': commentController.text,
                                      'date and time': date
                                    };
                                    FirebaseFirestore.instance
                                        .collection("Review")
                                        .add(value);
                                  });
                                  commentController.clear();
                                  FocusScope.of(context).unfocus();
                                } else {
                                  print("Not validated");
                                }
                              },
                              formKey: formKey,
                              commentController: commentController,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              sendWidget: Icon(Icons.send_sharp,
                                  size: 24, color: Colors.white),
                            ));
                          }),
                );
              }),
        ),
        // bottomNavigationBar: footer(
        //   tabIndex: 2,
        // ),
      ),
    );
  }
}
