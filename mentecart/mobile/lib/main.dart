import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MenteCart',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MenteCart"),
        ),

        body: const Center(
          child: Text(
            "Flutter Connected Successfully"
          ),
        ),
      ),
    );
  }
}