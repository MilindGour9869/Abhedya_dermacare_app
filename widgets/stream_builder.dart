import 'package:flutter/material.dart';

class DefaultStreamBuilder {



  static deafult_stream_builder(BuildContext context , Stream<Function> f  ) {
    return StreamBuilder(
        stream: f,


        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Text('hhh');

            }

        });
  }
}

