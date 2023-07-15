import 'dart:convert';

class ToDo {
  String text;
  bool isDone;

  ToDo({
    required this.text,
    this.isDone = false,
  });

  void toggleStatus() {
    isDone = !isDone;
  }

  String toMapString() {
    return '{"text":"$text","isDone":$isDone}';
  }

  factory ToDo.fromMapString(String mapString) {
    Map<String, dynamic> map = Map<String, dynamic>.from(json.decode(mapString));
    return ToDo(
      text: map['text'],
      isDone: map['isDone'],
    );
  }
}
