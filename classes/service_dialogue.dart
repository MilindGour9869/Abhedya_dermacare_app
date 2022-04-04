import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ServiceDialogue{

  static Widget Dialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context , String doc_id}){

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
                        Text(service_name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: MediaQuery.of(context).size.height*0.03),),
                        IconButton(onPressed: ()async{

                          final doc = await FirebaseFirestore.instance.collection('Services').doc(doc_id);
                          doc.delete();
                          Navigator.pop(context);

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

}