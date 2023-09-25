import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

const socketUrl = 'http://192.168.1.2:8080/ws';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StompClient? stompClient;

  Map<String, dynamic> userData = {
    "username": "",
    "receivername": "",
    "connected": false,
    "message": ""
  };
  Map<dynamic, List> privateChat = {};
  List<Map<dynamic, dynamic>> publicChat = [];
  String tab = "CHATROOM";
  void onConnect() {
    setState(() {
      userData["connected"] = true;
    });
    stompClient!.subscribe(
        destination: '/chatroom/public',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> result = json.decode(frame.body.toString());
            switch (result["status"]) {
              case "JOIN":
                if (privateChat[result["senderName"]].toString() == "") {
                  privateChat[result["senderName"]] = [];
                  setState(() {});
                }
                break;
              case "MESSAGE":
                setState(() {
                  publicChat.add(result);
                });
                break;
            }
          }
        });

    stompClient!.subscribe(
        destination: "/user/${userData["username"]}/private",
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> result = json.decode(frame.body.toString());
            if (privateChat[result["senderName"]] != null) {
              setState(() {
                privateChat[result["senderName"]]!.add(result);
              });
            } else {
              final list = [];
              list.add(result);

              setState(() {
                privateChat[result["senderName"]] = list;
              });
            }
          }
        });
    userJoin();
  }

  sendValue() {
    if (stompClient != null) {
      final chatMessage = {
        "senderName": userData["username"],
        "message": userData["message"],
        "status": "MESSAGE",
      };
      stompClient!
          .send(destination: "/app/message", body: json.encode(chatMessage));
      setState(() {
        userData["message"] = "";
      });
    }
  }

  sendPrivateValue() {
    if (stompClient != null) {
      final chatMessage = {
        "senderName": userData["username"],
        "receiverName": tab,
        "message": userData["message"],
        "status": "MESSAGE",
      };
      if (userData["username" != tab]) {
        privateChat[tab]!.add(chatMessage);
        setState(() {});
      }
      stompClient!.send(
          destination: "/app/private-message", body: json.encode(chatMessage));
      setState(() {
        userData["message"] = "";
      });
    }
  }

  userJoin() {
    final chatMessage = {"senderName": userData["username"], "status": "JOIN"};
    stompClient?.send(
        destination: "/app/message", body: json.encode(chatMessage));
  }

  connect() {
    stompClient = StompClient(
        config: StompConfig.sockJS(
      url: socketUrl,
      onConnect: (p0) {
        onConnect();
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
    ));

    stompClient!.activate();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (stompClient != null) {
      stompClient!.deactivate();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: userData["connected"]
              ? Column(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tab = "CHATROOM";
                            });
                          },
                          child: Text("Chatroom"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: privateChat.length,
                          itemBuilder: (context, index) {
                            String k = privateChat.keys.toList()[index];
                            return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    tab = k;
                                  });
                                },
                                child: Text(k));
                          },
                        )
                      ],
                    ),
                    tab == "CHATROOM"
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...publicChat.map((e) {
                                return Text(
                                    "${e["senderName"]}: ${e["message"]}");
                              }).toList(),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    userData["message"] = value;
                                  });
                                },
                              ),
                              ElevatedButton(
                                  onPressed: sendValue, child: Text("send"))
                            ],
                          )
                        : Column(mainAxisSize: MainAxisSize.min, children: [
                            ...privateChat[tab]?.map((e) {
                                  return Text(
                                      "${e["senderName"]}: ${e["message"]}");
                                }).toList() ??
                                [],
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  userData["message"] = value;
                                });
                              },
                            ),
                            ElevatedButton(
                                onPressed: sendPrivateValue,
                                child: Text("send"))
                          ])
                  ],
                )
              : Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          userData['username'] = value;
                        });
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          connect();
                        },
                        child: Text("connect"))
                  ],
                )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
