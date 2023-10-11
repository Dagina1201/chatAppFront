import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';
import 'package:front/pages/pages.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
  
      height: MediaQuery.of(context).size.height - most - MediaQuery.of(context).padding.top,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            space50,
            space4,

            HomeStatusView(
              list: [
                Diagram(
                  active: 0.1,
                  name: 'mon',
                  value: 0.5
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}