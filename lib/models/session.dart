class Session {
  final String day;
  int duration;
  final DateTime date;

  Session({this.day, this.duration, this.date});

  List<String> toMap() {
    return [day, duration.toString()];
  }

  bool workedToday(String workedDay){
    return workedDay == day ? true : false;
  }

  void addWorkTime(int workedMin){
    duration += workedMin;
  }

  @override
  String toString() {
    return 'Session{day: $day, duration: $duration}';
  }
}