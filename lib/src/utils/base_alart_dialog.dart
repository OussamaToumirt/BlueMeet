import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';
class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!
  Color _color = CustomTheme.white;
  String _title;
  Widget _content;
  String _yes;
  String _no;
  Function _yesOnPressed;
  Function _noOnPressed;

  BaseAlertDialog({String title, Widget content, Function yesOnPressed, Function noOnPressed, String yes = "Submit", String no = "Cancel"}){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this._title),
      content: this._content,
      backgroundColor: this._color,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(this._yes,style: CustomTheme.displayTextBoldColoured,),
          onPressed: () {
            this._yesOnPressed();
          },
        ),
        new FlatButton(
          child: Text(this._no,style: CustomTheme.displayErrorText,),
          onPressed: () {
            this._noOnPressed();
          },
        ),
      ],
    );
  }
}