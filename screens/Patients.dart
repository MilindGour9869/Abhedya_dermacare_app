import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';



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


  Future PatientDataDelete (@required String group)async{
    final doc = await FirebaseFirestore.instance.collection('Patient').doc(group);

    doc.delete();


  }







 Widget Tile(Patient_name_data_list data ) => GestureDetector(
   onTap: (){

     Navigator.push(context , MaterialPageRoute(builder: (context)=>AddPatient(patient_data:data)));



   },
   child: Padding(
     padding: const EdgeInsets.all(8.0),
     child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: AppTheme.white,

       ),
       child: Material(
         elevation: 2,
         borderRadius: BorderRadius.circular(10),
         child: ListTile(

           title: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(data.name==null?"?":data.name , style: TextStyle(fontSize: 15),),
               IconButton(onPressed: (){
                 showDialog(context: context, builder: (context)=>AlertDialog(

                   titlePadding: EdgeInsets.all(0),
                   title: Center(child: Text('Are you Sure ?')),



                   actions: [
                     Row(

                       children: [
                       Container(

                           child: TextButton(onPressed: (){

                             setState(() {
                               patient_instance_list.remove(data);
                               all_patient_name_list.remove(data.name);
                               search_patient_list.remove(data.name);
                               map_name_patientInstance_list.remove(data.name);
                               PatientDataDelete(data.name);
                             });

                             Navigator.pop(context);




                           }, child:Text('yes' ,style: TextStyle(color: Colors.white),)),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color:Colors.redAccent,
                           ),
                       ),
                         Container(

                           child: TextButton(onPressed: (){
                             Navigator.pop(context);

                           }, child:Text('no' ,style: TextStyle(color: Colors.white),)),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             color:Colors.grey,
                           ),
                         ),
                     ],

                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                     )

                   ],
                 ));
               }, icon: Icon(Icons.delete_outline))
             ],
           ),
           dense: true,


           subtitle: Column(
             crossAxisAlignment: CrossAxisAlignment.start,

             children: [

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
               Text('last visited on : ${formatDate(data.date.toDate(),[dd, '-', mm, '-', yyyy])}' , style: TextStyle(fontStyle: FontStyle.italic),),




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
      backgroundColor: AppTheme.offwhite,

      appBar: PreferredSize(

        preferredSize: Size.fromHeight(150.0),

        child: AppBar(
          backgroundColor: AppTheme.orange,
          elevation: 0,
          title: Text('My Patients' , style: TextStyle(color: Colors.black),),



        ),
      ),



      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 8.0),
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




          Expanded(
            child: Container(
             
             
             color: Colors.transparent,
              child:SingleChildScrollView(

                child: FutureBuilder(
                  future: f,

                    builder: (context,snapshot){

                    print(snapshot.data);

                      if(search_patient_list.isEmpty)
                        {return Center(child: Card(
                          color: AppTheme.notWhite,

                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('loadin'),
                            )));}







                      if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return Center(child: CircularProgressIndicator());
                        }

                      if(snapshot.hasError) {
                        return const Center(child: Text('Something Went Wrong'));
                      }


                      return Container(
                        height: MediaQuery.of(context).size.height*0.727,
                        child: ListView(
                          children: search_patient_list.map<Widget>((e)=>Tile(map_name_patientInstance_list[e])).toList(),
                        ),
                      );
                    }
                )
              ),
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

        color: AppTheme.offwhite,
        child: Container(
          height:MediaQuery.of(context).size.height*0.08,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft:Radius.circular(10),

            ),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(

                    child: TextButton(onPressed: (){}, child: Text('Today' , style: TextStyle(color: Colors.black),)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppTheme.notWhite,

                    ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(

                  child: TextButton(onPressed: (){}, child: Text('All' , style: TextStyle(color: Colors.black),)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.notWhite,

                  ),

                ),
              ),
            ],
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







