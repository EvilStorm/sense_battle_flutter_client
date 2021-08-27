import 'package:flutter/material.dart';
import 'package:sense_battle/constants/constants.dart';

class TitleWithBack extends StatelessWidget {
  final String? title;
  final VoidCallback? callback;
  const TitleWithBack({
    Key? key, 
    this.title, 
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            callback?.call();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(Constants.sapceGap, Constants.sapceGap, Constants.sapceGap, Constants.sapceGap),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),
        ),
        SizedBox(width: Constants.sapceGap/2,),
        Text(
          title??"",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}