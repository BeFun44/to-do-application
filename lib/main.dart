// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ToDo App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//       routes: {
//         '/home': (context) => HomePage(),
//       },
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     navigateToHome();
//   }
//
//   void navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 3));
//     Navigator.pushReplacementNamed(context, '/home');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Color(0xFFab47bc),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_box,
//               color: Colors.white,
//               size: 100,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'ToDo App',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<String> todos = [];
//   List<String> filteredTodos = [];
//   String filter = 'All';
//   TextEditingController _todoController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     loadTodos();
//   }
//
//   void loadTodos() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     todos = prefs.getStringList('todos') ?? [];
//     filterTodos();
//   }
//
//   void saveTodos() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('todos', todos);
//   }
//
//   void addTodo() {
//     setState(() {
//       String todo = _todoController.text;
//       if (todo.isNotEmpty) {
//         todos.add(todo);
//         _todoController.clear();
//         saveTodos();
//         filterTodos();
//       }
//     });
//   }
//
//   void removeTodoAtIndex(int index) {
//     setState(() {
//       todos.removeAt(index);
//       saveTodos();
//       filterTodos();
//     });
//   }
//
//   void filterTodos() {
//     setState(() {
//       switch (filter) {
//         case 'Done':
//           filteredTodos = todos.where((todo) => todo.endsWith(' (Done)')).toList();
//           break;
//         case 'Undone':
//           filteredTodos = todos.where((todo) => !todo.endsWith(' (Done)')).toList();
//           break;
//         case 'Progress':
//           filteredTodos = todos.where((todo) => todo.endsWith(' (In Progress)')).toList();
//           break;
//         case 'Cancel':
//           filteredTodos = todos.where((todo) => todo.endsWith(' (Canceled)')).toList();
//           break;
//         default:
//           filteredTodos = todos;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ToDo App'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _todoController,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a task',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: addTodo,
//                   child: Text('Add'),
//                 ),
//               ],
//             ),
//           ),
//           DropdownButton<String>(
//             value: filter,
//             items: <String>[
//               'All',
//               'Done',
//               'Undone',
//               'Progress',
//               'Cancel',
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 filter = newValue!;
//                 filterTodos();
//               });
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredTodos.length,
//               itemBuilder: (context, index) {
//                 String todo = filteredTodos[index];
//                 return Dismissible(
//                   key: Key(todo),
//                   onDismissed: (direction) {
//                     removeTodoAtIndex(index);
//                   },
//                   child: ListTile(
//                     title: Text(todo),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'todo_list_screen.dart';
import 'splash_screen.dart';
// primary color - #ab47bc
// accent/secondary  color - #ba68c8
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => ToDoListScreen(),
      },
    );
  }
}
