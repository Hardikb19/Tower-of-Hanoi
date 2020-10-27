import 'package:flutter/material.dart';

Route slideRoute({Widget page,Offset beginOffset, Offset endOffset,Curve animateCurve}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = beginOffset;
      var end = endOffset;
      var curve = animateCurve;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}