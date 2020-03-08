import 'package:flutter/material.dart';
import 'package:i_stack/input_data.dart';
import 'package:provider/provider.dart';

class ThirdStep extends StatelessWidget {
  final Function submit;
  final TextEditingController controller = TextEditingController();

  ThirdStep({this.submit});

  @override
  Widget build(BuildContext context) {
    final inputData = Provider.of<InputData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          style: TextStyle(fontSize: 18.0),
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
          validator: (String val) {
            if (val == null || val.trim().isEmpty) {
              return 'Need your password';
            }
            if (val.length < 3) {
              return 'Password too short';
            }
            return null;
          },
          onSaved: (val) {
            inputData.password = val;
          },
        ),
        SizedBox(height: 30.0),
        TextFormField(
          style: TextStyle(fontSize: 18.0),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Confirm password',
            hintText: 'Re-enter your password',
          ),
          validator: (String val) {
            if (controller.text != val) {
              return 'Passwords not match';
            }
            return null;
          },
        ),
        SizedBox(height: 30.0),
        MaterialButton(
          padding: EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 12.0,
          ),
          color: Colors.indigo,
          textColor: Colors.white,
          child: Text(
            'SUBMIT',
            style: TextStyle(fontSize: 18.0),
          ),
          onPressed: submit,
        ),
      ],
    );
  }
}
