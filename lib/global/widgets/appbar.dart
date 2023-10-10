import 'package:flutter/material.dart';

import 'package:front/global/global.dart';

const double kToolbarHeight = 65.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.padding = 12.0,
    required this.onTap,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final double padding;

  final Function() onTap;
  final Widget? child;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + regular),
        padding: const EdgeInsets.symmetric(horizontal: regular),
        child: child ??
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: <Widget>[
                 MainButton(
                  width: 32,
                padding: const EdgeInsets.all(small),
                onPressed: onTap,
                // color: Colors.transparent,
                // shadowColor: Colors.transparent,
                borderRadius: 100,
                child: const Icon(Icons.arrow_back_ios_new, size: 20, color: black,),
              
          ),
            const SizedBox()
              ],
            ));
  }
}
