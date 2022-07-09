import 'package:flutter/material.dart';

import '../default.dart';

class SnackOn {
  BuildContext context;
  String msg;

  SnackOn({@required this.context, @required this.msg}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(minutes: 2),
      backgroundColor: AppTheme.green,
    ));
  }
}

class SnackOff {
  BuildContext context;

  SnackOff({@required this.context}) {
    ScaffoldMessenger.of(context)..removeCurrentSnackBar();
  }
}

class ShowDialogue {
  BuildContext context;
  String Alertmsg;

  ShowDialogue({@required this.context , @required this.Alertmsg}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(Alertmsg),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      textScaleFactor: AppTheme.alert,
                    ))
              ],
            ));
  }
}
