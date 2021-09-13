import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sense_battle/screens/widgets/dialog_button.dart';


enum ButtonPosition {
  Center,
  Left, 
  Right, 
}


class DialogBox {
    void alertDialog(String desc, {
    String btnText = "확인",
    String? title,
    bool barrierDismissible = true,
    Function? callback,
    double? maxHeight,
  }) {
    showDialog(
      context: Get.overlayContext!, 
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialogWidget(
          context,
          desc,
          title: title,
          leftButtonText: btnText,
          callback: callback,
          maxHeight: maxHeight ?? 250
        );
      }
    );
  }

  void confirmDialog(String desc, {
    String leftText = "취소",
    String rightText = "확인",
    bool barrierDismissible = true,
    String? title,
    Function? callback
  }) {
    showDialog(
      context: Get.overlayContext!, 
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return dialogWidget(
          context,
          desc,
          title: title,
          leftButtonText: leftText,
          rightButtonText: rightText,
          callback: callback
        );
      }
    );
  }
  


    Widget dialogWidget(
    BuildContext context,
    String desc, 
    {
      String? title,
      double maxHeight = 250,
      String leftButtonText  = "확인",
      String? rightButtonText,
      Function? callback
    }) {

    return Container(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).dialogBackgroundColor,
            ),
            padding: const EdgeInsets.only(top: 72),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: title != null || title?.isNotEmpty == true,
                  child: Text(title??"",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ),

                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 9.0, right: 9.0, top: 14.0),
                    child: Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 34.0),
                  child: Row(
                    children: [
                       Expanded(
                        child: DialogButton(
                          position: rightButtonText == null
                          ? ButtonPosition.Center : ButtonPosition.Left,
                          title: leftButtonText, 
                          callback: () => callback?.call(0)
                        ),
                      ),
                      Visibility(
                        visible: rightButtonText != null,
                        child: Expanded(
                          child: DialogButton(
                            position: ButtonPosition.Right, 
                            title: rightButtonText??"", 
                            callback: () => callback?.call(1))
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}