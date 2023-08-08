import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task/screen/auth/login_screen.dart';
import 'package:test_task/screen/trade/trade.dart';
import 'package:test_task/screen/welcome/start_page.dart';
import 'package:test_task/service/api_service.dart';
import 'package:test_task/utils/const.dart';

import '../profile/personal_info.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  ApiService apiService= ApiService();
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async{
    String token =await getStringPrefs(TOKEN);
    Timer(
        const Duration(seconds: 1),
            () {
          if(token.isEmpty) {
            Timer(
                const Duration(seconds: 1),
                    () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen())));
          }else{
            Timer(

                const Duration(seconds: 1),
                    () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const StartPage())));
          }
            });
    
  }
  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding:const EdgeInsets.symmetric(),
          decoration:const  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.9,
                ],
                colors: [Color(0xff00639C), Color(0xff00AFDE)],
              )),
          child:const Center(
            child: Text(
              "Welcome To Our Company",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
