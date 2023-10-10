import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  const Txt({super.key, required this.text, this.fit = BoxFit.contain, this.style});
  final String text;
  final BoxFit fit;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return FittedBox(fit:BoxFit.fitWidth,
      child: Text(text, style: style ?? Theme.of(context).textTheme.bodyMedium,),
  );
  }
}