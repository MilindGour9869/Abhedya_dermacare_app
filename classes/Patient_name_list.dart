class Patient_name_data_list{

  String name , DOB , gender , email , address   , image   , date ;
  int age , mobile ;

  List  group  , blood_group;




  Patient_name_data_list({
    this.name  , this.DOB , this.date , this.gender , this.email , this.address  , this.age , this.mobile , this.group , this.blood_group , this.image
  });

  static Patient_name_data_list fromJson(Map<String , dynamic> json){

    print(json);

    return Patient_name_data_list(

     name: json['name'],








    );
  }

}