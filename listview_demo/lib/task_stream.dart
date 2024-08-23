import 'dart:async';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final Stream<List<Task>> taskStream;
  const AddTask({super.key, required this.taskStream});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final StreamController<List<Task>> _streamController =
      StreamController<List<Task>>.broadcast();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {},
            child: const Text('Save'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
        )
      ],
    );
  }
}

class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}
