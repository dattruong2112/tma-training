import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Form')),
        body: const StudentForm(),
      ),
    );
  }
}

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Student> students = [];
  late TextEditingController fullNameCtr;
  final TextEditingController genderCtr = TextEditingController();
  final TextEditingController studentIdCtr = TextEditingController();

  void updateData(Student student) {
    fullNameCtr.text = student.fullname;
    genderCtr.text = student.gender;
    studentIdCtr.text = student.studentId;
  }

  void addData(Student student) {
    students.add(student);
    formKey.currentState!.reset();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: fullNameCtr,
            decoration: const InputDecoration(
              hintText: 'Enter your fullname',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: genderCtr,
            decoration: const InputDecoration(
              hintText: 'Enter your gender',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: studentIdCtr,
            decoration: const InputDecoration(
              hintText: 'Enter your Student ID',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  String fullName = fullNameCtr.text;
                  final gender = genderCtr.text;
                  final studentId = studentIdCtr.text;
                  final student = Student(fullName, gender, studentId);
                  if (students.isNotEmpty) {
                    for (int i = 0 ; i < students.length ; i++) {
                      if (students[i].studentId == student.studentId) {
                        students[i] = student;
                        updateData(student);
                      } else {
                        addData(student);
                      }
                    }
                  } else {
                    addData(student);
                  }
                  setState(() {
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Fullname: ${students[index].fullname}'),
                  subtitle: Text('Gender: ${students[index].gender}, Student ID: ${students[index].studentId}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final student = students[index];
                            updateData(student);
                          });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            students.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Student {
  final String fullname;
  final String gender;
  final String studentId;

  Student(this.fullname, this.gender, this.studentId);
}