import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../utils/routes/routes.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Vehicle> vehicleData = [];



  addData() {

    vehicleData.add(Vehicle(
        titleText: "How to manage an event?",
       subTitle:
         "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to manage a payment?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to stay updated?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to create an account?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to protect privacy of account?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to create manage an event?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
    vehicleData.add(Vehicle(
        titleText: "How to invite friends?",
        subTitle:
            "You want the arrow in the left side for auto suggestion and import the suggested imports.",
        show: false));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      //isMenu: false,
      appBar: AppBar(
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
        shadowColor: Colors.transparent,
        title: const Text("FAQ'S"),
       //leading: Icon(Icons.arrow_back_ios_outlined,size: 15,),
      ),
      child: ListView.builder(
          itemCount: vehicleData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        vehicleData[index].show = !vehicleData[index].show;
                      });
                    },
                    icon: Icon(
                      vehicleData[index].show
                          ? Icons.remove_circle_outline
                          : Icons.add_circle_outline,
                      color: vehicleData[index].show
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  title: Text(
                    vehicleData[index].titleText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: vehicleData[index].show
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 80.0, right: 25.0, bottom: 10.0),
                  child: vehicleData[index].show
                      ? Column(
                          children: [
                            Text(
                              vehicleData[index].subTitle,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            const Divider()
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ],
            );
          }
          ),
    );
  }
}
