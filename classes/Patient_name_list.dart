

import 'package:cloud_firestore/cloud_firestore.dart';


class Patient_name_data_list{

  //basic

   late String name , mobile , doc_id ; // Non nullable & compulsory


  String?  DOB , gender , email , address   , image  , blood_group , profile_link;
  String?  age   ,uid ;


  Timestamp? recent_visit;





  //visits
   Map<String , Map<String,dynamic> >? visits_mapData_list = {};


  Timestamp? visit_date;


  Patient_name_data_list.setPatientData(

      this.name , this.mobile , this.doc_id  ,

      { this.age , this.gender , this.email , this.DOB , this.recent_visit ,   this.address  , this.blood_group , this.image,
      this.visit_date , this.profile_link }

  );

  Patient_name_data_list();


 Patient_name_data_list from_Json_to_Patient_Instance(Map<String , dynamic> json){

   return Patient_name_data_list.setPatientData(

        json['name']!,
        json['mobile']!,
        json['doc_id'],


      age: json['age'],
      recent_visit:  json['recent_visit'],
      gender: json['gender'],
      email: json['email'],

      blood_group: json['blood_group'],
      profile_link : json['profile_link'],






    );
  }






  void Visit_Map_Data(Map<String,dynamic> map , String visit_date )
  {
    this.visits_mapData_list![visit_date] = map;
  }

   Map<String,dynamic>?  from_Instance_to_Json(Patient_name_data_list patient_instance)
   {
     Map<String,dynamic>? json;

     return json ;


   }

   Map<String,dynamic> set_visit_date(Map<String,dynamic?> json , Patient_name_data_list patient_instance , String date ){

     Map<String,dynamic?> result_json=json;


     json.forEach((key, value) {
     if(value == null || value.isEmpty)
       {
         result_json.remove(key);

       }
   });

     patient_instance.visits_mapData_list![date]=result_json;

     return result_json;











   }




}