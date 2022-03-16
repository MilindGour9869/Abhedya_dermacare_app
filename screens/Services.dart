import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';

import 'package:flutter_app/widgets/drop_down_menu_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Services extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Services> {

  Future f;

  bool consultation = false;
  bool nursing = false;
  bool procedures = false;
  bool vacination = false;
  bool miscellaneous = false;

  var service = TextEditingController();
  var charges = TextEditingController();




  Map<String,dynamic> map;


  Map<String , Map<String,int>> consultation_map;


  Future getServiceData()async{
    await FirebaseFirestore.instance.collection('Consultation').get().then((QuerySnapshot querySnapshot){

      querySnapshot.docs.forEach((element) {

        print('ss');

        print(element['service']);

        map['service']=element['service'];
        map['charge']=element['charge'];

        consultation_map[element['service'].toString()]=map;

        map={};


      });

      print('ddd');


      print(consultation_map);

    });


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceData();
  }



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

              showDialog(context: context, builder: (context)=>showDialogue(service_name: 'Consultation' , service: service , charges: charges , context: context));

            },
          ),
        ),

          //Consutation
          Visibility(

              visible: consultation,

              child: Container(

                  child: consultation_map==null?
                  CircularProgressIndicator():
                  DropDown( menu: consultation_map,color: Colors.black,))),



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

                  child: DropDown( color: Colors.black,))),




        ],

      ),

    ),

  ),

);
}
}


Widget showDialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context}){

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40 , vertical:  150),
    child: Container(
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            SizedBox(height: 10,),

            Text(service_name , style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),

            Material(
              child:TextField(
                controller: service,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  labelText: 'Add Service',

                ),
              ) ,
            ),
            SizedBox(height: 20,),

            Material(

              child:TextField(
                controller: charges,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),


                  ),
                  labelText: 'Charges',
                  prefixText: '₹ ',




                ),

                keyboardType: TextInputType.number,
              ) ,
            ),

            SizedBox(height: 20,),

            Container(
              alignment: Alignment.bottomCenter,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.grey
                 ),
                 child: TextButton(
                   child: Text('Cancel' , style:  TextStyle(
                     color: Colors.black
                   ),),
                   onPressed: (){

                     Navigator.pop(context);


                   },
                 ),
               ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.green
                    ),
                    child: TextButton(
                      child: Text('Done' , style:  TextStyle(
                          color: Colors.black
                      ),),
                      onPressed: (){

                      },
                    ),
                  ),
              ],),
            )

          ]),
      ),
    ));
}