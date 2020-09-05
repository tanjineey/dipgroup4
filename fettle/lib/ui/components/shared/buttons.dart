import 'package:flutter/material.dart';
import '../../../constants.dart';

class MainButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const MainButton({Key key, @required this.onPressed, @required this.title})
      : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: mainButtonColor)),
      color: mainButtonColor,
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Text(widget.title,
          style: TextStyle(color: Colors.white, fontSize: 14)),
      onPressed: widget.onPressed,
    );
  }
}
