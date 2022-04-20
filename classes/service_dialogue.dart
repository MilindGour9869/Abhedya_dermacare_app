
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class ServiceDialogue {





  static Widget Dialogue ({String service_name , TextEditingController service , TextEditingController charges , BuildContext context , String doc_id }){

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Padding(
        padding:  EdgeInsets.all(2.w),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      SizedBox(height: 1.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(service_name , style: TextStyle(fontWeight: FontWeight.bold ),),
                          IconButton(onPressed: ()async{


                            Navigator.pop(context  , 'delete');

                          }, icon: Icon(Icons.delete_outline_outlined))
                        ],
                      ),
                      SizedBox(height: 2.h,),

                      Material(
                        child:TextField(
                          controller: service,
                          style: TextStyle(
                            fontSize: 4.w
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),
                            labelText: 'Service',

                          ),
                        ) ,
                      ),
                      SizedBox(height: 2.h,),

                      Material(

                        child:TextField(
                          style: TextStyle(
                              fontSize: 4.w
                          ),
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

                      SizedBox(height: 2.h,),

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


                                  Map<String , Map<String,dynamic>> map={};






                                  final json = {
                                    'id' : service_name,
                                    'charge' : int.parse(charges.text),
                                    'service' : service.text,
                                    'doc_id' : doc_id

                                  };

                                  map[doc_id] = json;

                                  print(map);









                                  charges.clear();
                                  service.clear();










                                  Navigator.pop(context , map);








                                },
                              ),
                            ),
                          ],),
                      )

                    ]),
              ),
            ),
          ],
        )
      ),
    );
  }

}