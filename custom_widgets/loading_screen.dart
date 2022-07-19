import 'package:flutter/material.dart';

import '../default.dart';

class SnackOn {
  BuildContext context;
  String msg;

  SnackOn( this.context ,  this.msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(minutes: 2),
      backgroundColor: AppTheme.green,
    ));
  }
}

class SnackOff {
  BuildContext context;

  SnackOff( {required this.context}) {
    ScaffoldMessenger.of(context)..removeCurrentSnackBar();
  }
}

class ShowDialogue {

  BuildContext context;
  String Alertmsg;


   ShowDialogue( this.context ,  this.Alertmsg  ) {


    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(Alertmsg),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context , );
                    },
                    child: Text(
                      'OK',
                      textScaleFactor: AppTheme.alert,
                    )),
              ],
            ));


  }


  static bool  f (   BuildContext context , String Alertmsg , ) {

     late bool response;


     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(Alertmsg),
          actions: [

            TextButton(
                onPressed: () {
                   response = false;
                  Navigator.pop(context );

                },
                child: Text(
                  'Cancel',
                  textScaleFactor: AppTheme.alert,
                )),




            TextButton(
                onPressed: () {
                  response = true;

                  Navigator.pop(context );
                },
                child: Text(
                  'OK',
                  textScaleFactor: AppTheme.alert,
                )),

          ],
        ));

     return response!;




  }
}
