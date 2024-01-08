import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/controller/auth_controller.dart';
// import 'package:front/data/data.dart';

import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// const List<String> scopes = <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly',
// ];
// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId

//   // clientId:
//   //     'y1045595376762-ulpr8plrgagkvo0v04kbtdsdvjnou31a.apps.googleusercontent.com',
//   scopes: scopes,
// );

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final loginKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  final Api api = Api();
  final Util util = Util();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool loading = false;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      print(event);
      setState(() {
        _user = event;
      });
    });
  }

  void _handleGoogleSignIn() {
    try {
      if (!loading) {
        GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
        _auth.signInWithProvider(_googleAuthProvider).then((value) => {
              print('res $value'),
              // Get.toNamed(Routes.auth)
              setState(() {
                _user = value.user;
                loading = false;
              })
            });
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      print('error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(onTap: () => {}, child: space36),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              left: regular,
              right: regular,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Image.asset(loginProLogo),
                  if (_user != null)
                    ElevatedButton(onPressed: () {
                      Get.toNamed(Routes.home);
                    }, child: Text(_user?.email ?? '')),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          lorem,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: subTextColor),
                        ),
                      ),
                      space58,
                      MainButton(
                        borderRadius: borderRadius50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              imageLogo,
                              height: 48,
                            ),
                            space13,
                            Text(
                              signGoogle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: white),
                            )
                          ],
                        ),
                        onPressed: () {
                          _handleGoogleSignIn();
                        },
                      ),
                      space58,
                      Image.asset(
                        imageLogo,
                        height: 24,
                      ),
                      space16,
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
