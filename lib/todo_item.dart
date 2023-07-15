import 'package:flutter/material.dart';
import 'todo.dart';
//
// class ToDoItem extends StatelessWidget {
//   final ToDo todo;
//   final int index;
//   final Function(int) onToggle;
//   final Function(int) onDelete;
//
//   ToDoItem({
//     required this.todo,
//     required this.index,
//     required this.onToggle,
//     required this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Checkbox(
//         value: todo.isDone,
//         onChanged: (_) => onToggle(index),
//       ),
//       title: Text(todo.text),
//       trailing: IconButton(
//         icon: Icon(Icons.delete),
//         onPressed: () => onDelete(index),
//       ),
//     );
//   }
// }

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final int index;
  final Function(int) onToggle;
  final Function(int) onDelete;
  final Function(int) onEdit;

  ToDoItem({
    required this.todo,
    required this.index,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.lightGreen,
        value: todo.isDone,
        onChanged: (_) => onToggle(index),
      ),
      title: Text(todo.text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.yellowAccent,),
            onPressed: () => onEdit(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red,),
            onPressed: () => onDelete(index),
          ),
        ],
      ),
    );
  }
}
