import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardWidget extends StatefulWidget {
  final Widget child;

  const KeyboardWidget({Key? key, required this.child}) : super(key: key);

  @override
  _KeyboardWidgetState createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  @override
  void initState() {
    super.initState();

    // var keyboardVisibilityController = KeyboardVisibilityController();
    // keyboardVisibilityController.onChange.listen((bool visible) {
    //   if(!visible) {
    //     SystemChrome.setEnabledSystemUIOverlays([]);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: widget.child,
      ),
    );
  }
}
