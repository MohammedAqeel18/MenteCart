import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/auth/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:mobile/features/services/bloc/service_bloc.dart';
import 'package:mobile/features/services/data/repositories/service_repository.dart';
import 'package:mobile/features/services/presentation/screen/services_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

const MyApp({super.key});

@override
Widget build(BuildContext context){
  return MultiBlocProvider(
  providers: [

    BlocProvider(
      create: (_) =>
          AuthBloc(AuthRepository()),
    ),

    BlocProvider(
      create: (_) =>
          ServiceBloc(
            ServiceRepository(),
          ),
    ),
  ],

  child: MaterialApp(
    debugShowCheckedModeBanner: false,

    home: const ServicesScreen(),
  ),
);
}
}