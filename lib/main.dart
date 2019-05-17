import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'pages/timer_page.dart';
import 'pages/profile_page.dart';
import 'pages/calendar_page.dart';
import './scoped_models/mainModel.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //@override
  int _selectedIndex = 1;
  final appModel = MainModel();

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = [
      CalendarPage(),
      TimerPage(),
      ProfilePage(),
    ];

    return ScopedModel<MainModel>(
      model: appModel,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text('Calendar')),
            BottomNavigationBarItem(icon: Icon(Icons.timer), title: Text('Timer')),
            BottomNavigationBarItem(icon: Icon(Icons.face), title: Text('Profile')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  void addEvent(){

  }
}
