import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:i_study/scoped_models/mainModel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: ScopedModelDescendant<MainModel>(
          builder: (builder, child, model) {
        return Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Image.asset('assets/pp_back.jpg'),
                Positioned(
                  bottom: -64,
                  left: width / 2 - 64,
                  child: new Container(
                    width: 128.0,
                    height: 128.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/robot.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "NerdBoy22",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(left: 15.0),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "Newbie",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(model.sessionList[index].day),
                    subtitle: Text("${model.sessionList[index].duration.toString()} min"),
                  );
                },
                itemCount: model.sessionList.length,
                reverse: true,
              ),
            )
          ],
        );
      }),
    );
  }
}
