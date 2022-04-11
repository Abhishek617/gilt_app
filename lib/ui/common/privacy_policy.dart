import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/models/PageModals/privacyPolicyModal.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/PageModals/success_error_args.dart';
import '../../utils/routes/routes.dart';

class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({Key? key}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  late UserStore _postStore;
  PrivacyPolicyModal? policyData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postStore = Provider.of<UserStore>(context);
    _postStore.getAppContent('privacy_policy').then((value) {
      setState(() {
        policyData = PrivacyPolicyModal.fromJson(value);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  Widget getPolicyWidgets() {
    if (policyData != null) {
      return Column(
        children: policyData!.data!.data!
            .map(
              (item) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    item.title!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    item.description!,
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (item.subdescription != null)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.subdescription!
                            .map((i) => Text('\n 	• '+i.label.toString(),style: TextStyle(fontSize: 12),),)
                            .toList())
                  else
                    SizedBox(),
                ],
              ),
            )
            .toList(),
      );
    } else {
      return Text('No Data found');
    }
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
          shadowColor: Colors.transparent,
          title: Text(policyData?.data?.title.toString() ?? 'Privacy & Policy'),
          centerTitle: true,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: getPolicyWidgets(),
            ),
          ),
        ));
  }
}
