import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sense_battle/models/model_term.dart';

class TermWidget extends StatelessWidget {
  final TermModel data;
  final Function? callback;
  final bool necessary;

  TermWidget({Key? key, required this.data, this.necessary = false, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 18),
          Flexible(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Text('이용약관', textAlign: TextAlign.end, textDirection: TextDirection.rtl, style: Theme.of(context).textTheme.headline6),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
                      margin: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Html(
                          data: data.term,
                        ),
                      )),
                )
              ]),
              flex: 1),
          SizedBox(height: 36),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('정보동의', style: Theme.of(context).textTheme.headline6),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
                      margin: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        child: Html(
                          data: data.userTerm,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              flex: 1),
          ButtonBar(
            children: <Widget>[
              Visibility(
                visible: !necessary,
                child: FlatButton(
                  child: Text(
                    '종료',
                    style: Theme.of(context).textTheme.button!.copyWith(color: Colors.red),
                  ),
                  onPressed: () => callback?.call(-1),
                ),
              ),
              FlatButton(
                child: Text(necessary ? '확인' : '동의', style: Theme.of(context).textTheme.button),
                onPressed: () => callback?.call(data.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
