import 'package:flutter/material.dart';

class DefaultStreamBuilder {



  static deafult_stream_builder(BuildContext context , Stream stream  ) {
    return StreamBuilder(
        stream: stream,


        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Material(child: Text('waiitng'));

            }
          return null;


        });
  }
}

