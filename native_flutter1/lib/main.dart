import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.native_flutter1');
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Job Scheduler'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              startJobScheduler();
            },
            child: const Text('Start Job Scheduler'),
          ),
        ),
      ),
    );
  }

  Future<void> startJobScheduler() async {
    try {
      await platform.invokeMethod('startJobScheduler');
    } on PlatformException catch (e) {
      print("Failed to start job scheduler: '${e.message}'.");
    }
  }
}
