import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/controller/auth_controller.dart';
import 'package:front/data/data.dart';

import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/provider/provider.dart';

import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];
GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId

  // clientId:
  //     'y1045595376762-ulpr8plrgagkvo0v04kbtdsdvjnou31a.apps.googleusercontent.com',
  scopes: scopes,
);

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

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((event) async {
      setState(() {
        _currentUser = event!;
      });
      if (_currentUser != null) {
        final res = await api.login(User(
          profileImg: _currentUser!.photoUrl ?? '',
          username: _currentUser!.displayName ?? '',
          email: _currentUser!.email,
        ));
        res.fold(
            (l) => util.mainSnackbar(l, SnackbarType.error),
            (r) => {
                  controller.login(r.data as String),
                  util.mainSnackbar(r.message!, SnackbarType.success)
                });
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => print(value));
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      _googleSignIn.disconnect();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(onTap: () => {}, child: space36),
        body: SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              left: regular,
              right: regular,
              top: MediaQuery.of(context).padding.top + 65,
              bottom: medium),
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
                      _handleSignIn();
                    },
                  ),
                  space58,
                  Image.asset(
                    imageLogo,
                    height: 24,
                  )
                ],
              )
            ],
          )),
    ));
  }
}
