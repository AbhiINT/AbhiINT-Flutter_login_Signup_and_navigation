import 'package:flutter/material.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> songs = [
      {'name': 'Sanam re', 'singer': 'Arijit'},
      {'name': 'Aminal', 'singer': 'Script'},
      {'name': 'In The End', 'singer': 'Linkin Park'},
      {'name': 'Bekar Dil', 'singer': 'Vishal Mishra'},
      {'name': 'Har Har Mahadev', 'singer': 'Sachet-Parampara'},
      {'name': 'Venom', 'singer': 'Eminem'},
      {'name': 'Rap God', 'singer': 'Eminem'},
      {'name': 'Phele Bhi me', 'singer': 'Vishal Mishra'},
      {'name': 'Labon Ko', 'singer': 'KK'},
      {'name': 'Veham', 'singer': 'Arman Malik'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(songs[index]['name'] ?? ''),
                subtitle: Text('By ${songs[index]['singer'] ?? ''}'),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
