class Group_data_list {
  String group;
  bool selected;

  Group_data_list({this.group , this.selected});

  static Group_data_list fromJson(Map<String , dynamic> json){

    print(json);

    return Group_data_list(
      group: json['group'],



    );
  }


  static String list (Group_data_list grp){
    return grp.group;
  }
}