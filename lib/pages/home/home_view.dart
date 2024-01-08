import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';
import 'package:front/global/global.dart';
import 'package:front/pages/pages.dart';
import 'package:front/provider/provider.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String filteredChatType = chatFilters[0];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        space50,
        space4,
        // HomeStatusView(
        //   list: diagramValues,
        // ),
        space45,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichTxt(label: [
              '${DateTime.now().day} ${DateFormat.MMMM().format(DateTime.now())}'
            ], text: '$today, '),
            DropdownButton(
              value: filteredChatType,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: chatFilters.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: dropGray),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  filteredChatType = newValue!;
                });
              },
            ),
          ],
        ),
        space20,
        ...groups.map((e) {
          int index = groups.indexOf(e);
          return StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (BuildContext context, AsyncSnapshot snapshop) {
                return Text(snapshop.data.toString());
                //   return ChatCard(
                //   data: e,
                //   index: index,
                //   onPressed: (v) {
                //     print(v);
                //     print(snapsho)
                //   },
                // );
              });
        }),
        space20
      ],
    ));
  }
}
