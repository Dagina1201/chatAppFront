import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/controller/auth_controller.dart';
import 'package:front/data/data.dart';
// import 'package:front/data/data.dart';

import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/provider/provider.dart';

import 'package:front/routes.dart';
import 'package:get/get.dart';

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

  bool loading = false;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
  }

  void _handleGoogleSignIn() async {
    try {
      if (!loading) {
        GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
        await _auth
            .signInWithProvider(_googleAuthProvider)
            .then((UserCredential value) => {
                  controller.login(value.user!.email!, value.user!.photoURL!,
                      value.user!.displayName ?? value.user!.email!)
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
              child: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top + regular),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(loginProLogo),
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
                        space45,
                        MainButton(
                          borderRadius: borderRadius50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: white,
                                  child: Image.asset(
                                    loginLogo,
                                    height: 48,
                                  ),
                                ),
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
                        space45,
                        Image.asset(
                          imageLogo,
                          height: 36,
                        ),
                        space16,
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
