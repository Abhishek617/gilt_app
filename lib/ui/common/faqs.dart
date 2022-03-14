import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../models/PageModals/success_error_args.dart';
import '../../utils/routes/routes.dart';


class Faqs extends StatefulWidget {
  @override
  State<Faqs> createState() => new _FaqsState();
}

class _FaqsState extends State<Faqs> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(

        title: Text('FAQ\'S'),
      ),
      body: new ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            title: new Text(data[i].title, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, ),),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(data[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Vehicle data) {
    List<Widget> columnContent = [];

    for (String content in data.contents)
      columnContent.add(
        new ListTile(
          title: new Text(content, style: new TextStyle(fontSize: 18.0),),

        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];


  Vehicle(this.title, this.contents,);
}

List<Vehicle> data = [
  new Vehicle(
    'How To Mange a event?',
    [' you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to manage a payment?',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to stay update?',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to create account?',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to protect privacy a account',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to create a event',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
  new Vehicle(
    'How to invite friends',
    ['you want the arrow in the left side for auto suggestion and import the suggested imports'],

  ),
];