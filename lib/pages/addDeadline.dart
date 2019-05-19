import "package:flutter/material.dart";

class AddDeadline extends StatefulWidget {
  @override
  _AddDeadlineState createState() => _AddDeadlineState();
}

class _AddDeadlineState extends State<AddDeadline> {
  DateTime selectedDate = DateTime.now();
  TextEditingController controller = TextEditingController();
  bool _validate = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) =>
            SingleChildScrollView(child: child),
        initialDate: selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Deadline"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter the Deadline',
                  errorText: _validate
                      ? 'Deadline\'s length should be between 1 and 30'
                      : null,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                RaisedButton(
                  child: Text("Pick Date"),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            RaisedButton(
              child: Text("Submit this"),
              onPressed: () {
                if (!(controller.text.length > 0 && controller.text.length < 31)) {
                  setState(() {
                    _validate = true;
                  });
                } else {
                  setState(() {
                    _validate = false; 
                  });
                  Map<String, dynamic> data = {
                    'deadlineName': controller.text,
                    'deadlineDate': selectedDate
                  };
                  Navigator.pop(context, data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
