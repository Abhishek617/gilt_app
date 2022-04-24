import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import 'package:guilt_app/stores/user/user_store.dart';
import 'package:provider/provider.dart';

import '../../models/PageModals/faqs_model.dart';

import '../../utils/routes/routes.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late UserStore _postStore;
  FaqModel? contentData;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postStore = Provider.of<UserStore>(context);
    _postStore.getAppContent('faqs').then((value) {
      print(value);
      setState(() {
       contentData = FaqModel.fromJson(value);
        print('faqs');
        print(contentData!.data?.title.toString());
      });
      GlobalMethods.hideLoader();
    }).catchError((error) {
      print(error.toString());
      GlobalMethods.hideLoader();
    });
  }
  Widget getConditionsWidgets() {
    if (contentData != null) {
      return Column(
        children: contentData!.data!.data!
            .map(
              (item) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                item.question as String,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                item.answer as String,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
            .toList(),
      );
    }
    else {
      return Text('No Data found');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        isMenu: false,
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
          title: Text(contentData?.data?.title ?? 'Faq'),
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Center(
              child: getConditionsWidgets(),
            ),
          ),
        )
    );

    // child: ListView.builder(
    //     // itemCount: FaqsData.length,
    //     // itemBuilder: (context, index) {
    //     //   return Column(
    //     //     children: [
    //     //       ListTile(
    //     //         leading: IconButton(
    //     //           onPressed: () {
    //     //             setState(() {
    //     //               FaqsData[index].success = !FaqsData[index].success;
    //     //             });
    //     //           },
    //     //           icon: Icon(
    //     //             FaqsData[index].success
    //     //                 ? Icons.remove_circle_outline
    //     //                 : Icons.add_circle_outline,
    //     //             color: FaqsData[index].success
    //     //                 ? Theme.of(context).primaryColor
    //     //                 : Colors.black,
    //     //           ),
    //     //         ),
    //     //         title: Text(
    //     //           FaqsData[index].message,
    //     //           style: TextStyle(
    //     //               fontSize: 18,
    //     //               fontWeight: FontWeight.bold,
    //     //               color: FaqsData[index].success
    //     //                   ? Theme.of(context).primaryColor
    //     //                   : Colors.black),
    //     //         ),
    //     //       ),
    //     //       Padding(
    //     //         padding: const EdgeInsets.only(
    //     //             left: 80.0, right: 25.0, bottom: 10.0),
    //     //         child: FaqsData[index].success
    //     //             ? Column(
    //     //                 children: [
    //     //                   Text(
    //     //                     FaqsData[index].data as String,
    //     //                     style: TextStyle(fontSize: 14),
    //     //                   ),
    //     //                   const SizedBox(height: 5),
    //     //                   const Divider()
    //     //                 ],
    //     //               )
    //     //             : SizedBox.shrink(),
    //     //       ),
    //     //     ],
    //     //   );
    //     // }
    //     ),
  }
  }



