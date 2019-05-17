import 'package:scoped_model/scoped_model.dart';
import 'package:quiver/async.dart';

import '../models/session.dart';
import '../models/deadline.dart';

class MainModel extends Model {
  List<Session> sessionList = [
    Session(day: "12 May 2019", duration: 55),
    Session(day: "13 May 2019", duration: 15),
    Session(day: "14 May 2019", duration: 25),
    Session(day: "15 May 2019", duration: 45),
  ];

  List<Deadline> deadlineList = [];

  int minutes = 1;
  bool isClockActive = false;
  CountdownTimer timer;
  Duration remaining;

  void resetTimer() {
    isClockActive = false;
    timer.cancel();
    notifyListeners();
  }

  void onTimerClick() {
    if (isClockActive) {
      resetTimer();
    } else {
      isClockActive = true;
      remaining = Duration(seconds: minutes * 60);
      timer =
      new CountdownTimer(Duration(minutes: minutes), Duration(seconds: 1));
      timer.listen((onData) {
        remaining = onData.remaining;
        notifyListeners();
        if (onData.remaining.inSeconds < 0.5) {
          final List<String> months = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec"
          ];

          DateTime today = DateTime.now();
          String dateStr =
              "${today.day} ${months[today.month - 1]} ${today.year}";

          if (isClockActive && sessionList.last.workedToday(dateStr)) {
            print("1: ${sessionList.last.duration} -- $minutes");
            sessionList.last.addWorkTime(minutes);
            print("2: ${sessionList.last.duration} -- $minutes");
          } else if (isClockActive) {
            print("3: ${sessionList.last.duration} -- $minutes");
            sessionList
                .add(Session(day: dateStr, duration: minutes, date: today));
            print("4: ${sessionList.last.duration} -- $minutes");
          }

          isClockActive = false;
          notifyListeners();
          return;
        }
      });
    }
  }

  void addDeadline(String title, DateTime date){
      Deadline newDeadline = Deadline(deadlineName: title, deadlineTime: date, deadlineCreatedTime: DateTime.now());
      deadlineList.add(newDeadline);
      notifyListeners();
  }

  void removeDeadline(int index){
    deadlineList.removeAt(index);
    notifyListeners();
  }

}















/*


Future<Database> openDB() async {
  return openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), 'istudy_database.db'),
  // When the database is first created, create a table to store dogs
      onCreate: (db, version) {
  return db.execute(
  "CREATE TABLE sessions(day TEXT PRIMARY KEY, duration INTEGER)",
  );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
  );
}

  Future<void> insertSession(Session session, Database database) async {
    // Get a reference to the database
    final Database db = await database;

    await db.insert(
      'sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Session>> sessions(Database database) async {
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.query('sessions');

    return List.generate(maps.length, (i) {
      return Session(
        day: maps[i]['day'],
        duration: maps[i]['duration'],
      );
    });
  }


  Future<void> updateSession(Session session, Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.update(
      'sessions',
      session.toMap(),
      where: "day = ?",
      whereArgs: [session.day],
    );
  }

  Future<void> deleteSession(String day, Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.delete(
      'sessions',
      where: "day = ?",
      whereArgs: [day],
    );
  }

  Future<void> deleteAllTable(Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.delete(
      'sessions'
    );
  } */



/*
class SessionModel extends Model {
  List<Session> sessionList = [
    Session(day: "12 May 2019", duration: 55),
    Session(day: "13 May 2019", duration: 15),
    Session(day: "14 May 2019", duration: 25),
    Session(day: "15 May 2019", duration: 45),
  ];

  List<Event> eventList = [];

  int minutes = 1;
  bool isClockActive = false;
  CountdownTimer timer;
  Duration remaining;

  void resetTimer() {
    isClockActive = false;
    timer.cancel();
    notifyListeners();
  }

  void onTimerClick() {
    if (isClockActive) {
      resetTimer();
    } else {
      isClockActive = true;
      remaining = Duration(seconds: minutes * 60);
      timer =
      new CountdownTimer(Duration(minutes: minutes), Duration(seconds: 1));
      timer.listen((onData) {
        remaining = onData.remaining;
        notifyListeners();
        if (onData.remaining.inSeconds < 0.5) {
          final List<String> months = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec"
          ];

          DateTime today = DateTime.now();
          String dateStr =
              "${today.day} ${months[today.month - 1]} ${today.year}";

          if (isClockActive && sessionList.last.workedToday(dateStr)) {
            print("1: ${sessionList.last.duration} -- $minutes");
            sessionList.last.addWorkTime(minutes);
            print("2: ${sessionList.last.duration} -- $minutes");
          } else if (isClockActive) {
            print("3: ${sessionList.last.duration} -- $minutes");
            sessionList
                .add(Session(day: dateStr, duration: minutes, date: today));
            print("4: ${sessionList.last.duration} -- $minutes");
          }

          isClockActive = false;
          notifyListeners();
          return;
        }
      });
    }
  }

}




Future<Database> openDB() async {
  return openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), 'istudy_database.db'),
  // When the database is first created, create a table to store dogs
      onCreate: (db, version) {
  return db.execute(
  "CREATE TABLE sessions(day TEXT PRIMARY KEY, duration INTEGER)",
  );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
  );
}

  Future<void> insertSession(Session session, Database database) async {
    // Get a reference to the database
    final Database db = await database;

    await db.insert(
      'sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Session>> sessions(Database database) async {
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.query('sessions');

    return List.generate(maps.length, (i) {
      return Session(
        day: maps[i]['day'],
        duration: maps[i]['duration'],
      );
    });
  }


  Future<void> updateSession(Session session, Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.update(
      'sessions',
      session.toMap(),
      where: "day = ?",
      whereArgs: [session.day],
    );
  }

  Future<void> deleteSession(String day, Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.delete(
      'sessions',
      where: "day = ?",
      whereArgs: [day],
    );
  }

  Future<void> deleteAllTable(Database database) async {
    // Get a reference to the database
    final db = await database;

    await db.delete(
      'sessions'
    );
  }

}



mixin EventModel on MainModel {

}

*/
