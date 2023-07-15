import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';
import 'todo_item.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDo> _todoList = [];
  List<ToDo> _filteredTodoList = [];
  String _filter = 'All';
  double _progress = 0.0;

  TextEditingController _todoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _loadToDoList();
    _calculateProgress();
  }

  // void _loadToDoList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> todoListString = prefs.getStringList('todo_list') ?? [];
  //
  //   setState(() {
  //     _todoList = todoListString.map((e) => ToDo.fromMapString(e)).toList();
  //     _applyFilter();
  //   });
  // }

  void _calculateProgress() {
    if (_todoList.isNotEmpty) {
      int doneCount = _todoList.where((todo) => todo.isDone).length;
      _progress = doneCount / _todoList.length;
    } else {
      _progress = 0.0;
    }
  }

  void _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoListString =
    _todoList.map((e) => e.toMapString()).toList();

    await prefs.setStringList('todo_list', todoListString);
  }

  void _addToDo() {
    String text = _todoTextController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todoList.add(ToDo(text: text));
        _applyFilter();
        _saveToDoList();
        _todoTextController.clear();
      });
    }
    _calculateProgress();
  }

  void _toggleToDoStatus(int index) {
    setState(() {
      _todoList[index].toggleStatus();
      _applyFilter();
      _saveToDoList();
    });
  }

  void _deleteToDo(int index) {
    setState(() {
      _todoList.removeAt(index);
      _applyFilter();
      _saveToDoList();
    });
    _calculateProgress();
  }

  void _applyFilter() {
    setState(() {
      switch (_filter) {
        case 'All':
          _filteredTodoList = _todoList;
          break;
        case 'Done':
          _filteredTodoList = _todoList.where((todo) => todo.isDone).toList();
          break;
        case 'Undone':
          _filteredTodoList = _todoList.where((todo) => !todo.isDone).toList();
          break;
      }
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('To-Do List'),
  //       actions: [
  //         PopupMenuButton<String>(
  //           onSelected: (value) {
  //             setState(() {
  //               _filter = value;
  //               _applyFilter();
  //             });
  //           },
  //           itemBuilder: (BuildContext context) {
  //             return ['All', 'Done', 'Undone'].map((String choice) {
  //               return PopupMenuItem<String>(
  //                 value: choice,
  //                 child: Text(choice),
  //               );
  //             }).toList();
  //           },
  //         ),
  //       ],
  //     ),
  //     body: ListView.builder(
  //       itemCount: _filteredTodoList.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ToDoItem(
  //           todo: _filteredTodoList[index],
  //           index: index,
  //           onToggle: _toggleToDoStatus,
  //           onDelete: _deleteToDo,
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () => _showAddToDoDialog(),
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFab47bc),
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _filter,
                    onChanged: (value) {
                      setState(() {
                        _filter = value!;
                        _applyFilter();
                      });
                    },
                    items: <String>[
                      'All',
                      'Done',
                      'Undone',
                      'Progress',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: value == 'Progress'
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progress'),
                            CircularProgressIndicator(
                              value: _progress,
                            ),
                          ],
                        )
                            : Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTodoList.length,
              itemBuilder: (BuildContext context, int index) {
                return ToDoItem(
                  todo: _filteredTodoList[index],
                  index: index,
                  onToggle: _toggleToDoStatus,
                  onDelete: _deleteToDo,
                  onEdit: _editToDo,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddToDoDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('To-Do List'),
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: DropdownButton<String>(
  //                   value: _filter,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _filter = value!;
  //                       _applyFilter();
  //                     });
  //                   },
  //                   items: <String>['All', 'Done', 'Undone']
  //                       .map<DropdownMenuItem<String>>((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: _filteredTodoList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ToDoItem(
  //                 todo: _filteredTodoList[index],
  //                 index: index,
  //                 onToggle: _toggleToDoStatus,
  //                 onDelete: _deleteToDo,
  //                 onEdit: _editToDo,
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () => _showAddToDoDialog(),
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }

  void _editToDo(int index) {
    TextEditingController editController =
    TextEditingController(text: _filteredTodoList[index].text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ToDo'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'Task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String editedText = editController.text.trim();
                if (editedText.isNotEmpty) {
                  setState(() {
                    _filteredTodoList[index].text = editedText;
                    _saveToDoList();
                    Navigator.pop(context);
                  });
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddToDoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add ToDo'),
          content: TextField(
            controller: _todoTextController,
            decoration: InputDecoration(labelText: 'Task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addToDo();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
