import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/storage/storage.dart';

class Add_Info extends StatefulWidget {

  List<String> result;
  Add_Info({this.result});

  @override
  _Add_InfoState createState() => _Add_InfoState();
}

class _Add_InfoState extends State<Add_Info> {
  List<String> group_updated_result = [];
  List<String> all_data_english_list=[];

  List group_search_data_list = [];

  Map<String, bool> select = {};

  Future f;


  var _textController_group = TextEditingController();

  void get() async {
    print('get called');

    all_data_english_list = await Storage.get_medicine_additional_info();

    setState(() {

      all_data_english_list = all_data_english_list;


      group_search_data_list = all_data_english_list;
      all_data_english_list.forEach((element) {
        select[element] = false;
      });

    });

    if(widget.result != null)
    {
      print('ddd');


      setState(() {
        widget.result.forEach((element) {
          print('rrr');
          print(all_data_english_list);

          all_data_english_list.forEach((e) {

            print('ww');

            if(e==element)
            {
              print(e);

              select[e] = true;
              group_updated_result.add(e);


            }
          });
        });

      });

    }




  }

  void set() async {
    print('set called');
    print(all_data_english_list);

    await Storage.set_medicine_additional_info(add_info: all_data_english_list);
  }

  void onChange(String s){

    all_data_english_list.add(s);
    select[s] = false;

  }

  onItemChanged(String value) {
    setState(() {
      if(all_data_english_list != null)
        {
          group_search_data_list = all_data_english_list
              .where((string) => string.toLowerCase().contains(value.toLowerCase()))
              .toList();
        }
      if (group_search_data_list.isEmpty) {
        group_search_data_list = [];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    set();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, group_updated_result);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            controller: _textController_group,
            decoration: InputDecoration(
              hintText: 'Search / Add ',
            ),
            onChanged: onItemChanged,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: CircleAvatar(
              child: Text(all_data_english_list!=null?all_data_english_list.length.toString() :'0'),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: f,
        builder: (context,snapshot){


          if(group_search_data_list.isNotEmpty)
          {
            return  SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                width: double.infinity,
                child:  ListView(
                  children: group_search_data_list
                      .map<Widget>((e) => GestureDetector(
                    onTap: (){
                      setState(() {
                        select[e] = !select[e];
                        if (select[e] == true) {
                          group_updated_result.add(e);
                        }
                        if (select[e] == false) {
                          group_updated_result.remove(e);
                        }
                      });
                    },
                        child: ListTile(
                    title: Text(e),
                    leading: CircleAvatar(
                        backgroundColor:
                        select[e] ? AppTheme.green : Colors.grey,
                        child: Icon(
                            Icons.done,
                            color: AppTheme.white,
                          ),
                        ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete_outline_outlined),
                        onPressed: (){
                        setState(() {
                          all_data_english_list.remove(e);
                          group_search_data_list.remove(e);
                        });

                        },
                    ),
                  ),
                      ))
                      .toList(),
                ));

          }
          if(_textController_group.text.isNotEmpty )
          {
            return Center(
              child: TextButton.icon(
                  onPressed: () {
                    setState(() {



                      onChange(_textController_group.text);

                      print('ggg');


                      group_search_data_list
                          .add(_textController_group.text);

                    });

                    _textController_group.clear();
                    onItemChanged('');



                  },
                  icon: Icon(Icons.add),
                  label: Text(_textController_group.text)),
            );


          }
          else{
            print('in future builder , else');

            return Center(child:CircularProgressIndicator() );
          }

        },
      ),
    );
  }
}
