import 'package:flutter/material.dart';
import 'package:front/global/constant/constant.dart';


class MainContainer extends StatefulWidget {
  const MainContainer({super.key,this.margin, required this.child,this.animate = true, this.padding , this.color = blue, this.index = 0, this.borderRadius, this.borderRadiusValue = borderRadius16, this.shadowColor, this.shadow = false});
  final Color color;
  final double borderRadiusValue;
  final Color? shadowColor;
  final bool shadow;
  final int index;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool animate ;
  final BorderRadius? borderRadius;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  bool animated = false;
  @override
  void initState() {
    super.initState();
   if(widget.animate) {
     Future.delayed(Duration(milliseconds: widget.index  * 300)).then((value) => {
    setState(() {
      animated = true;
    })
    });
      
   }
  }
 
 @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(opacity: animated || !widget.animate ? 1 : 0, duration: const Duration(milliseconds: 300),  child: AnimatedContainer(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: tall, vertical: 14),
      duration: const Duration(milliseconds: 300 ),
    width: double.infinity,
      margin: widget.margin ?? EdgeInsets.only(top: animated || !widget.animate ? 0 : 10),
      decoration: BoxDecoration(
        
        color:widget.color ,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.borderRadiusValue),
        boxShadow: [
          if(widget.shadow)
          BoxShadow(
            color: widget.shadowColor ?? blueShadow,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 4)
          ),
          
        ]
      ),
      child: widget.child,
    ),) ;
  }
}