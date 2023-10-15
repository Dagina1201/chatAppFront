import 'package:flutter/material.dart';
import 'package:front/global/constant/colors.dart';

class Txt extends StatelessWidget {
  const Txt({super.key, required this.text,this.child, this.fit = BoxFit.contain, this.style});
  final String text;
  final BoxFit fit;
  final TextStyle? style;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return FittedBox(fit:BoxFit.fitWidth,
      child: child ?? Text(text, style: style ?? Theme.of(context).textTheme.bodyMedium,),
  );
  }
}


class RichTxt extends StatelessWidget {
  const RichTxt({super.key,this.style, this.labelStyle,  required this.label, required this.text});
  final String text;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final List<String> label;
  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(text: text, style: style ?? Theme.of(context).textTheme.bodyLarge!.copyWith(color: textBlack, fontWeight: FontWeight.w600), children: label.map((e) => TextSpan(text: e, style: labelStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(color: textGray))).toList()), );
  }
}