import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Complex/Bloc/demo_login/movies_bloc.dart';
import 'package:flutter_app/Complex/Bloc/demo_rest_api/models/item_model.dart';
import 'package:flutter_app/Complex/Bloc/demo_rest_api/ui/movie_list.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body:MovieList(), //MovieList2(), //MovieList(),
      ),
    );
  }
}

class MovieList2 extends StatelessWidget {
  build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: StreamBuilder(
            stream: bloc.allMovies,
            builder: (context, snapshot) {
              ItemModel itemModel = snapshot.data as ItemModel;
              if (snapshot.hasData) {
                return Center(
                  child: Text("On Click :...${itemModel.results?.length}"),
                );
              } else {
                return Text("Loading :...");
              }
            },
          ),
          width: 200,
          color: Colors.red,
          margin: EdgeInsets.only(top: 100),
        ).setOnClick(() {
          bloc.fetchAllMovies();
        })
      ],
      alignment: WrapAlignment.center,
    );
  }
}
