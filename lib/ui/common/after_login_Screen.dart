import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
class After_LoginScreen extends StatefulWidget {
  const After_LoginScreen({Key? key}) : super(key: key);

  @override
  _After_LoginScreenState createState() => _After_LoginScreenState();
}

class _After_LoginScreenState extends State<After_LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130),
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://cdn-icons-png.flaticon.com/512/1177/1177568.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('free guide will tell about the ', style: TextStyle(fontSize: 13.0,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButtonWidget(
                  textColor: Colors.black,
                    buttonColor: Colors.orangeAccent,
                    buttonText: 'Business Owner',
                    onPressed: (){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButtonWidget(
                  buttonText: 'Individual User',
                    buttonColor: Colors.orangeAccent,
                    textColor: Colors.black,
                    onPressed: (){},

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
