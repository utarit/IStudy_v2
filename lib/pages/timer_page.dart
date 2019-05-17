import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:i_study/scoped_models/mainModel.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimerState createState() => new _TimerState();
}

class _TimerState extends State<TimerPage> {

   String formattedNumber(int number){
    if(number < 10) {
      return "0" + "$number";
    } else {
      return "$number";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: ScopedModelDescendant<MainModel>(builder: (builder, child, model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
                child:Slider(value: model.minutes.toDouble(),
                  label: "${model.minutes} min",
                  onChanged: model.isClockActive ? null: (double newValue) {
                    setState(() {
                      model.minutes = newValue.toInt();
                    });
                  }, min: 1.0, max: 120.0, divisions: 23, ),
              ),
              Center(
                  child: new CircularPercentIndicator(
                    radius: 200.0,
                    lineWidth: 12.0,
                    percent: model.isClockActive ? (model.remaining.inSeconds / (model.minutes*60)) : 1.0,
                    center: new Text(
                      "${!model.isClockActive ? formattedNumber(model.minutes): formattedNumber(model.remaining.inMinutes)}:${!model.isClockActive ? "00": formattedNumber(model.remaining.inSeconds % 60)}",
                      style: TextStyle(fontSize: 35),
                    ),
                    progressColor: Colors.green,
                  )),
              Container(
                child: RaisedButton(onPressed: (){
                  model.onTimerClick();
                }, child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.0), child: Text(model.isClockActive ? "Stop!": "Start!"),)
                ),
              )
            ],
          );
        })
    );
  }


}
