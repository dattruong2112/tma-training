import 'package:flutter/material.dart';
import 'package:sqlite_database/database/database.dart';
import 'package:sqlite_database/models/book.dart';

import 'dart:async';

class BookSearch extends StatefulWidget {
  @override
  _BookSearchState createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  Timer? _debounce;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books by Category'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Enter category',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) async {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () async {
                  List<Book> books = await DatabaseHelper.instance.getAllBooksByCategory(query);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultPage(books: books),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


class SearchResultPage extends StatelessWidget {
  final List<Book> books;

  const SearchResultPage({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: books.isEmpty
          ? const Center(child: Text('No books found for this category'))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Book book = books[index];
                return ListTile(
                  title: Text(book.title, style: TextStyle(fontSize: 20),),
                  subtitle: Text(book.description, style: TextStyle(fontSize: 16),),
                );
              },
            ),
    );
  }
}
