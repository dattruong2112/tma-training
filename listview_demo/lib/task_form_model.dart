import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTaskForm extends StatefulWidget {
  const MyTaskForm({super.key});

  @override
  State<MyTaskForm> createState() => _MyTaskFormState();
}

class _MyTaskFormState extends State<MyTaskForm> {
  // final List<Task> _taskList = [];
  // final ScrollController _scrollController = ScrollController();
  // int _currentMax = 10;
  // bool _isLoading = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadInitialTasks();
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels ==
  //         _scrollController.position.maxScrollExtent) {
  //       _loadMoreTasks();
  //     }
  //   });
  // }
  //
  // void _loadInitialTasks() {
  //   for (int i = 1; i <= _currentMax; i++) {
  //     _taskList.add(Task(title: 'Task $i', description: 'Description $i'));
  //   }
  //   setState(() {});
  // }
  //
  // void _loadMoreTasks() async {
  //   if (!_isLoading) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     for (int i = _currentMax + 1; i <= _currentMax + 5; i++) {
  //       _taskList.add(Task(title: 'Task $i', description: 'Description $i'));
  //     }
  //
  //     setState(() {
  //       _currentMax += 5;
  //       _isLoading = false;
  //     });
  //   }
  // }
  SharedPreferences? _prefs;
  String _favoriteFood = '';

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // _setPrefs();
    _getPrefs();
    // _removePrefs();
  }

  void _setPrefs() {
    _prefs?.setString('favoriteFood', 'Mac&Cheese');
  }

  void _getPrefs() {
    setState(() {
      _favoriteFood = _prefs?.getString('favoriteFood') ?? 'null';
    });
  }

  void _removePrefs() {
    _prefs?.remove('favoriteFood');
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Center(child: Text('Task list')),
          ),
      body: Center(
        // child: ListView.builder(
        //   controller: _scrollController,
        //   itemCount:
        //       _taskList.length + 1,
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index == _taskList.length) {
        //       return _isLoading
        //           ? const Padding(
        //               padding: EdgeInsets.all(8.0),
        //               child: Center(child: CircularProgressIndicator()),
        //             )
        //           : Container();
        //     }
        //     return Container(
        //       padding: const EdgeInsets.all(8.0),
        //       decoration: const BoxDecoration(
        //         color: Colors.black12,
        //         border: Border(bottom: BorderSide()),
        //       ),
        //       child: ListTile(
        //         title: Text(_taskList[index].title),
        //         subtitle: Text(_taskList[index].description),
        //       ),
        //     );
        //   },
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello World',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(_favoriteFood, style: const TextStyle(fontSize: 24.0),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

// class Task {
//   String title;
//   String description;
//
//   Task({required this.title, required this.description});
// }
}
