import 'package:flutter/material.dart';

import 'package:flutter_app/widgets/drop_down_menu_button.dart';

class Services extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Services> {

  bool consultation = false;
  bool nursing = false;
  bool procedures = false;
  bool vacination = false;
  bool miscellaneous = false;

  var service = TextEditingController();
  var charges = TextEditingController();



@override
Widget build(BuildContext context) {
return Scaffold(

  appBar: AppBar(
    title: Text('Services'),
  ),

  body:Center(

    child: Container(

      child: Column(

        children: [

        ListTile(
          title: Text('Consulation'),
          leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03,),
          onTap: (){

            setState(() {

              consultation = !consultation;

              print(consultation);



            });

          },

          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: (){

              showDialog(context: context, builder: (context)=>showDialogue('Consultation'));

            },
          ),
        ),

          //Consutation
          Visibility(

              visible: consultation,

              child: Container(

                  child: DropDown(menu: ['aaa','wer'], color: Colors.black,))),



          ListTile(
            title: Text('Nursing'),
            leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03,),
            onTap: (){

              setState(() {

                nursing = !nursing;

                print(nursing);



              });

            },
          ),  //Nursing
          Visibility(

              visible: nursing,

              child: Container(

                  child: DropDown(menu: ['aaa','wer'], color: Colors.black,))),




        ],

      ),

    ),

  ),

);
}
}


Widget showDialogue (String service_name){

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40 , vertical:  120),
    child: Container(
      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(height: 10,),

          Text(service_name),
          SizedBox(height: 10,),

          Material(
            child:TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
                labelText: 'AdddService',

              ),
            ) ,
          ),

        ]),
    ));
}