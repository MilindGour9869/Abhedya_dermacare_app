import 'package:cloud_firestore/cloud_firestore.dart';

class Patient_name_data_list{

  String name , DOB , gender , email , address   , image   ;
  int age , mobile ;

  List  group  , blood_group;
  Timestamp date;





  Patient_name_data_list({
    this.name  , this.DOB , this.date , this.gender , this.email , this.address  , this.age , this.mobile , this.group , this.blood_group , this.image
  });

  static Patient_name_data_list fromJson(Map<String , dynamic> json){

    print(json);
    print('qq');

    return Patient_name_data_list(

     name: json['name'],
      age: json['age']==""?00:json['age'],
      date: json['date']==""?"?":json['date'],
      mobile: json['mobile']==""?00:json['mobile']













    );
  }

}