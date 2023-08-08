import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/screen/welcome/start_page.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_password_field_widget.dart';
import '../../common_widgets/custom_text_field_widget.dart';
import '../../utils/common.dart';
import 'bloc/login_bloc_cubit.dart';
import 'bloc/login_bloc_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  setDefaultValueToController(){
    userController.text = '2088888';
    passwordController.text = 'ral11lod';
    setState((){});
  }
  setDispose(){
    userController.dispose();
    passwordController.dispose();
  }
  @override
  void initState(){
    super.initState();
   setDefaultValueToController();
  }
  @override
  void dispose(){
    super.dispose();
    setDispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text("Login",style: TextStyle(color: Colors.white,),),
          centerTitle: true,
          automaticallyImplyLeading: false,

        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common.fieldTitle18("Email"),
                CustomTextField(
                    hintText: 'Enter user',
                    iconData: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.email,
                        )),
                    controller: userController,
                    isObscure: false,
                    onChanged: (val) {}),
                const SizedBox(height: 30),
                Common.fieldTitle18("Password"),
                CustomPasswordField(
                    hintText: 'Enter password',
                    controller: passwordController,
                    onChanged: (val) {
                      // context.read<LoginBloc>().checkValidate();
                    }),
                const SizedBox(height: 35),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {

                    if (state.isSuccess == true) {
                      context.read<LoginBloc>().setDefault();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()));
                    }

                  },
                  builder: (context, state) {
                    return CustomButton(
                      btnText: 'Login',
                      color: Colors.white,
                      textColor: Colors.white,
                      isLoading: state.loading,
                      progressColor: Colors.white,
                      onTap: () {
                        context.read<LoginBloc>().loginRequest(context,userController.text,passwordController.text);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
