import 'package:flutter/material.dart';

import 'package:front/controller/controllers.dart';
import 'package:front/data/model/model.dart';

import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/provider/provider.dart';

import 'package:front/routes.dart';
import 'package:get/get.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final controller = Get.put(SurveyController());
  final Api api = Api();
  final Util util = Util();
  List<Survey> data = [];
  bool loading = false;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final res = await api.getSurvey();
    res.fold((l) => null, (r) => {data = r, setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(onTap: () => {}, child: space36),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              left: regular,
              right: regular,
            ),
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + regular),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.surveyDetail,
                                arguments: [data[index].sId!]);
                          },
                          child: Text(data[index].title ?? ''),
                        );
                      })),
            )),
      ),
    );
  }
}
