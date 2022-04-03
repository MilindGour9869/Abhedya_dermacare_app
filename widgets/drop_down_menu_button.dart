import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/git/screens/app_theme.dart';
import 'package:flutter_app/default.dart';

class DropDown extends StatefulWidget {
  Map<String , Map<String , int>> menu={};

  String service_id;






  DropDown({this.menu, this.service_id  });

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {




  var service = TextEditingController();
  var charge = TextEditingController();



  @override
  Widget build(BuildContext context) {

    List doc_id = widget.menu.keys.toList();




    return ListView.builder(
        shrinkWrap: true,
        itemCount: doc_id.length,
        itemBuilder: (context, index) {

          List a  =  widget.menu[doc_id[index]].keys.toList();
          String s = a[0].toString();

          List b = widget.menu[doc_id[index]].values.toList();
          String c = b[0].toString();

          service.text = s;
          charge.text  = c;



          return  GestureDetector(
            onTap: (){

              showDialog(context: context, builder: (context)=>Dialogue(service_name: widget.service_id , service: service , context: context , charges: charge , doc_id: doc_id[index].toString() ));

              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 2),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(7),
                ),
                height: MediaQuery.of(context).size.height * 0.06,

                child: Material(
                  elevation: 2,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [



                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                           s,
                            style: TextStyle(color: Colors.black , fontSize: 15),

                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(c+ ' Rs' , style: TextStyle(fontSize: 15),),
                            SizedBox(width: 10,),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget Dialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context , String doc_id}){

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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(service_name , style: TextStyle(fontWeight: FontWeight.bold),),
                      IconButton(onPressed: ()async{

                        final doc = await FirebaseFirestore.instance.collection('Services').doc(doc_id);
                        doc.delete();

                      }, icon: Icon(Icons.delete_outline_outlined))
                    ],
                  ),
                  SizedBox(height: 20,),

                  Material(
                    child:TextField(
                      controller: service,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        labelText: 'Service',

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
                              color: Color(0xff019874),
                          ),
                          child: TextButton(
                            child: Text('Done' , style:  TextStyle(
                                color: Colors.black
                            ),),
                            onPressed: ()async{




                              var doc =  await FirebaseFirestore.instance.collection('Services').doc(doc_id);

                              final json = {
                                'id' : service_name,
                                'charge' : int.parse(charges.text),
                                'service' : service.text,
                                'doc_id' : doc.id

                              };


                              doc.update(json);

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
