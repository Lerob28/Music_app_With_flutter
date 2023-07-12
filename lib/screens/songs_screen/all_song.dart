import 'package:flutter/material.dart';

class AllSongScreen extends StatefulWidget {
  const AllSongScreen({Key? key}) : super(key: key);

  @override
  State<AllSongScreen> createState() => _AllSongScreenState();
}

class _AllSongScreenState extends State<AllSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Inch player 2.0.0')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return  ListTile(
            leading: const Icon(Icons.music_note),
            title: Text('Music N° $index'),
            subtitle: const Text('Artist Name && Duration'),
            trailing: const Icon(Icons.more_horiz),
          );
        },
      ),
    );
  }
}
