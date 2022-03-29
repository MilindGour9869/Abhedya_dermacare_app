import 'package:cloud_firestore/cloud_firestore.dart';

class Patient_name_data_list{

  //basic

  String name , DOB , gender , email , address   , image   ;
  int age , mobile ;

  List  group  , blood_group;
  Timestamp date;


  //visits

  List visits_mapData_list = [];
  List complaints=[];
  List clinical_finding=[];
  List investigation =[];
  List diagnosis=[];

  List medicines=[];
  List vital_info=[];

  List allergies=[];
  List advices=[];

  String internal_notes;
  Timestamp visit_date;








  Patient_name_data_list({
    this.name  , this.DOB , this.date , this.gender , this.email , this.address  , this.age , this.mobile , this.group , this.blood_group , this.image,
    this.visit_date , this.complaints, this.clinical_finding , this.allergies , this.diagnosis , this.internal_notes , this.investigation , this.vital_info , this.medicines , this.advices
  });

  static Patient_name_data_list fromJson(Map<String , dynamic> json){


    print(json['age']=="");


    return Patient_name_data_list(

      name: json['name'],
      age: json['age'] =="" ? 00 : int.parse(json['age']),
      date:  json['date'],
      mobile: json['mobile'] =="" ? 00 : int.parse(json['mobile']),
      gender: json['gender'] =="" ? "?": json['gender'],
      email: json['email'] =="" ? "?": json['email'],
    );
  }


  static Patient_name_data_list visits(Map<String,dynamic> json){

    print('vists called');


     print(json['complaints']);

  //   this.complaints=json['complaints'];
//     this.visit_date=json['date'];

//
//     this.blood_group= json['blood-group'];
//     this.group=  json['group'];
//
//     this.diagnosis=json['diagnosis'];
//     this.clinical_finding= json['clinical_finding'];
//     this.advices= json['advices'];
//     this.allergies= json['allergies'];
//
//     this.visits_date= json['date'];
//
//     this.internal_notes= json['internal_notes'];
//
//     this.medicines= json['medicines'];
//     this.vital_info=  json['vital-info'];



    return Patient_name_data_list(
      blood_group:  json['blood-group'],
      group:  json['group'],

      diagnosis: json['diagnosis'],
      clinical_finding: json['clinical_finding'],
      complaints: json['complaint'],
      advices: json['advices'],
      allergies: json['allergies'],
      investigation: json['investigation'],

      visit_date: json['visit_date'],

      internal_notes: json['internal_notes'],

      medicines:  json['medicines'],
      vital_info: json['vital-info'],
    );
  }

}