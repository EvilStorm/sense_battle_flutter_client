import 'package:flutter/material.dart';
import 'package:sense_battle/screens/widgets/dialog_box.dart';

class DialogButton extends StatelessWidget {
  final ButtonPosition position;
  final String title;
  final VoidCallback? callback;
  const DialogButton({Key? key, required this.position, required this.title, this.callback}) : super(key: key);

  BoxDecoration getDialogDecoration(
    BuildContext context,
    ButtonPosition position,
  ) {
    late BoxDecoration btnStyle;

    switch (position) {
      case ButtonPosition.Center:
        btnStyle = BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
          color: Theme.of(context).accentColor,
        );
        break;
      case ButtonPosition.Left:
        btnStyle = BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0)),
          color: Theme.of(context).splashColor,
        );
        break;
      case ButtonPosition.Right:
        btnStyle = BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
          color: Theme.of(context).accentColor,
        );
        break;
      default:
        btnStyle = BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
          color: Theme.of(context).accentColor,
        );
    }
    return btnStyle;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback?.call(),
      child: Container(
        height: 60,
        decoration: getDialogDecoration(context, position),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.button!.apply(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
