class Task{
String name;
TaskType type;
DateTime date;
bool isDone;
Task({this.date,this.isDone,this.name,this.type});
}

enum TaskType{
  personal,
  business
}