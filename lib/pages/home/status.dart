import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';

class HomeStatusView extends StatelessWidget {
  const HomeStatusView({super.key, required this.list });
  final List<Diagram> list ; 
  @override
  Widget build(BuildContext context) {
    
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
   
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: MainContainer(
                borderRadiusValue: 0,
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                child: Column(
                 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                         MainContainer(
                          color: waterBlue,
                             animate: false,
                          padding: const EdgeInsets.symmetric(horizontal: medium, vertical: regular ),
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.stretch,
                                       children: <Widget>[
                                         
                                         Text(upComing, style: Theme.of(context).textTheme.labelMedium,),
                                         space6,
                                         Txt(text: '50'),
                                         space6,
                                         Txt(text: newChats, style: Theme.of(context).textTheme.labelMedium,),
                                       ],
                                     ),
                                     
                                   )   ,
                        space13,
                        MainContainer(
                          animate: false,
                                color: orange,
                                padding: const EdgeInsets.symmetric(horizontal: tall, vertical: wide ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(semesterOff, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white),),
                            space6,
                            TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, value, child) {
                              
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: CustomPaint(
                                painter: BorderPainter(currentState: value),
                                child: Container(
                                  alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: regular),
                                  child: Txt(child: RichText(
                                    text: TextSpan(text: '73', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: white), children: [
                                      TextSpan(text: '%', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white))
                                    ]),
                                    
                                                
                                  ), text: '',)
                                )
                              ),
                            ),
                          );
                        }
                            ),
                            space6,
                            Text(completed, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: white),),
                          ],
                        ),
                                    
                                        )   
                  ],
                ),
              ),
            ),
            space13,
            Expanded(
              flex: 2,
              child: MainContainer(
                padding: const EdgeInsets.symmetric(vertical: medium, horizontal: small),
                child: Column(
                // mainAxisSize: MainAxisSize.min,
          
                children: <Widget>[
          Text(weeklyActivity, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),),
          space22,              
          AspectRatio(aspectRatio: 0.95, child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: list.map((e) {
                int index = list.indexOf(e);
                return DiagramAnimation(data: e, index: index,
            
                
              );
              }).toList(),
            )
          ),),
          space9,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list.map((e) {
              final i = list.indexOf(e);
             
             return AnimatedOpacity(opacity:  1 , duration: Duration(milliseconds: 500 * (i + 1)), child:  Text( e.name!, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: white)),);
            }).toList(),
          )
                ],
              )))
          ],
        ),
      ),
    );
  }
}
class DiagramAnimation extends StatelessWidget {
  const DiagramAnimation({super.key, required this.data, this.index  = 0});
  final Diagram data;
  
  final int index;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(tween: Tween(begin: 0.0, end: 1.0), duration: Duration(milliseconds: 500 * (index + 1)), builder: (context, currentState, child) {
            
                  return Container(
                
                    height: double.infinity,
                    width: 29,
                    child: 
                         CustomPaint(
                                          painter: DiagramPainter(active: data.active!, currentState: currentState, value: data.value!),
                                          child: Container(),
                                          
                                     
                        ),
             
                      
                    
                  );
                },);
  }
}
class BorderPainter extends CustomPainter {

  final double currentState;

  BorderPainter({required this.currentState});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5;
    Rect rect = const Offset(0,0) & Size(size.width, size.width);

    final completed= Paint()
      ..color = white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final uncompleted= Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;


      double startAngle = pi / 2;
      double sweepAmount = currentState * pi;

      canvas.drawArc(rect, startAngle, sweepAmount, false, completed);
      canvas.drawArc(rect, startAngle , pi * 2, false, uncompleted);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class DiagramPainter extends CustomPainter {

  final double currentState;
  final double active;
  final double value;

  DiagramPainter({required this.currentState, required this.active, required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 15;

    final completed= Paint()
      ..color = orange
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final uncompleted= Paint()
      ..color = waterBlue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;


     canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(8,size.height *(1-value),15,size.height * value / 1 * currentState,),Radius.circular(50.0)),uncompleted);
     if(active > 0) canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(8,size.height *(1-value),15,size.height * value / 1 * active * currentState,),Radius.circular(50.0)),completed);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}