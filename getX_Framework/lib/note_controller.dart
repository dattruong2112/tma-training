import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_framework/note.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() {
    final box = GetStorage();
    if (box.hasData('notes')) {
      List storedNotes = box.read('notes');
      notes.assignAll(storedNotes.map((notes) => Note.fromMap(notes)).toList());
    }
  }

  void addNote(String title, String description) {
    int id = notes.isNotEmpty ? notes.last.id + 1 : 1;
    notes.add(Note(id: id, title: title, description: description));
    saveNotes();
  }
  void editNote(int index, String newTitle, String newDescription) {
    notes[index].title = newTitle;
    notes[index].description = newDescription;
    saveNotes();
  }
  void deleteNote(int index) {
    notes.removeAt(index);
    saveNotes();
  }
  void saveNotes() {
    final box = GetStorage();
    box.write('notes', notes.map((note) => note.toMap()).toList());
  }
}
