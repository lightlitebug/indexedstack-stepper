import 'package:flutter/material.dart';
import 'package:i_stack/input_data.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class FirstStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inputData = Provider.of<InputData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            labelText: 'Name',
            hintText: 'Enter your name',
          ),
          validator: (String val) {
            if (val == null || val.trim().isEmpty) {
              return 'Need your name';
            }
            if (val.length < 2) {
              return 'Name too short';
            }
            return null;
          },
          onSaved: (val) {
            inputData.name = val;
          },
        ),
        SizedBox(height: 30.0),
        TextFormField(
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'Email',
            hintText: 'Enter your email',
          ),
          validator: (String val) {
            if (!isEmail(val)) {
              return 'Invalid email';
            }
            return null;
          },
          onSaved: (val) {
            inputData.email = val;
          },
        ),
      ],
    );
  }
}
