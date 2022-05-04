import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/ui/Event/create_event.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import 'package:flutter/rendering.dart';
import '../../widgets/rounded_button_widget.dart';

class Add_contacts extends StatefulWidget {
  const Add_contacts({Key? key}) : super(key: key);

  @override
  State<Add_contacts> createState() => _Add_contactsState();
}

class _Add_contactsState extends State<Add_contacts> {
  final PostStore _postStore = PostStore(getIt<Repository>());
  int selectedRadio = -1;
  late List<Contact> _contacts = [];
  late List<String?> _contactStrings = [];
  late var appContacts = [];
  late var filteredContactList = [];
  List<CheckContactResponse> selectContacts = [];


  changeValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
            .map((e) => e.phones?.map((i) => i.value).toList())
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
              filteredContactList = appContacts;
            });
          }
        }).catchError((err) {
          print(err.toString());
        });
      });
    } else {
      setState(() {
        appContacts = [];
        filteredContactList = appContacts;
      });
    }
  }

  Widget getContactListTile( int index) {
    var contentData = filteredContactList[index];
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
            value: contentData.visible,
            activeColor: Colors.white,
            checkColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.00))),
            onChanged: (changeValue) {
              setState(() {
                contentData.visible = !contentData.visible;
                if(contentData.visible == true)
                  {
                    selectContacts.add(contentData as CheckContactResponse) ;
                  }
                else
                  {
                    selectContacts.removeWhere((element) => element.contact == contentData);
                  }
                //if(changeValue == true){
                 // visible = true;
                //}
                 //else {
                //visible = false;
                //}
                // if (changeValue == true) {
                //   //checked[index] = true;
                //   checked = true;
                //   isChecked[index] = checked;
                // } else {
                //   isChecked[index] = false;
                // }
                //isChecked[index] = checked;
                //_title = _getTitle();
              });
            },
          ),
        ),
        title: Text(contentData.phone!));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {

 //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Create_event( CheckContactmodel: conte )));

    // setState(() {
              //
              //   // filteredContactList[index] == true ?
              //   // Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //     builder: (context) => Create_event(),)): print('error');
              // });
            },
          ),
        ],
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
                          height: 500,
                          // width: 460,
                          width: MediaQuery.of(context).size.width / 0.0,
                          child: ListView.builder(
                              itemCount: filteredContactList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return getContactListTile(
                               index);
                              }),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButtonWidget(
                              buttonText: 'Confirm',
                              buttonColor: AppColors.primaryColor,
                              onPressed: () {},
                            ),
                          ),
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
