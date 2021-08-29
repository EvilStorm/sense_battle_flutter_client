import 'package:flutter/material.dart';
import 'package:sense_battle/constants/constants.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? callback;
  const CircleButton({ 
    Key? key, 
    required this.child, 
    this.callback, 
    this.backgroundColor 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(Constants.sapceGap/2),
        primary: backgroundColor??Colors.white,
      ),
      onPressed: (){
        callback?.call();
      }, 
      child: child
    );
  }
}