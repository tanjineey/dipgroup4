import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../constants.dart';
import '../../shared/bottomNavBar.dart';
import 'package:provider/provider.dart';
import '../../../../providers/avatar.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../shared/buttons.dart';

class NewDreamDiaryEntry extends StatefulWidget {
  final Function submitNewEntry;
  const NewDreamDiaryEntry({
    Key key,
    this.submitNewEntry,
  }) : super(key: key);

  @override
  _NewDreamDiaryEntryState createState() => _NewDreamDiaryEntryState();
}

class _NewDreamDiaryEntryState extends State<NewDreamDiaryEntry> {
  DateTime newEntryDate = DateTime.now();
  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        widget.submitNewEntry(newEntryDate,
                            titleController.text, contentController.text,
                            cancel: true);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  MainButton(
                      onPressed: () => widget.submitNewEntry(newEntryDate,
                          titleController.text, contentController.text),
                      title: "Save Entry")
                ],
              )),
          InkWell(
              onTap: () {
                showDatePicker(
                        initialDate: newEntryDate,
                        firstDate: DateTime(2020, 1, 1, 17, 30),
                        lastDate: DateTime(2100, 1, 1, 17, 30),
                        context: context)
                    .then((date) {
                  if (date == null) return;
                  newEntryDate = date;
                  setState(() {});
                }).catchError((onError) {
                  print(onError);
                });
              },
              child: Text(DateFormat.yMMMEd().format(newEntryDate))),
          // Expanded(
          //     child: ListView(children: <Widget>[
          //   TextField(
          //     keyboardType: TextInputType.multiline,
          //     minLines: 8, //Normal textInputField will be displayed
          //     maxLines: 8, // when user presses enter it will adapt to it
          //   )
          // ])),
          TextField(
            controller: titleController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: 5),
          TextField(
            controller: contentController,
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.multiline,
            minLines: 8, //Normal textInputField will be displayed
            maxLines: 8, // when user presses enter it will adapt to it
          ),
        ],
      ),
    );
  }
}
