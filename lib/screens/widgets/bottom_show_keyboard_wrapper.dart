import 'package:flutter/material.dart';
import 'package:sense_battle/constants/constants.dart';

class BottomKeyboardShowWrapper extends StatefulWidget {
  final double height;
  final Widget widget;

  const BottomKeyboardShowWrapper({
    Key? key,
    required this.height,
    required this.widget,
  }) : super(key: key);

  @override
  _BottomKeyboardShowWrapperState createState() => _BottomKeyboardShowWrapperState();
}

class _BottomKeyboardShowWrapperState extends State<BottomKeyboardShowWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: [
          Container(
              height: widget.height,
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap),
                child: widget.widget,
              )),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
