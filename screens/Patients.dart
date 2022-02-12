import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

class Patient extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Patient> {

 Widget Tile(Patient_name_data_list data) => GestureDetector(
   onTap: (){
     Navigator.push(context , MaterialPageRoute(builder: (context)=>AddPatient(patient_data:data)));



   },
   child: Padding(
     padding: const EdgeInsets.all(8.0),
     child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: AppTheme.notWhite,

       ),
       child: ListTile(
         title: Text(data.name==null?"?":data.name),


         subtitle: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Icon(Icons.cake_outlined , color: Colors.grey,size: 20,),
                 SizedBox(width: 5,),
                 Text(data.age==null?"?":data.age.toString()),
                 SizedBox(width: 10,),
                 Icon(Icons.call , color: Colors.grey,size: 20,),
                 SizedBox(width: 5,),
                 Text(data.mobile==null?"?":data.mobile.toString())
               ],
             ),


             SizedBox(height: 10,),
             Text('last visited on : ${data.date==null?"?":data.date}' , style: TextStyle(fontStyle: FontStyle.italic),),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 TextButton(onPressed: (){}, child: Text('Visits')),
                 TextButton(onPressed: (){}, child: Text('Payment')),
                 TextButton(onPressed: (){}, child: Text('Documents')),
               ],
             )

           ],
         ),

         leading: CircleAvatar(
           child: Text(data.name==null?"?":data.name[0].toUpperCase()),

         ),




       ),
     ),
   ),
 );


 Stream<List<Patient_name_data_list>> patient_data() => FirebaseFirestore.instance.collection('Patients').snapshots().map(

         (snapshot) => snapshot.docs.map((doc) => Patient_name_data_list.fromJson(doc.data()) ).toList() );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.adjust, color: Colors.black,), label: Text('Today' , style: TextStyle(color: Colors.black),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.adjust , color: Colors.black,), label: Text('All' , style: TextStyle(color: Colors.black),)),



          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 500,
           color: Colors.white,
            child:SingleChildScrollView(

              child: StreamBuilder(
                stream: patient_data(),
                // ignore: missing_return
                builder: (context,snapshot){

                  if(snapshot.hasData)
                    {
                     // print(snapshot.data.map(Patient_name_data_list(age:21)).toList());

                      return Container(
                        height: 500,
                        child: ListView(
                          children: snapshot.data.map<Widget>(Tile).toList(),
                        ),
                      );
                    }

                  if(snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(snapshot.hasData==false)
                    return Text('sdsv');

                  if(snapshot.connectionState==ConnectionState.waiting)
                    return Text('tf');
                },
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
                alignment: Alignment.bottomCenter,

                child: Material(
                  elevation: 5,
                  borderRadius:BorderRadius.circular(30) ,
                  child: TextButton.icon(onPressed: (){

                    print('add pateint');

                    Navigator.push(context , MaterialPageRoute(builder: (context)=>AddPatient()));


                  }, icon: Icon(Icons.add , color: Colors.red,), label: Text('Add Patient' , style: TextStyle(color: Colors.black),) ),
                )),
          )
        ],
      ),

      bottomNavigationBar: Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),



          ],
        ),
      ),


    );
}
}

class Patient_Tile extends StatelessWidget {
   Patient_Tile({
    Key key, this.name , this.age , this.mobile , this.date
  }) : super(key: key);

  String name , date  ;
  int mobile , age ;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name==null?"?":name),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.cake_outlined , color: Colors.grey,size: 20,),
              SizedBox(width: 5,),
              Text(age==null?"?":age.toString()),
              SizedBox(width: 10,),
              Icon(Icons.call , color: Colors.grey,size: 20,),
              SizedBox(width: 5,),
              Text(mobile==null?"?":mobile.toString())
            ],
          ),


          SizedBox(height: 10,),
          Text('last visited on : ${date==null?"?":date}' , style: TextStyle(fontStyle: FontStyle.italic),),

          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){}, child: Text('Visits')),
              TextButton(onPressed: (){}, child: Text('Payment')),
              TextButton(onPressed: (){}, child: Text('Documents')),
            ],
          )

        ],
      ),

      leading: CircleAvatar(
        child: Text(name[0].toUpperCase()),

      ),




    );
  }
}







