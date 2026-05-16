import 'package:flutter/material.dart';

import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  Future<void> logout(

    BuildContext context,
  )async {

    await StorageService.clearToken();

    if(!context.mounted) return;

    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (_)=> 
    const LoginScreen(),
    ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: ()=> logout(context),
          icon: const Icon(Icons.logout),
          )
        ],
      ),

      body:const Center(
        child: Text("Welcome to MenteCart"),
      )
    );
  }
}