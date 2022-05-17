import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import 'package:flutter/rendering.dart';
import '../../widgets/rounded_button_widget.dart';

class AddChatContacts extends StatefulWidget {
  const AddChatContacts({Key? key}) : super(key: key);

  @override
  State<AddChatContacts> createState() => _AddChatContactsState();
}

class _AddChatContactsState extends State<AddChatContacts> {
  final PostStore _postStore = PostStore(getIt<Repository>());
  int selectedRadio = -1;
  late List<Contact> _contacts = [];
  late List<String?> _contactStrings = [];
  late var appContacts = [];
  late var filteredContactList = [];

  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it
    GlobalMethods.showLoader();
    final Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    if (contacts.length > 0) {
      setState(() {
        _contacts = contacts.toList();
        _contactStrings = _contacts
            .map((e) => e.phones?.map((i) => i.value?.replaceAll(' ','')).toList())
            .toList()
            .reduce((p, el) {
          p?.addAll(el!);
          return p;
        })!;
        print('_contacts');
        print(_contactStrings);
        _postStore.checkContacts(_contactStrings).then((value) {
          if (value.contact != null) {
            setState(() {
              appContacts = value.contact;
              if (appContacts.length > 0) {
                appContacts.removeWhere((item) => item.isExist == 0);
                filteredContactList = appContacts;
                print(appContacts);
              } else {
                appContacts = [];
                filteredContactList = [];
              }
              GlobalMethods.hideLoader();
            });
          } else {
            setState(() {
              appContacts = [];
              filteredContactList = [];
            });
            GlobalMethods.hideLoader();
          }
        }).catchError((err) {
          print(err.toString());
          GlobalMethods.hideLoader();
        });
      });
    } else {
      setState(() {
        appContacts = [];
        filteredContactList = appContacts;
      });
      GlobalMethods.hideLoader();
    }
  }

  Widget getContactListTile(AppContact contactData) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        // margin: EdgeInsets.all(100.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(contactData.profile ??
                  'https://img.icons8.com/color/344/person-male.png'),
              fit: BoxFit.fill,
            ),
            color: Colors.orange,
            shape: BoxShape.circle),
      ),
      trailing:
          //Icon(Icons.radio_button_unchecked, size: 15,),
          Container(
        child: ElevatedButton(
            onPressed: () {
              G.socketUtils.joinNewPrivateUser(contactData);
              // TODO : get newly created room data
              // if (contactData.messageType == 'private') {
              Routes.navigateToScreen(context, Routes.chat);
              // } else if (msgData.lastMessage.messageType == 'event') {
              // Routes.navigateToScreen(context, Routes.event_chat);
              // } else {
              // Routes.navigateToScreen(context, Routes.business_chat);
            },
            child: Text('Message')),
      ),
      title: Text(
        (contactData.firstname ?? '') + ' ' + (contactData.lastname ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('New Message'),
      ),
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search Contact",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contacts",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              (filteredContactList.length > 0)
                  ? Column(
                      children: [
                        Container(
                          height: 500,
                          // width: 460,
                          width: MediaQuery.of(context).size.width / 0.0,
                          child: ListView.builder(
                              itemCount: filteredContactList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return getContactListTile(
                                    filteredContactList[index]);
                              }),
                        ),
                      ],
                    )
                  : Text('No Contacts available'),
            ],
          ),
        ),
      ),
    );
  }
}
