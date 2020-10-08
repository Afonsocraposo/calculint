import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({@required this.label, @required this.onPressed, Key key})
      : super(key: key);

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    bool isNumber = int.tryParse(this.label) != null;
    return Padding(
      padding: EdgeInsets.all(16),
      child: RaisedButton(
        color: isNumber ? Colors.black : Colors.orange,
        elevation: 3,
        onPressed: () {
          this.onPressed(this.label);
        },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(100.0),
        ),
        child: Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

