import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/auth/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

const MyApp({super.key});

@override
Widget build(BuildContext context){
  return BlocProvider(create: (_) => 
        AuthBloc(AuthRepository()),

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        ),
  );
}

}