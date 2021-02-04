


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Complex/RestApi/demo_retrofit_2/QiitaRepository.dart';

main(){

  runApp(App());
}

class App extends StatelessWidget{
  fetchApi(){
   var respository =  QiitaRepository();
   //respository.fetchArticle("page", "perPage", "query")
  }
  build(BuildContext context) {
    fetchApi();
   return MaterialApp(
     home: Scaffold(

     ),
   );
  }
}

