import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';

import 'package:flutter_app/widgets/drop_down_menu_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Services extends StatefulWidget {

 bool change ;


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

  var service_edit = TextEditingController();
  var charges_edit = TextEditingController();

  Map<String ,  Map<String , int>> Consulation ={};
  Map<String ,  Map<String , int>> Nursing ={};
  Map<String ,  Map<String , int>> Procedures ={};
  Map<String ,  Map<String , int>> Vaccination ={};
  Map<String ,  Map<String , int>> By_You ={};


  int services_length;







  Map<String,dynamic> map={};


  Map<String , Map<String,dynamic>> service_map={};

  List<String> service = ['Consultation' , 'Nursing' , 'Procedures' , 'Vaccination' , 'By You'];


  Future getServiceData()async{

    Consulation={};
    Nursing={};
    Procedures={};
    Vaccination = {};
    By_You={};



    await FirebaseFirestore.instance.collection('Services').get().then((QuerySnapshot querySnapshot){

      services_length = querySnapshot.size;


      querySnapshot.docs.forEach((element) {

        print('ss');

        print(element['id']);
        print(element['doc_id']);


        if(element['id']=='Consultation')
          {

            Consulation[element['doc_id']] = {
              element['service'] : element['charge']
            };


          }
        if(element['id']=='Nursing')
        {
          Nursing[element['doc_id']] = {
            element['service'] : element['charge']
          };


        }
        if(element['id']=='Procedures')
        {
          Procedures[element['doc_id']] = {
            element['service'] : element['charge']
          };


        }
        if(element['id']=='Vaccination')
        {

          Vaccination[element['doc_id']] = {
            element['service'] : element['charge']
          };


        }
        if(element['id']=='By You')
        {

          By_You[element['doc_id']] = {
            element['service'] : element['charge']
          };


        }






      }

      );




    });



  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    service=[];

  }

  @override
  void didUpdateWidget(covariant Services oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

   print('Did Update');


  }


@override
Widget build(BuildContext context) {
return Scaffold(

  appBar: AppBar(
    title: Text('Services'),
    backgroundColor: AppTheme.teal,
  ),

  body:Center(

    child: Container(

      child: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),

                child: ListTile(
                title: Text('Consultation'),
                leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),
                onTap: (){

                  setState(() {

                    consultation = !consultation;

                    print(consultation);



                  });

                },

                trailing: IconButton(
                  icon: Icon(Icons.add , color: AppTheme.teal,),
                  onPressed: (){

                    showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Consultation' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length));

                  },
                ),

//                  subtitle: consultation==true?Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: Consulation.keys.map<Widget>((e) => drop(e , Consulation)).toList(),
//                    ),
//                  ):Container(),



        ),
              ),
            ),
          ), // Consultation


          Visibility(

              visible: consultation,

              child: Container(

                  child: service_map==null?
                  CircularProgressIndicator():
                  DropDown( menu: Consulation, service_id: 'Consultation', c: widget.change, )


              )),



          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 8),
            child: Container(
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),

                child: ListTile(
                  title: Text('Nursing'),
                  leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),
                  onTap: (){

                    setState(() {

                      nursing = !nursing;

                     // print(consultation);



                    });

                  },

                  trailing: IconButton(
                    icon: Icon(Icons.add ,color: AppTheme.teal,),
                    onPressed: (){

                      showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Nursing' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length));

                    },
                  ),

//                  subtitle: consultation==true?Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: Consulation.keys.map<Widget>((e) => drop(e , Consulation)).toList(),
//                    ),
//                  ):Container(),



                ),
              ),
            ),
          ),  //Nursing
          Visibility(

              visible: nursing,

              child: Container(

                  child: DropDown( menu : Nursing, service_id: 'Nursing',))),




        ],

      ),

    ),

  ),

);
}
}


Widget Dialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context , int size}){

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40 , vertical:  150),
    child: Material(
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
                        onPressed: ()async{

                          print(size);


                          print('done');

                          size=size+1;


                          var doc =  await FirebaseFirestore.instance.collection('Services').doc();

                          final json = {
                            'id' : service_name,
                            'charge' : int.parse(charges.text),
                            'service' : service.text,
                            'doc_id' : doc.id

                          };


                          doc.set(json);

                          charges.clear();
                          service.clear();

                          //  Services();







                          Navigator.pop(context);








                        },
                      ),
                    ),
                ],),
              )

            ]),
        ),
      ),
    ));
}

Widget drop (String menu ,Map<String , int> map )
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(menu),
      Text(map[menu].toString()),

    ],
  );
}

