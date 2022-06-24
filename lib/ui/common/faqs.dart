import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
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
  bool _customTileExpanded = false;
  int selected = 0;
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

  List<Widget> _getChildren(int count, String name) => List<Widget>.generate(
        count,
        (i) => ListTile(title: Text('$name$i')),
      );

  Widget getConditionsWidgets() {

    if (contentData != null) {

      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: contentData!.data!.data!.length,
        itemBuilder: (_, index) {
          bool expansValue = index==selected?false:false;
          print("expansValue: $expansValue");
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                key: Key(index.toString()),

              initiallyExpanded : index ==selected,

              leading: Icon(
                selected == index? Icons.remove_circle_outline
                    : Icons.add_circle_outline_sharp,
              ),

                trailing: SizedBox(),

                // controlAffinity: ListTileControlAffinity.leading,
                title: Text(contentData!.data!.data![index].question.toString(),
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                children: [
                  Visibility(
                    visible: _customTileExpanded,
                    child: ListTile(
                      title: Text(
                          contentData!.data!.data![index].answer.toString(),
                          style: TextStyle(color: Colors.grey)),
                      leading: SizedBox(),
                    ),
                  ),

                  Divider(color: Colors.black12,)
                ],
            onExpansionChanged: (expanded){
              if (expanded)
                setState(() {
                  // Duration(seconds: 20000);
                  _customTileExpanded = expanded;
                  selected = index;
                });
              else
                setState(() {
                  selected = -1;
                });
              // setState(() => _customTileExpanded = expanded);
            },
            ),
          );
        },
      );
    } else {
      return Text('No Data found');
    }
  }
  // _Product_ExpandAble_List_Builder(int cat_id) {
  //   List<Widget> columnContent = [];
  //   [1, 2, 4, 5].forEach((product) => {
  //     columnContent.add(
  //       ListTile(
  //         title: ExpansionTile(
  //           title: Text(product.toString()),
  //         ),
  //         trailing: Text("$product (Kg)"),
  //       ),
  //     ),
  //   });
  //   return columnContent;
  // }
  @override
  void initState() {
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
        ));
  }
}
