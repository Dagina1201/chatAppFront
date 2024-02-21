import 'package:flutter/material.dart';

import 'package:front/controller/controllers.dart';
import 'package:front/data/model/model.dart';

import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/provider/provider.dart';

import 'package:front/routes.dart';
import 'package:get/get.dart';

class SurveyDetailView extends StatefulWidget {
  const SurveyDetailView({super.key, required this.id});
  final String id;
  @override
  State<SurveyDetailView> createState() => _SurveyDetailViewState();
}

class _SurveyDetailViewState extends State<SurveyDetailView> {
  final controller = Get.put(SurveyController());
  final Api api = Api();
  final Util util = Util();
  Survey? data;
  bool loading = false;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final res = await api.getSurveyById(widget.id);
    res.fold((l) => null, (r) => {data = r, setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(onTap: () => {Get.back()}),
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
                  child: data != null &&
                          data?.values != null &&
                          data!.values!.isNotEmpty
                      ? ListView.builder(
                          itemCount: data!.values!.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Text(data?.values?[index].question ?? '');
                          }))
                      : const SizedBox()),
            )),
      ),
    );
  }
}
