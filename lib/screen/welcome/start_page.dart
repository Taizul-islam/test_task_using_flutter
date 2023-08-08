import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/screen/auth/login_screen.dart';
import 'package:test_task/screen/profile/personal_info.dart';
import 'package:test_task/screen/profile/profile_bloc/profile_bloc_cubit.dart';
import 'package:test_task/screen/trade/trade_bloc/trade_cubit.dart';
import 'package:test_task/utils/const.dart';

import '../../common_widgets/custom_button.dart';
import '../trade/trade.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Select One",style: TextStyle(color: Colors.white,),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: InkWell(
        onTap: () async{
          clearPrefsData().then((value){
            Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
          });

        },
        child: Container(
          height: 50,
          decoration:const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            )
          ),
          child:const Center(
            child: Text('Logout',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              btnText: 'Profile Information',
              onTap: () {
                context.read<ProfileBloc>().profileData(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PersonalInfo()));
              },
              color:const Color(0xff36415F),
              textColor: Colors.white,
            ),
            const SizedBox(height: 15),
            CustomButton(
              btnText: 'Trade Information',
              onTap: () {
                context.read<TradeBloc>().tradeData(context,true);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TradePage()));
              },
              color:const Color(0xff36415F),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
