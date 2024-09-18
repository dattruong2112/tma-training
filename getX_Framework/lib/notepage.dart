import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_framework/note.dart';
import 'package:getx_framework/note_controller.dart';
import 'package:getx_framework/textTheme.dart';

class NotePage extends StatelessWidget {
  NotePage({super.key});

  final NoteController noteController = Get.put(NoteController());
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notes', style: ThemeText.title),
                  FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Add new note',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: titleEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter note here',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller: descriptionEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter description here',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (titleEditingController.text.isNotEmpty &&
                                      descriptionEditingController
                                          .text.isNotEmpty) {
                                    noteController.addNote(
                                        titleEditingController.text,
                                        descriptionEditingController.text);
                                    titleEditingController.clear();
                                    descriptionEditingController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  titleEditingController.clear();
                                  descriptionEditingController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      CupertinoIcons.plus_bubble,
                      color: Colors.teal[300],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.white,
                  height: 2,
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: noteController.notes.length,
                    itemBuilder: (context, index) {
                      Note note = noteController.notes[index];
                      return ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: ThemeText.heading,
                        ),
                        title: Text(note.title, style: ThemeText.heading),
                        subtitle: Text(note.description, style: ThemeText.text),
                        trailing: IconButton(
                          icon: const Icon(
                            CupertinoIcons.trash_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Show confirmation dialog before deleting
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Delete Note',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: const Text(
                                    'Are you sure you want to delete this note?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        noteController.deleteNote(index);
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog without deleting
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        onTap: () {
                          // Code for editing the note
                          titleEditingController.text = note.title;
                          descriptionEditingController.text = note.description;

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Edit Note',
                                  style: TextStyle(color: Colors.teal),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: titleEditingController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter new title',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: descriptionEditingController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter new description',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      String newTitle =
                                          titleEditingController.text;
                                      String newDescription =
                                          descriptionEditingController.text;

                                      if (newTitle != note.title ||
                                          newDescription != note.description) {
                                        if (newTitle.isNotEmpty &&
                                            newDescription.isNotEmpty) {
                                          noteController.editNote(
                                            index,
                                            newTitle,
                                            newDescription,
                                          );
                                        }
                                      }
                                      titleEditingController.clear();
                                      descriptionEditingController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      titleEditingController.clear();
                                      descriptionEditingController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
