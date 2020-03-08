import 'package:flutter/material.dart';
import 'package:i_stack/input_data.dart';
import 'package:provider/provider.dart';

class SecondStep extends StatefulWidget {
  final TextEditingController dateController;

  SecondStep(this.dateController);

  @override
  _SecondStepState createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  @override
  Widget build(BuildContext context) {
    final inputData = Provider.of<InputData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
          isExpanded: true,
          elevation: 12,
          itemHeight: kMinInteractiveDimension + 10,
          underline: Container(
            height: 2.0,
            color: Colors.grey[400],
          ),
          items: ['Male', 'Female']
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              )
              .toList(),
          value: inputData.gender,
          onChanged: (value) => setState(() => inputData.gender = value),
        ),
        SizedBox(height: 30.0),
        GestureDetector(
          onTap: () async {
            final birthday = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1920),
              lastDate: DateTime.now(),
              initialDatePickerMode: DatePickerMode.year,
            );
            if (birthday != null) {
              inputData.dateOfBirth = birthday.toString().split(' ')[0];
              widget.dateController.text = inputData.dateOfBirth;
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.dateController,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: 'Birth Date',
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Need your birthday';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
