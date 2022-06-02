
import 'package:flutter/material.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_scaffold.dart';
class SearchUserForBusinessPayment extends StatefulWidget {
  const SearchUserForBusinessPayment({Key? key}) : super(key: key);

  @override
  State<SearchUserForBusinessPayment> createState() => _SearchUserForBusinessPaymentState();
}

class _SearchUserForBusinessPaymentState extends State<SearchUserForBusinessPayment> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(

      appBar: AppBar(
        toolbarHeight: 80,

        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            //color: Colors.black,
            size: 15,
          ),
        ),
        title:Container(
          width: DeviceUtils.getScaledHeight(context, 0.6),
          height: 40,
          child: TextField(
          //  textAlign: TextAlign.center,

            decoration: InputDecoration(
              hintText: 'Search Here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(

                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
      Expanded(
        child: ListView.separated(
        itemCount:10,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("User Name"),
              subtitle: Text("9898989898"),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1077/1077012.png'),
              ),
              trailing:Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                    ),
                    child: Text('PAY', style: TextStyle(fontSize: 12,)

                      ,),
                    onPressed:(){
                      Routes.navigateToScreenWithArgs(context, Routes.pay_request_business_payment, {"type":'Pay','username':'User Name',"phone":"9898989898"});
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                    ),
                    child: Text('REQUEST', style: TextStyle(fontSize: 12,),),
                    onPressed:(){
                      Routes.navigateToScreenWithArgs(context, Routes.pay_request_business_payment, {"type":'Request','username':'User Name',"phone":"9898989898"});
                    },
                  ),
                ],
              )

            );

          },

        ),
      ),


        ],
      ),
    );
  }
}
