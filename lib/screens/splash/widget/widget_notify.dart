import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sense_battle/models/model_notify.dart';
import 'package:sense_battle/utils/AboutDate.dart';

class NotifyWidget extends StatelessWidget {

  final List<NotifyModel> data;
  final Function? callback;
  final bool showTitle;

  const NotifyWidget({
      Key? key,
      required this.data,
      this.showTitle = true,
      this.callback,
  }): super(key: key);
  

  @override
  Widget build(BuildContext context) {
    int seq = 0;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: showTitle,
            child: Column(
              children: <Widget>[
                SizedBox(height: 44),
                Text('공지사항', style: Theme.of(context).textTheme.headline6),
              ],              
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount:data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                if(index == 0) {
                  seq = item.id;
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0,0.0, 0.0),
                  child: Card(
                    color: Theme.of(context).dialogBackgroundColor,
                    child: 
                      ExpandablePanel(
                        header: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AboutDate().dateFormat.format(item.createdAt), 
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(item.title, style: Theme.of(context).textTheme.bodyText1),
                            ],
                          )
                        ),
                        collapsed: Text(""),
                        expanded: Html(
                          data: item.message,
                        ),
                    
                      ),
                  ),
                );
              }
            ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: Text('확인', style: Theme.of(context).textTheme.button),
                onPressed: () => callback?.call(seq),
              ),
            ],
          ),
        ],
      )
    );
  }
}