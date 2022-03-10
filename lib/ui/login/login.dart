import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';

import '../../widgets/rounded_button_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
              size: 15,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: AppLogoWidget(
                      width: 140.0,
                      height: 140.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                      'Guilt App',
                      style: TextStyle(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 30),
                    child: Container(
                     // height: 50,
                      width: 310,
                      child: TextFormField(
                        // controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail,),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Mail',

                        ),
                        validator: (val){
                          if(val!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)){
                            return "Enter a valid Email";
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),


              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 310,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: passenable,//This will obscure text dynamically
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_sharp,),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passenable
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                           if(passenable){
                             passenable = false;
                           }else{
                             passenable = true;
                           }
                          });
                        },
                      ),

                    ),
                    validator: (val){
                      if(val!.isEmpty){
                        return "Enter a valid password";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
              ),


                  Padding(
                    padding: const EdgeInsets.only(left: 210, top: 10),
                    child: GestureDetector(
                        onTap: () {
                          Routes.navigateToScreen(context, Routes.forgot_password);
                        },
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                            fontSize: 13.0,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Login Success',
                      buttonColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                         if(formkey.currentState!.validate()){
                           Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: true, description: 'Logged in successfully', title: 'Success', isPreviousLogin: true));
                         }else{
                           print('Eroor');
                         }
                        //Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: true, description: 'Logged in successfully', title: 'Success', isPreviousLogin: true));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Login Fail',
                      buttonColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: false, description: 'Something went wrong', title: 'Error', isPreviousLogin: true));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Container(
                        child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 14,decoration: TextDecoration.underline,fontStyle: FontStyle.italic),

                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Routes.navigateToScreen(context, Routes.signup);
                                    })
                            ]),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("https://cdn-icons-png.flaticon.com/512/6956/6956877.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Face Recognition',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


