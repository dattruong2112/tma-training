import 'package:flutter/material.dart';
import 'package:listview_demo/homepage.dart';
import 'package:listview_demo/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks App',
      theme: defaultTheme,
      home: const MyHomePage(),
    );
  }
}
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
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   String _savedName = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadName();
//   }
//
//   _loadName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedName = prefs.getString('username') ?? '';
//     });
//   }
//
//   _saveName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('username', _controller.text);
//     setState(() {
//       _savedName = _controller.text;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SharedPreferences Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               decoration: const InputDecoration(labelText: 'Enter your name'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveName,
//               child: const Text('Save Name'),
//             ),
//             const SizedBox(height: 20),
//             Text('Saved Name: $_savedName'),
//           ],
//         ),
//       ),
//     );
//   }
// }






