import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/networking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<Post> getPost() async {
  final _response = await NetworkHelper().getPost(id: 1);
  return Post.fromJSON(_response);
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Post>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data!.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      snapshot.data!.body,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
