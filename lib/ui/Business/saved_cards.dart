import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

import '../../utils/routes/routes.dart';
import '../../widgets/custom_body_wrapper.dart';

class SavedCards extends StatefulWidget {
  const SavedCards({Key? key}) : super(key: key);

  @override
  State<SavedCards> createState() => _SavedCardsState();
}

class _SavedCardsState extends State<SavedCards> {
  List<String> cardList = ["1234", "5678"];

  @override
  Widget build(BuildContext context) {
    final layoutAddNewCard = Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          Routes.navigateToScreen(context, Routes.add_card);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add new"),
                ],
              ),
            ),
            Icon(
              Icons.radio_button_off_outlined,
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              //color: Colors.black,
              size: 16,
            ),
          ),
          title: Text(
            'Saved Cards',
          ),
          centerTitle: true,
        ),
        body: CustomBodyWrapper(
            child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: cardList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SavedCardItem(
                            onEdit: (){
                              Routes.navigateToScreen(
                                  context, Routes.edit_cards);
                            },
                            onDelete: (){},
                          );
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      layoutAddNewCard,
                    ],
                  ),
                ))));
  }
}

class SavedCardItem extends StatelessWidget {
  Function? onEdit;
  Function? onDelete;

  SavedCardItem({this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.grayTextColor.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 6,
            )
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Visa ****2345")),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  onDelete!();
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  onEdit!();
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
