class Habit {
  final String id;
  final String title;
  final DateTime dateTime;
  final Duration duration;
  final String notes;
  bool isCompleted=false;

  Habit({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.notes,
     this.isCompleted=false
  });
  factory Habit.fromJosn(Map<String,dynamic>j)=> Habit(
      id: j['id'],
      title: j['title'],
      dateTime: DateTime.parse(j['dateTime']),
      duration: Duration(minutes: j['duration']),
      notes: j['notes'],
      isCompleted: j['iscompleted']??false
  );

  Map<String,dynamic>toJson()=>{
    'id':id,
    'title':title,
    'dateTime':dateTime.toIso8601String(),
    'duration':duration.inMinutes,
    'notes':notes,
    'iscompleted' : isCompleted
  };



}