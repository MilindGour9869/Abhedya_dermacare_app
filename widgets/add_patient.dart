import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'list_search.dart';

bool group_tap = false;

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('New '),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(''))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.person),
                Container(
                  width: 200,
                  child: TextField(
                      // controller: patient_name,

                      ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.person),
                GestureDetector(
                  onTap: () {
                    print('male');
                    //patient_gender="male";
                  },
                  child: Container(
                    child: Text('male'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('female');
                    //patient_gender="female";
                  },
                  child: Container(
                    child: Text('female'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('other');
                    //  patient_gender="other";
                  },
                  child: Container(
                    child: Text('other'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                      decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          


                        ),
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 20


                      


                    ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,



                            ),
                            borderRadius: BorderRadius.circular(10),






                        ),


                  )




                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListSearch(),
                              ));

                      // showSearch(context: context, delegate: Search());
                    },
                    icon: Icon(Icons.arrow_drop_down_circle),
                    label: Text(''))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//class Search extends SearchDelegate<String> {
//
//
//
//
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {
//
//        },
//      )
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    return null;
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    return null;
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    final suggestions = query.isEmpty ? ['qq' , 'ecc' , 'ec']: [];
//    return Container(
//      height: 200,
//
//      child: ListView.builder(
//        itemCount: suggestions.length,
//        itemBuilder: (content, index) => ListTile(
//            leading: IconButton(
//              icon: Icon(Icons.adjust),
//              onPressed: (){
//                group_tap=!group_tap;
//
//
//              },
//            ), title: Text(suggestions[index])),
//      ),
//    );
//  }
//}
