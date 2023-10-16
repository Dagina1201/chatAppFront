import 'package:flutter/material.dart';

import 'package:front/global/global.dart';

class MainButton extends StatefulWidget {
  const MainButton({super.key,  this.label, this.child,this.shadow = true, this.shadowColor = orangeShadow, this.color = orange, required this.onPressed, 
  this.textColor = black,
  this.borderRadius = borderRadius15,
  this.width,
  this.padding
  });
  final String? label;
  final Function() onPressed;
  final Color color;
  final Color shadowColor;
  final Widget? child;
  final Color textColor;
  final double borderRadius;
  final double? width;
  final EdgeInsets? padding;
  final bool shadow;
  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
 double dy = 4.0;

  @override
  Widget build(BuildContext context) {
    return 
     GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed,
        child: AnimatedContainer(
          width: widget.width,
          margin: EdgeInsets.only(bottom: dy == 4 ? 8 : 0, top: dy == 4 ? 0 : 8),
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
          padding: widget.padding ??  const EdgeInsets.symmetric(horizontal: regular, vertical: small),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              if(widget.shadow)
              BoxShadow(
                offset: Offset(0, dy),
                blurRadius: 0,
                spreadRadius: 0,
                color: widget.shadowColor,
                
              )
            ]
            
          ),
          child: widget.child ?? Text( widget.label ?? "",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: widget.textColor, ),)
        ),
      
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      dy = 0.0;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      dy = 4.0;
    });
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      dy = 4.0;
    });
  }
}