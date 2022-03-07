import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';

class Reset_password extends StatefulWidget {
  const Reset_password({Key? key}) : super(key: key);

  @override
  _Reset_passwordState createState() => _Reset_passwordState();
}

class _Reset_passwordState extends State<Reset_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Icon(
          Icons.arrow_back_ios_outlined,color: Colors.black, size: 15,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) ,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 30),
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 30),
            child: Container(
              height: 50,
              width: 320,

              child: TextField(
                // controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(

                  ),
                  labelText: '   Enter Mail Or Phone',
                ),
              ),
            ),
          ),
           Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
                child: Container(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.otp, (Route<dynamic> route) => false);
                      },
                      child: Text('Reset Password')),
                ),

            ),

        ],
      ),
    );
  }
}
