// import 'dart:convert';
//
// import 'package:api/model/post.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import 'package:api/network/network_request.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'HTTP request',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         primaryColor: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class ListViewPage extends StatefulWidget {
//   const ListViewPage({super.key});
//
//   @override
//   State<ListViewPage> createState() => _ListViewPageState();
// }
//
// class _ListViewPageState extends State<ListViewPage> {
//   List<Post> postData = <Post>[];
//
//   @override
//   void initState() {
//     super.initState();
//     NetworkRequest.fetchPosts().then((data) {
//       setState(() {
//         postData = data;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HTTP Request'),
//       ),
//       body: Expanded(
//         child: ListView.builder(
//           padding: const EdgeInsets.all(10.0),
//           itemCount: postData.length,
//           itemBuilder: (context, index) {
//             return Card(
//               color: Colors.grey.shade200,
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${postData[index].id}. ${postData[index].title}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       '${postData[index].body}',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final int postId = 1;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Failed to load posts');
    }
  }

  Future<void> createPost() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      print('Post created: ${response.body}');
    } else {
      print('Failed to create post');
    }
  }

  Future<void> updatePost(int id) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'id': id,
        'title': 'foo updated',
        'body': 'bar updated',
        'userId': 1,
      }),
    );

    if (response.statusCode == 200) {
      print('Post updated: ${response.body}');
    } else {
      print('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    if (response.statusCode == 200) {
      print('Post deleted');
    } else {
      print('Failed to delete post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: buttonTheme.buttonStyle,
                onPressed: fetchPosts,
                child: const Text('GET'),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: buttonTheme.buttonStyle,
                onPressed: createPost,
                child: const Text('POST'),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: buttonTheme.buttonStyle,
                onPressed: () => updatePost(postId),
                child: const Text('PUT'),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: buttonTheme.buttonStyle,
                onPressed: () => deletePost(postId),
                child: const Text('DELETE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class buttonTheme {
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    textStyle: const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    ),
  );
}

