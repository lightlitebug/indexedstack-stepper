import 'package:flutter/material.dart';
import 'package:i_stack/first_step.dart';
import 'package:i_stack/input_data.dart';
import 'package:i_stack/second_step.dart';

import 'package:i_stack/step_button.dart';
import 'package:i_stack/third_step.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedStack = 0;
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  bool autovalidate = false;
  TextEditingController dateController = TextEditingController();

  void submit() async {
    setState(() => autovalidate = true);

    if (!_fKey.currentState.validate()) {
      return;
    }

    _fKey.currentState.save();

    final inputData = Provider.of<InputData>(
      context,
      listen: false,
    );

    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Your Input'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('name: ${inputData.name}'),
                    Text('email: ${inputData.email}'),
                    Text('gender: ${inputData.gender}'),
                    Text('birthday: ${inputData.dateOfBirth}'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'You got 100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                inputData.name = '';
                inputData.email = '';
                inputData.gender = 'Male';
                inputData.dateOfBirth = '';
                inputData.password = '';

                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('CANCEL'),
            ),
          ],
        );
      },
    );

    if (result) {
      _fKey.currentState.reset();
      dateController.text = '';
      setState(() => autovalidate = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indexed Stack'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green[200],
              width: double.infinity,
              height: 60,
              child: Align(
                  child: Text(
                'Check Your Luck',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Form(
              key: _fKey,
              autovalidate: autovalidate,
              child: Expanded(
                child: IndexedStack(
                  index: selectedStack,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: FirstStep(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: SecondStep(dateController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: ThirdStep(submit: submit),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StepButton(
                    selected: selectedStack == 0,
                    step: '1',
                    onPressed: () => setState(() => selectedStack = 0),
                  ),
                  StepButton(
                    selected: selectedStack == 1,
                    step: '2',
                    onPressed: () => setState(() => selectedStack = 1),
                  ),
                  StepButton(
                    selected: selectedStack == 2,
                    step: '3',
                    onPressed: () => setState(() => selectedStack = 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
