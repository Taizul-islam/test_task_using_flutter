import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/screen/auth/bloc/login_bloc_cubit.dart';
import 'package:test_task/screen/profile/profile_bloc/profile_bloc_cubit.dart';
import 'package:test_task/screen/trade/trade_bloc/trade_cubit.dart';
import 'package:test_task/screen/welcome/splash_screen.dart';
import 'package:test_task/service/api_service.dart';

void main() {
  //create only one instance for api service
  ApiService apiService = ApiService();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {

  final ApiService apiService;

  const MyApp({Key? key,required this.apiService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(apiService)),
        BlocProvider(create: (context) => ProfileBloc(apiService)),
        BlocProvider(create: (context) => TradeBloc(apiService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        title: "Test App",
        home:const SplashScreen()
      ),
    );
  }
}
