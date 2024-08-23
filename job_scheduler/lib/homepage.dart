import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputController = TextEditingController();
  late String resultText = '';
  var channel = const MethodChannel('job_scheduler');

  Future<void> callNativeCode(String meetingName) async {
    try {
      resultText = await channel.invokeMethod('meetingName', {'meetingName': meetingName});
      setState(() {});
    } catch (_) {
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Scheduler'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Set up your meeting here',
                ),
              ),
            ),
            const SizedBox(height: 15,),
            MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              onPressed: () {
                String meetingName = inputController.text;

                if (meetingName.isEmpty) {
                  meetingName = 'There is no meeting added';
                } else {
                  callNativeCode('$meetingName is set up');
                  inputController.clear();
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              resultText,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
