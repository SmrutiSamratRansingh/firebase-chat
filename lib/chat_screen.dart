import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:push_app/aditya_test.dart';
import 'package:push_app/shadows.dart';
import 'package:push_app/textstyles.dart';
import 'package:push_app/widgets.dart';

import 'colors.dart';
import 'notification_service/notification_service.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController cntrlr = TextEditingController();
  var chats = FirebaseFirestore.instance.collection('chats');
  var chatDocId;
  final user1id = '12';
  final user2id = '14';
  var conState = 0;

  late String topic;

  Future<void> findCollection() async {
    //the problem is chatdocid takes too much time to generate and so initial data is blank screen
    print('no.1');
    QuerySnapshot querySnapshot = await chats
        .where('users', isEqualTo: {user1id: null, user2id: null})
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('no.2');
      chatDocId = querySnapshot.docs.single.id;
      // var docData = await chats.doc(chatDocId).get();
      // topic = docData.data()!['topic'];
      print('no.3');
      // print('Existstopic=$topic');
      // print(topic);
      await FirebaseMessaging.instance.subscribeToTopic(user1id);
      print('Existsdocumentids=$chatDocId');
    } else {
      var value = await chats.add({
        'users': {user1id: null, user2id: null}
      });
      print('no.2');

      chatDocId = value.id;
      print(chatDocId);
      // or use a unique id generator for a new topic.

      // topic = '$user1id' + '$user2id';
      // print('no.3');
      // print('createdTopic');
      // print(topic);
      // await chats.doc(chatDocId).set(({'topic': topic}));
      await FirebaseMessaging.instance.subscribeToTopic(user1id);

      print('Createddocumentid=$chatDocId');
    }

    // .then((QuerySnapshot querySnapshot) {
    //   if (querySnapshot.docs.isNotEmpty) {
    //     chatDocId = querySnapshot.docs.single.id;
    //     print('Existsdocumentids=$chatDocId');
    //   } else {
    //     chats.add({
    //       'users': {user1id: null, user2id: null}
    //     }).then((value) {
    //       chatDocId = value.id;
    //       print('Createddocumentid=$chatDocId');
    //     });
    //   }
    // });
    print('documentid');
    print(chatDocId);
  }

  @override
  void initState() {
    //FirebaseMessaging.instance.subscribeToTopic(user1id);
    findCollection();
    FirebaseMessaging.onMessage.listen((event) {
      print('onMessage');
      print(event.data['name']);
      print(event.notification);
      LocalNotificationService.createAndDisplayNotification(event);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      //this method is getting called when app starts/restarts even without clicking on notification.
      print('getInitialMessage');
      if (message != null) {
        print(message.data['name']);
        print(message.notification);
      }
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => InputPage()),
      //     (route) => false);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.notification != null) {
        print('onMessageOpenedApp');
        print(event.data);
        print(event.notification);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: Stack(
            children: [
              Container(
                child: AppBar(
                  leading: Container(
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: ClipRRect(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Transform.scale(
                            scale: 0.8,
                            child: Icon(Icons.arrow_left),
                            // child: SvgPicture.asset(
                            //   "images/bigleftArrow.svg",
                            //   color: gray5,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  toolbarHeight: MediaQuery.of(context).size.height * 0.15,
                  //title: ,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(32)),
                  gradient: LinearGradient(
                      colors: [kPrimary, kSecondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                ),
              ),
              Positioned(
                  left: 55,
                  top: 55,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            color: Colors.transparent,
                          ),
                          CircleAvatar(
                            radius: 24,
                            child: ClipOval(
                              child: Container(
                                color: Colors.red,
                              ),
                              // child: Image.asset(
                              //   'images/stackviewImage.jpg',
                              //   width: double.infinity,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kWhite,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  bottom: 2,
                                  right: 2,
                                  left: 2,
                                  child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kGreen,
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        ' Kristen Stewart',
                        style: MmmTextStyles.heading4(textColor: kLight2),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(Icons.video_call),
                          // child: SvgPicture.asset(
                          //   "images/video.svg",
                          //   height: MediaQuery.of(context).size.height * 0.04,
                          //   color: gray5,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Icon(Icons.call),
                            // child: SvgPicture.asset(
                            //   "images/call.svg",
                            //   color: gray5,
                            //   height: MediaQuery.of(context).size.height * 0.04,
                            //   fit: BoxFit.cover,
                            // ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
        //messages collection doesnot exist for a new pair of users and is created only while sending a message.
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: chats
                      .doc(chatDocId)
                      .collection('messages')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      print('no.4');
                      print('snapshot is nulls');
                    }
                    print('no.4');
                    print(snapshot);
                    if (!snapshot.hasData) {
                      return Expanded(
                          child: Center(
                              child: CircularProgressIndicator.adaptive()));
                    }
                    return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Timestamp now = snapshot.data!.docs[index]
                                  .data()['createdAt'];

                              String formattedTime =
                                  DateFormat.jm().format(now.toDate());
                              print(formattedTime);
                              // make sure this is senders id for correct ui
                              if (snapshot.data!.docs[index].data()['id'] ==
                                  user1id) {
                                return MmmWidgets.messageSent(
                                    snapshot.data!.docs[index].data()['text'],
                                    formattedTime);
                              } else {
                                return MmmWidgets.messageReceived(
                                    snapshot.data!.docs[index].data()['text'],
                                    formattedTime);
                              }
                            }));
                  }),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 70, maxHeight: 210),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(25, 15, 0, 18),
                  decoration: BoxDecoration(
                      boxShadow: [MmmShadow.textFieldMessaging()],
                      color: kWhite,
                      borderRadius: BorderRadius.circular(36)),
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                          controller: cntrlr,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Type your message',
                            hintStyle:
                                MmmTextStyles.bodyMedium(textColor: kBio),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          )),
                    ),
                    Positioned(
                        top: 5,
                        right: 60,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Icon(Icons.camera),
                              // child: SvgPicture.asset(
                              //   "images/camera.svg",
                              //   color: gray5,
                              //   height: 30,
                              //   fit: BoxFit.cover,
                              // ),
                            ))),
                    Positioned(
                        top: 5,
                        right: 20,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                sendMsg();
                              },
                              child: Icon(Icons.send),
                              // child: SvgPicture.asset(
                              //   "images/send.svg",
                              //   color: gray5,
                              //   height: 30,
                              //   fit: BoxFit.cover,
                              // ),
                            )))
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  Widget chatBubbles(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    print('here');
    print(snapshot);
    if (snapshot.data == null) {
      print('snapshot is null');
    }

    return Expanded(
        child: ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Timestamp now = snapshot.data!.docs[index].data()['createdAt'];

              String formattedTime = DateFormat.jm().format(now.toDate());
              print(formattedTime);
              // make sure this is senders id for correct ui
              if (snapshot.data!.docs[index].data()['id'] == user1id) {
                return MmmWidgets.messageSent(
                    snapshot.data!.docs[index].data()['text'], formattedTime);
              } else {
                return MmmWidgets.messageReceived(
                    snapshot.data!.docs[index].data()['text'], formattedTime);
              }
            }));
  }

  void sendMsg() {
    if (cntrlr.text.trim().length == 0) {
      return;
    }
    chats.doc(chatDocId).collection('messages').add(
        //id =senders id
        {
          'text': cntrlr.text,
          'createdAt': Timestamp.now(),
          'id': user1id,
          'topic': user2id
        });
    cntrlr.clear();
    // setState(() {
    //   cntrlr.text = '';
    // });
  }
}
