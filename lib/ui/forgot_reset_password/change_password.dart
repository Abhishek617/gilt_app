import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class Change_password extends StatefulWidget {
  const Change_password({Key? key}) : super(key: key);
  @override
  _Change_passwordState createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: Icon(
          Icons.arrow_back_ios_outlined,color: Colors.black, size: 15,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppLogoWidget(
                  width: 140.0,
                  height: 140.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  width: 310,

                  child: TextField(
                    obscureText: passenable, //if passenable == true, show **, else show password character
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(

                        ),
                        hintText: "New Enter Password",
                        labelText: "Enter New Password",
                        suffix: IconButton(onPressed: (){ //add Icon button at end of TextField
                          setState(() { //refresh UI
                            if(passenable){ //if passenable == true, make it false
                              passenable = false;
                            }else{
                              passenable = true; //if passenable == false, make it true
                            }
                          });
                        }, icon: Icon(passenable == true?Icons.remove_red_eye:Icons.password))
                      //eye icon if passenable = true, else, Icon is ***__
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  width: 310,

                  child: TextField(
                    obscureText: passenable, //if passenable == true, show **, else show password character
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(

                        ),
                        hintText: "Enter Conform Password",
                        labelText: "Enter Conform Password",
                        suffix: IconButton(onPressed: (){ //add Icon button at end of TextField
                          setState(() { //refresh UI
                            if(passenable){ //if passenable == true, make it false
                              passenable = false;
                            }else{
                              passenable = true; //if passenable == false, make it true
                            }
                          });
                        }, icon: Icon(passenable == true?Icons.remove_red_eye:Icons.password))
                      //eye icon if passenable = true, else, Icon is ***__
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 15),
                child: ElevatedButtonWidget(
                  buttonColor: Colors.orangeAccent,
                    textColor: Colors.black,
                    buttonText: 'Change Password',
                    onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.login, (Route<dynamic> route) => false);
                    },
                    ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
