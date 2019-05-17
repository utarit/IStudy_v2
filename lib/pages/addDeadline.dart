import "package:flutter/material.dart";

class AddDeadline extends StatefulWidget {
  @override
  _AddDeadlineState createState() => _AddDeadlineState();
}

class _AddDeadlineState extends State<AddDeadline> {
  DateTime selectedDate = DateTime.now();
  String deadlineName = "";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) => SingleChildScrollView(
          child: child
        ),
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
              onChanged: (String str) {
                setState(() {
                  deadlineName = str;
                });
              },
            ),
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
                    Map<String, dynamic> data = {
                      'deadlineName': deadlineName,
                      'deadlineDate': selectedDate
                    };
                    Navigator.pop(context, data);
                  },
                ),
          ],
        ),
      ),
    );
  }
}
