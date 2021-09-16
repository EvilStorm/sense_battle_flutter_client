import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromARGB(155, 68, 68, 68),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            '잠시만 기다려주세요.',
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
