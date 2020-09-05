import 'package:fettle/providers/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../constants.dart';
import '../../shared/bottomNavBar.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../shared/buttons.dart';
import 'newEntry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DreamDiary extends StatefulWidget {
  const DreamDiary({
    Key key,
  }) : super(key: key);

  @override
  _DreamDiaryState createState() => _DreamDiaryState();
}

class _DreamDiaryState extends State<DreamDiary> {
  bool writingNewEntry = false;
  List<QueryDocumentSnapshot> entries = [];
  Future initialLoadOfEntries;

  @override
  void initState() {
    super.initState();
    initialLoadOfEntries = fetchEntries();
  }

  Future fetchEntries() async {
    print('fetching entries');
    QuerySnapshot newEntries = await FirebaseFirestore.instance
        .collection('dreamLogs')
        .doc(Provider.of<AuthProvider>(context, listen: false).userId)
        .collection('entries')
        .get();
    entries.addAll(newEntries.docs);
    return;
  }

  void submitNewEntry(DateTime entryDate, String title, String content,
      {bool cancel = false}) {
    if (cancel) {
      setState(() => writingNewEntry = false);
      return;
    }
    FirebaseFirestore.instance
        .collection('dreamLogs')
        .doc(Provider.of<AuthProvider>(context, listen: false).userId)
        .collection('entries')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'entryDate': entryDate.millisecondsSinceEpoch,
      'title': title,
      'content': content
    }).then((onValue) {
      writingNewEntry = false;
      fetchEntries().then((value) => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (writingNewEntry)
      return NewDreamDiaryEntry(submitNewEntry: submitNewEntry);
    return FutureBuilder(
        future: initialLoadOfEntries,
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState != ConnectionState.done) {
            if (snapshot.hasError) print(snapshot.error);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Dream Diary'),
                  ),
                  Expanded(child: ListView(children: <Widget>[])),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Dream Diary'),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: ListView(
                        children: entries
                            .map((entry) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(DateFormat.yMMMEd().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              entry.data()['entryDate']))),
                                      Text(entry.data()['title']),
                                    ]))
                            .toList())),
                Align(
                  alignment: Alignment.centerRight,
                  child: RawMaterialButton(
                    onPressed: () => setState(() => writingNewEntry = true),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
