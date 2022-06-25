import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../utils/Global_methods/GlobalStoreHandler.dart';
import '../../utils/routes/routes.dart';

class Feedback_list extends StatefulWidget {
  const Feedback_list({Key? key}) : super(key: key);

  @override
  State<Feedback_list> createState() => _Feedback_listState();
}

class _Feedback_listState extends State<Feedback_list> {
  List<EventFeedbacks> feedbackList = [];
  bool isApiLoading = true;
  int eventId = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      try {
        eventId = ModalRoute.of(context)!.settings.arguments as int;
      } catch (e) {
        print("${e.toString()}");
      }
      getFeedbackList();
    });
  }

  void getFeedbackList() {
    setState(() {
      isApiLoading = true;
    });
    GlobalMethods.showLoader();
    GlobalStoreHandler.userStore.Feedback_list(eventId,
        (FeedbackListModel master) {
      GlobalMethods.hideLoader();
      isApiLoading = false;
      if (master != null) {
        feedbackList = master.eventFeedbacks ?? [];
      }
      setState(() {});
    }, (error) {
      print(error.toString());
      GlobalMethods.hideLoader();
      setState(() {
        isApiLoading = false;
      });
    });
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
        title: Text('Feedbacks'),
        shadowColor: Colors.transparent,
      ),
      child: !isApiLoading && feedbackList.isNotEmpty
          ? ListView.builder(
              padding:
                  EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
              itemCount: feedbackList.length,
              itemBuilder: (BuildContext context, int index) {
                EventFeedbacks feedback = feedbackList[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                      title: Text(
                        feedback?.event?.name ?? "",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Container(
                                height: 20,
                                width: 20,
                                child: Image.network(getIcon(feedback))),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Text(
                                feedback?.description ?? "",
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      )),
                );
              })
          : Center(child: Text("No feedbacks")),
    );
  }

  String getIcon(EventFeedbacks feedback) {
    if (feedback!.rate != null) {
      if (feedback!.rate!.toLowerCase() == "good") {
        return "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/48/slightly-smiling-face_1f642.png";
      } else if (feedback!.rate!.toLowerCase() == "verygood") {
        return "https://cdn.pixabay.com/photo/2020/12/27/20/24/smile-5865208_1280.png";
      } else if (feedback!.rate!.toLowerCase() == "excellent") {
        return "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/facebook/158/slightly-smiling-face_1f642.png";
      }
    }
    return "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/48/slightly-smiling-face_1f642.png";
  }
}
