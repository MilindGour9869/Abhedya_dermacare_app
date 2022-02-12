class Patient_name_data_list{

  String name , DOB , gender , email , address   , image , group  , blood_group  , date ;
  int age , mobile ;

  Patient_name_data_list({
    this.name  , this.DOB , this.date , this.gender , this.email , this.address  , this.age , this.mobile , this.group , this.blood_group , this.image
  }){
    print('patient constructor called ');

  }

  static Patient_name_data_list fromJson(Map<String , dynamic> json){

    print(json);

    return Patient_name_data_list(
      age : json['age'],
      name: json['name'],



    );
  }

}