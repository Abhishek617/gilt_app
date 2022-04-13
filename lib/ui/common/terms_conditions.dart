import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/TermsAndConditionsModal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';

class Terms_Condition extends StatefulWidget {
  const Terms_Condition({Key? key}) : super(key: key);

  @override
  State<Terms_Condition> createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {

  late UserStore _postStore;
  TermsAndConditionsModal? contentData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postStore = Provider.of<UserStore>(context);
    _postStore.getAppContent('terms_and_conditions').then((value) {
      setState(() {
        contentData = TermsAndConditionsModal.fromJson(value);
        print('Terms and Conditions');
        print(contentData!.data!.title!.toString());
      });
    }).catchError((error) {
      print(error.toString());
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
          title: Text(contentData?.data?.title?.toString() ?? 'Terms and Conditions'),
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
  }
}
