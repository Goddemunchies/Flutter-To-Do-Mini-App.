final String TableNotes = 'notes';

class TodoFields {
  static final List<String> values = [
    id,
    todoText,
    isDone,
    createdTime,
    reminder
  ];
  static final String id = '_id';
  static final String todoText = 'todoText';
  static final String isDone = 'isDone';
  static final String createdTime = 'createdTime';
  static final String reminder = 'reminder';
}

class ToDoModel {
  int? id;
  String? todoText;
  bool isDone;
  final DateTime createdTime;
  final DateTime? reminder;

  ToDoModel(
      {required this.id,
      required this.todoText,
      this.isDone = false,
      required this.createdTime,
      this.reminder});

  ToDoModel copy({
    int? id,
    String? todoText,
    bool? isDone,
    DateTime? createdTime,
    DateTime? reminder,
  }) =>
      ToDoModel(
          id: id ?? this.id,
          todoText: todoText ?? this.todoText,
          createdTime: createdTime ?? this.createdTime,
          reminder: reminder ?? this.reminder); //Not sure what Copy does.
  //Mapping to Json

  static ToDoModel fromJson(Map<String, Object?> json) => ToDoModel(
        id: json[TodoFields.id] as int?,
        todoText: json[TodoFields.todoText] as String,
        isDone: json[TodoFields.isDone] == 1,
        createdTime: DateTime.parse(json[TodoFields.createdTime] as String),
        reminder: DateTime.parse(json[TodoFields.reminder] as String),
      );

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.todoText: todoText,
        TodoFields.createdTime: createdTime.toIso8601String(),
        TodoFields.reminder:
            reminder!.toIso8601String(), //Since it can be null.
        TodoFields.isDone: isDone
            ? 1
            : 0, //We've to convert the Boolean & DateTime when mapping to Json.
      };
}
