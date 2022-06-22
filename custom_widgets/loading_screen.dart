import 'package:flutter/material.dart';

import '../default.dart';

class SnackOn{

  BuildContext context;
  String msg ;


  SnackOn({@required this.context , @required this.msg}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text(msg),
          duration: Duration(
              minutes: 2
          ),
          backgroundColor: AppTheme.green,


        )

    );
  }
}

class SnackOff{

  BuildContext context;

  SnackOff({@required this.context }){
    ScaffoldMessenger.of(context)..removeCurrentSnackBar();
  }



}