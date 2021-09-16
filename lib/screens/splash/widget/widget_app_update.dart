import 'package:flutter/material.dart';

import 'package:sense_battle/models/model_app_version.dart';

class AppUpdateWidget extends StatelessWidget {
  final AppVersionModel data;
  final Function? callback;

  const AppUpdateWidget({
    Key? key,
    required this.data,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
    );
  }
}
