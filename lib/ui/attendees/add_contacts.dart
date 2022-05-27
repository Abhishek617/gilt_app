import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import 'package:flutter/rendering.dart';
import '../../widgets/rounded_button_widget.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final PostStore _postStore = PostStore(getIt<Repository>());
  int selectedRadio = -1;
  late List<Contact> _contacts = [];
  late List<bool> _selectedContacts = [];
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
    GlobalMethods.showLoader();
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it
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
                _selectedContacts = List.filled(
                    filteredContactList.length, false,
                    growable: true);
              } else {
                appContacts = [];
                filteredContactList = [];
              }
            });
          } else {
            appContacts = [];
            filteredContactList = [];
          }
          GlobalMethods.hideLoader();
        }).catchError((err) {
          GlobalMethods.hideLoader();
          print(err.toString());
        });
      });
    } else {
      GlobalMethods.hideLoader();
      setState(() {
        appContacts = [];
        filteredContactList = appContacts;
      });
    }
  }

  Widget getContactListTile(AppContact contactData, index) {
    return ListTile(
        leading: Container(
          height: 40,
          width: 40,
          // margin: EdgeInsets.all(100.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.icons8.com/color/344/person-male.png'),
                fit: BoxFit.fill,
              ),
              color: Colors.orange,
              shape: BoxShape.circle),
        ),
        trailing:
            //Icon(Icons.radio_button_unchecked, size: 15,),
            Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2.3),
          ),
          height: 20,
          width: 20,
          child: Checkbox(
            activeColor: Colors.white,
            checkColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.00))),
            onChanged: (changeValue) {
              setState(() {
                _selectedContacts[index] = changeValue!;
                //_title = _getTitle();
              });
            },
            value: _selectedContacts[index],
          ),
        ),
        title: Text(contactData.firstname! +
            ' ' +
            contactData.lastname! +
            '\n' +
            contactData.phone!));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (data) {
                  if (data.length > 0) {
                    print('Searched Text : ' + data);
                    // TODO : Filter Contact List as per search Text
                  }
                },
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
                  "Contact List",
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
                          height: DeviceUtils.getScaledHeight(context, 0.58),
                          // width: 460,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: filteredContactList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return getContactListTile(
                                    filteredContactList[index], index);
                              }),
                        ),
                        Container(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: ElevatedButtonWidget(
                                    buttonText: 'Confirm',
                                    buttonColor: AppColors.primaryColor,
                                    onPressed: () {
                                      List<Attendees> selectedPhones = [];
                                      for (var i = 0;
                                          i < _selectedContacts.length;
                                          i++) {
                                        if (_selectedContacts[i] == true) {
                                          selectedPhones
                                              .add(Attendees(phone:filteredContactList[i].phone,expanse:0) );
                                        }
                                      }
                                      Navigator.pop(context,selectedPhones);
                                      // Routes.navigateToScreenWithArgs(context,
                                      //     Routes.create_event, selectedPhones);
                                    }))),
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
