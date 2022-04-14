import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/service_dialogue.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/storage/storage.dart';

import 'package:flutter_app/widgets/drop_down_menu_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

bool updated = false;


class Services extends StatefulWidget {

 bool change ;


@override
_State createState() => _State();
}

class _State extends State<Services> {

  Future f;

  Map<String , Map<String , dynamic >> all_data_map={};

  bool consultation = false;
  bool nursing = false;
  bool procedures = false;
  bool vacination = false;
  bool by_you = false;

  var service_edit = TextEditingController();
  var charges_edit = TextEditingController();

  Map<String ,  Map<String , int>> Consulation ={};
  Map<String ,  Map<String , int>> Nursing ={};
  Map<String ,  Map<String , int>> Procedures ={};
  Map<String ,  Map<String , int>> Vaccination ={};
  Map<String ,  Map<String , int>> By_You ={};

  var search_edit = TextEditingController();
  var service = TextEditingController();
  var charge = TextEditingController();

  List all_service_list=[];
  List search_service_list=[];






  int services_length;







  Map<String,dynamic> map={};


  Map<String , Map<String , String>> service_list={};






    Future  getServiceData()async{

    Consulation={};
    Nursing={};
    Procedures={};
    Vaccination = {};
    By_You={};
    service_list={};



        var a = await Storage.get_services();

        all_data_map = a==null?{}:a;

        services_length = all_data_map.keys.length;

        all_data_map.forEach((key, element) {

          service_list[element['service']] = {
            element['doc_id'].toString() : element['id'].toString()
          };

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


        });





















      all_service_list = service_list.keys.toList();





      setState(() {
        search_service_list = all_service_list;

      });









  }

    Future set(){
      Storage.set_services(updated: updated , value: all_data_map);
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

  }

  @override
  void didUpdateWidget(covariant Services oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

   print('Did Update');


  }

  onItemChanged(String value) {
    setState(() {
      search_service_list= all_service_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(search_service_list.isEmpty)
      {
        search_service_list=[];
      }
    });
  }


@override
Widget build(BuildContext context) {
return Scaffold(

  appBar: PreferredSize(
    preferredSize: Size.fromHeight(200),
    child: Container(
      decoration: BoxDecoration(
          color: AppTheme.teal,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          )),
      height: MediaQuery.of(context).size.height * 0.23,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          AppBar(
            title:Text('Service') ,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),



          Padding(
            padding: const EdgeInsets.only(
                top: 23.0, right: 40, left: 40 , bottom: 10),
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              decoration: BoxDecoration(
                  color: AppTheme.notWhite,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: search_edit,
                onChanged: onItemChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search',
                    prefixText: "      ",
                    hintStyle: TextStyle(),
                    suffixIcon: Icon(Icons.search)),
                keyboardType: TextInputType.name,
              ),
            ),
          ),
        ],
      ),
    ),
  ),

  body:Center(

    child: Container(

      child: search_edit.text == ""?

      RefreshIndicator(
        onRefresh: getServiceData,
        child: ListView(

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

                      showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Consultation' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length , all_data_map: this.all_data_map)).then((value) {

                        set();
                        getServiceData();


                      });

                    },
                  ),





          ),
                ),
              ),
            ), // Consultation
            Visibility(

                visible: consultation,

                child: Container(

                    child:
                    DropDown( menu: Consulation, service_id: 'Consultation', c: widget.change, all_data_map: this.all_data_map, )


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

                        showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Nursing' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length , all_data_map: this.all_data_map));

                      },
                    ),



                  ),
                ),
              ),
            ),  //Nursing
            Visibility(

                visible: nursing,

                child: Container(

                    child: DropDown( menu : Nursing, service_id: 'Nursing', all_data_map: this.all_data_map,))),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 8),
              child: Container(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),

                  child: ListTile(
                    title: Text('Procedures'),
                    leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),
                    onTap: (){

                      setState(() {

                        procedures = !procedures;

                        // print(consultation);



                      });

                    },

                    trailing: IconButton(
                      icon: Icon(Icons.add ,color: AppTheme.teal,),
                      onPressed: (){

                        showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Procedures' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length , all_data_map: this.all_data_map));

                      },
                    ),



                  ),
                ),
              ),
            ),  //Procedures
            Visibility(

                visible: procedures,

                child: Container(

                    child: DropDown( menu : Procedures, service_id: 'Procedures', all_data_map: this.all_data_map,))),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 8),
              child: Container(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),

                  child: ListTile(
                    title: Text('Vaccination'),
                    leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),
                    onTap: (){

                      setState(() {

                        vacination = !vacination;

                        // print(consultation);



                      });

                    },

                    trailing: IconButton(
                      icon: Icon(Icons.add ,color: AppTheme.teal,),
                      onPressed: (){

                        showDialog(context: context, builder: (context)=>Dialogue(service_name: 'Vaccination' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length , all_data_map: this.all_data_map));

                      },
                    ),



                  ),
                ),
              ),
            ),  //Vaccination
            Visibility(

                visible: vacination,

                child: Container(

                    child: DropDown( menu : Vaccination, service_id: 'Vaccination', all_data_map: this.all_data_map,))),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 8),
              child: Container(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),

                  child: ListTile(
                    title: Text('By You'),
                    leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),
                    onTap: (){

                      setState(() {

                         by_you = !by_you;

                        // print(consultation);



                      });

                    },

                    trailing: IconButton(
                      icon: Icon(Icons.add ,color: AppTheme.teal,),
                      onPressed: (){

                        showDialog(context: context, builder: (context)=>Dialogue(service_name: 'By You' , service: service_edit , charges: charges_edit , context: context  ,  size: services_length , all_data_map: this.all_data_map));

                      },
                    ),



                  ),
                ),
              ),
            ),  //By You
            Visibility(

                visible: by_you,

                child: Container(

                    child: DropDown( menu : By_You, service_id: 'By_You', all_data_map: this.all_data_map,))),






          ],

        ),
      ):

      Container(
        alignment: Alignment.topCenter,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: SingleChildScrollView(
              child: Column(


                children: search_service_list.map<Widget>((e){

                  List a = service_list[e].keys.toList();
                  List b = service_list[e].values.toList();
                  List c;


                  service.text = e.toString();

                 if(b[0]== "Consultation")
                   {
                     c = Consulation[a[0].toString()].values.toList();
                   }
                  else if(b[0]== "Nursing")
                  {
                    c = Nursing[a[0].toString()].values.toList();
                  }
                 else  if(b[0]== "Procedures")
                  {
                    c = Procedures[a[0].toString()].values.toList();
                  }
                 else  if(b[0]== "Vaccination")
                  {
                    c = Vaccination[a[0].toString()].values.toList();
                  }
                  else if(b[0]== "By_You")
                  {
                    c = By_You[a[0].toString()].values.toList();
                  }

                  charge.text = c[0].toString();


                  return  GestureDetector(

                  onTap: (){

                    showDialog(context: context, builder: (context)=>ServiceDialogue.Dialogue(
                      service: service,
                      charges: charge,
                      service_name: b[0].toString(),
                      doc_id: a[0].toString(),
                      context: context,
                    ));
                  },
                  child: ListTile(
                    title: Text(e.toString()),
                    leading: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.teal,),


                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline_outlined , color: AppTheme.teal,),
                      onPressed: ()async{





                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              titlePadding: EdgeInsets.all(0),
                              title:
                              Center(child: Text('Are you Sure ?')),
                              actions: [
                                Row(
                                  children: [
                                    Container(
                                      child: TextButton(
                                          onPressed: ()async {

                                           all_data_map.remove(a[0].toString());
                                           updated = true;



                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'yes',
                                            style: TextStyle(
                                                color: Colors.white),
                                          )),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: AppTheme.green,
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'no',
                                            style: TextStyle(
                                                color: Colors.white),
                                          )),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                )
                              ],
                            ));













                      },
                    ),





                  ),
                );

                }).toList(),
              ),
            ),
          ),
        ),
      )

    ),

  ),

);
}
}


Widget Dialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context , int size , Map<String , Map<String , dynamic >> all_data_map}){

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40 , vertical:  200),
    child: Material(
      child: Container(
        color: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              SizedBox(height: 10,),

              Text(service_name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: MediaQuery.of(context).size.height*0.03),),
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




                          var doc =  await FirebaseFirestore.instance.collection('Services').doc();

                          final json = {
                            'id' : service_name,
                            'charge' : int.parse(charges.text),
                            'service' : service.text,
                            'doc_id' : doc.id

                          };

                          all_data_map[doc.id] = json;
                          updated = true;








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



