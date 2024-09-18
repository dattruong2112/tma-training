class Note {
  late int id;
  late String title;
  late String description;

  Note({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], title: map['title'], description: map['description']);
  }
}