import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_database/database/database.dart';
import 'package:sqlite_database/models/book.dart';

class MyBookForm extends StatefulWidget {
  const MyBookForm({super.key});

  @override
  State<MyBookForm> createState() => _MyBookFormState();
}

class _MyBookFormState extends State<MyBookForm> {
  List<Book> bookList = [];
  List<Book> searchList = [];
  bool isLoading = true;
  bool isSearching = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchBook();
  }

  void _fetchBook({String? query}) async {
    setState(() {
      isLoading = true;
    });

    List<Book> lists;
    if (query != null && query.isNotEmpty) {
      isSearching = true;
      lists = await DatabaseHelper.instance.getAllBooksByCategory(query);
    } else {
      isSearching = false;
      lists = await DatabaseHelper.instance.getBooks();
    }

    setState(() {
      if (isSearching) {
        searchList = lists;
      } else {
        bookList = lists;
      }
      isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchBook(query: query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Books by Category',
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: _onSearchChanged,
              ),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.trash_fill, color: Colors.red),
              onPressed: () {
                searchController.clear();
                _fetchBook();
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: isSearching ? searchList.length : bookList.length,
              itemBuilder: (context, index) {
                Book book = isSearching ? searchList[index] : bookList[index];
                return ListTile(
                  title: Text(book.title, style: const TextStyle(fontSize: 20)),
                  subtitle: Text(book.description,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.deepPurple)),
                  trailing: Text(book.category,
                      style: const TextStyle(fontSize: 18, color: Colors.blue)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        tooltip: 'Add Book',
        child: const Icon(CupertinoIcons.add_circled, size: 25),
      ),
    );
  }

  void _addBook() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String description = descriptionController.text;
                String category = categoryController.text;

                Book newBook = Book(
                  title: title,
                  description: description,
                  category: category,
                );
                await DatabaseHelper.instance.insertCategory(category);
                await DatabaseHelper.instance.insertBook(newBook);
                titleController.clear();
                descriptionController.clear();
                categoryController.clear();
                _fetchBook();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
