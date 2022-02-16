import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';


class Patient extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Patient> {

  bool today =false , all = false;

  Future f;

  List<Patient_name_data_list> patient_instance_list=[];
  List all_patient_name_list=[];
  List search_patient_list=[];
  Map<String , Patient_name_data_list> map_name_patientInstance_list={};


  var textcontroller = TextEditingController();








 Widget Tile(Patient_name_data_list data ) => GestureDetector(
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
       child: Material(
         elevation: 2,
         borderRadius: BorderRadius.circular(10),
         child: ListTile(

           title: Text(data.name==null?"?":data.name , style: TextStyle(fontSize: 15),),
           dense: true,


           subtitle: Column(
             crossAxisAlignment: CrossAxisAlignment.start,

             children: [
               SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Icon(Icons.cake_outlined , color: Colors.grey,size: 20,),
                   SizedBox(width: 5,),
                   Text(data.age==null?"20":data.age.toString()),
                   SizedBox(width: 10,),
                   Icon(Icons.call , color: Colors.grey,size: 20,),
                   SizedBox(width: 5,),
                   Text(data.mobile==null?"?91":data.mobile.toString())
                 ],
               ),


               SizedBox(height: 10,),
               Text('last visited on : ${data.date==null?"?":data.date}' , style: TextStyle(fontStyle: FontStyle.italic), overflow:TextOverflow.ellipsis,),




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
             child: Text(data.name==null?"?":data.name[0].toUpperCase() , style: TextStyle(color: Colors.black),),
             backgroundColor: AppTheme.green,

           ),




         ),
       ),
     ),
   ),
 );


  Future<dynamic> patient_data() async  => await FirebaseFirestore.instance.collection('Patient').get().then(

          (QuerySnapshot querySnapshot)

  {

    querySnapshot.docs.forEach((element) {

      patient_instance_list.add(Patient_name_data_list.fromJson(element.data()));

    });

    print(patient_instance_list);

    all_patient_name_list=patient_instance_list.map((e) => e.name).toList();

   int n = all_patient_name_list.length;


   for(int i=0;i<n;i++)
     {
       map_name_patientInstance_list[all_patient_name_list[i]]=patient_instance_list[i];
     }

    print(all_patient_name_list);

    search_patient_list=all_patient_name_list;


    var q;


    return q;




  }
  );

  onItemChanged(String value) {
    setState(() {
      search_patient_list= all_patient_name_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(search_patient_list.isEmpty)
      {
        search_patient_list=[];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('\ninit\n');
    f=patient_data();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patient_instance_list=[];
    all_patient_name_list=[];
    search_patient_list=[];

  }



  @override
  Widget build(BuildContext context) {
    print('builder');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: textcontroller,
                onChanged: onItemChanged,
                decoration: InputDecoration(




                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,),
                      borderRadius: BorderRadius.circular(10),),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,),
                      borderRadius: BorderRadius.circular(10),),

                    hintText:'Search',
                    prefixIcon: Icon(Icons.search)),


                keyboardType: TextInputType.name ,






              ),
            ),
          ),




          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.7,
           color: Colors.red,
            child:SingleChildScrollView(

              child: FutureBuilder(
                future: f,

                  builder: (context,snapshot){

                  print(snapshot.data);

                    if(search_patient_list.isEmpty)
                      {return Text('loadin');}







                    if(snapshot.connectionState==ConnectionState.waiting)
                      {
                        return Center(child: CircularProgressIndicator());
                      }

                    if(snapshot.hasError) {
                      return const Center(child: Text('Something Went Wrong'));
                    }


                    return Container(
                      height: 500,
                      child: ListView(
                        children: search_patient_list.map<Widget>((e)=>Tile(map_name_patientInstance_list[e])).toList(),
                      ),
                    );
                  }
              )
            ),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        elevation: 15,
        splashColor: AppTheme.notWhite,
        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)=>AddPatient()));
        },
        child: Icon(Icons.add , color: Colors.black,),
        backgroundColor: AppTheme.green,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height:MediaQuery.of(context).size.height*0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft:Radius.circular(5),
            )
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


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







