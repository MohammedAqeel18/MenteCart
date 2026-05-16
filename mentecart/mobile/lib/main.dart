
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/auth/bloc/auth_bloc.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:mobile/features/services/bloc/service_bloc.dart';
import 'package:mobile/features/services/data/repositories/service_repository.dart';
import 'package:mobile/features/services/presentation/screen/services_screen.dart';
import 'package:mobile/features/cart/bloc/cart_bloc.dart';
import 'package:mobile/features/cart/data/repoaitories/cart_repository.dart';
import 'package:mobile/features/bookings/bloc/booking_bloc.dart';
import 'package:mobile/features/bookings/data/repositories/booking_repository.dart';
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

    BlocProvider(
  create: (_) =>
      CartBloc(CartRepository()),
),

BlocProvider(
  create: (_) =>
      BookingBloc(
        BookingRepository(),
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
