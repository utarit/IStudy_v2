class Deadline {
  String deadlineName;
  DateTime deadlineTime;
  DateTime deadlineCreatedTime;


  Deadline({this.deadlineName, this.deadlineTime, this.deadlineCreatedTime});

  @override
  String toString() {
    return 'Deadline{title: $deadlineName, Day: $deadlineTime}';
  }
}