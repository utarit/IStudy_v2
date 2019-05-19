import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'addDeadline.dart';

import '../scoped_models/mainModel.dart';

class CalendarPage extends StatelessWidget {
  Color _colorPicker(int difference) {
    if (difference < 0) {
      return Colors.black26; 
    } else if (difference < 2) {
      return Colors.red;
    } else if (difference < 8) {
      return Colors.amber;
    } else {
      return Colors.green;
    }
  }

  String _textPicker(int difference){
    if(difference < 0){
      return "This deadline is over.";
    } else if(difference > 0) {
      return "$difference days left";
    } else {
      return "You are on Fire!";
    }
  }

  String _numberFormat(int number){
    if(number < 10){
      return "0$number";
    } else {
      return "$number";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (builder, child, model) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push<Map<String, dynamic>>(
                MaterialPageRoute(builder: (context) => AddDeadline()),
              )
                  .then((Map<String, dynamic> data) {
                if (data == null) {
                  return;
                }
                model.addDeadline(data["deadlineName"], data["deadlineDate"]);
              });
            },
          ),
          appBar: AppBar(
            title: Text("Your Deadlines"),
          ),
          body: ListView.builder(
              itemCount: model.deadlineList.length,
              itemBuilder: (BuildContext context, int index) {
                DateTime date = model.deadlineList[index].deadlineTime;
                int difference = date.difference(DateTime.now()).inDays;

                if(!(date.day == DateTime.now().day && date.month == DateTime.now().month) && difference >= 0){
                  difference++;
                }

                return Dismissible(
                  onDismissed: (DismissDirection direction) {
                    model.removeDeadline(index);
                  },
                  key: Key("${model.deadlineList[index].deadlineName}-${model.deadlineList[index].deadlineCreatedTime.millisecondsSinceEpoch}"),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    title: Text(model.deadlineList[index].deadlineName),
                    subtitle: Text("${_numberFormat(date.day)}/${_numberFormat(date.month)}/${date.year}"),
                    trailing: Text(
                      _textPicker(difference),
                      style: TextStyle(
                          color: _colorPicker(difference),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
