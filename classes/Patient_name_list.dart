import 'package:cloud_firestore/cloud_firestore.dart';

class Patient_name_data_list{

  //basic

  String name , DOB , gender , email , address   , image  , doc_id   , blood_group , profile_link;
  int age , mobile  ,uid ;


  Timestamp recent_visit;





  //visits


  Map<String , Map<String,dynamic>>visits_mapData_list = {};


  Timestamp visit_date;








  Patient_name_data_list({

    this.doc_id , this.name  , this.DOB , this.recent_visit , this.gender , this.email , this.address  , this.age , this.mobile  , this.blood_group , this.image,
    this.visit_date , this.profile_link
  });

   Patient_name_data_list fromJson(Map<String , dynamic> json){


    print(json['gender']);


    return Patient_name_data_list(

      name: json['name'],
      age: json['age'] =="" ? "" : int.parse(json['age']),
      recent_visit:  json['recent_visit'],
      mobile: json['mobile'] =="" ? "" : int.parse(json['mobile']),
      gender: json['gender'] =="" ? "": json['gender'],
      email: json['email'] =="" ? "": json['email'],
      doc_id: json['doc_id'],
      blood_group: json['blood_group'],
      profile_link : json['profile_link'],






    );
  }


  void Visit_Map_Data({Map<String,dynamic> map , String visit_date })
  {
    this.visits_mapData_list[visit_date] = map;
  }




}