import 'package:flutter/material.dart';
import 'package:sense_battle/constants/constants.dart';

class HorizentalBorder extends StatelessWidget {
  const HorizentalBorder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Divider(
          color: Colors.white,
          height: 1.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 2),
        child: Text(
          'OR',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      Expanded(
        child: Divider(
          color: Colors.white,
          height: 1.0,
        ),
      ),
    ]);
  }
}
