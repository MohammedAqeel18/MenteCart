import 'package:flutter/material.dart';
import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/home/presentation/screens/home.screen.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget{

const SplashScreen({super.key});

@override
State<SplashScreen> createState()=>
  _SplashScreenState();

}

class _SplashScreenState
    extends State<SplashScreen>{

      @override
      void initState(){
        super.initState();

        checkAuth();
      }

      Future<void> checkAuth() async{
        final token = 
        await StorageService.getToken();

        await Future.delayed(
          const Duration(seconds: 2),
        );

        if(!mounted) return;

        if(token !=null){
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_)=>
            const HomeScreen(),
          ),
          );
        }else{

          Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (_)=>
          const LoginScreen(),
          ),
          );
        }
      }

      @override
      Widget build(BuildContext context){
        return const Scaffold(
          body: Center(
            child: Text("MenteCart",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        );
      }
    }