import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_medicines.dart';

class Medicines extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Medicines> {
@override
Widget build(BuildContext context) {




return Scaffold(

  appBar: AppBar(
    title: Text('Medicines'),
  ),

  body: SingleChildScrollView(



    child: Container(
      height: 500,
      child: ListView.builder(

      itemBuilder: (context, index) {

      }),
    )),

  floatingActionButton: FloatingActionButton(
    elevation: 15,

    splashColor: AppTheme.notWhite,
    onPressed: (){
      Navigator.push(context , MaterialPageRoute(builder: (context)=>AddMedicine()));
    },
    child: Icon(Icons.add , color: Colors.black,),
    backgroundColor: AppTheme.green,
  ),
  bottomNavigationBar: BottomAppBar(

    color: AppTheme.offwhite,
    child: Container(
      height:MediaQuery.of(context).size.height*0.08,


    ),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
);


}
}