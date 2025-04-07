import 'package:flutter/material.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contents'),
        backgroundColor: const Color(0xFF3B5F41),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ContentItem(
            title: 'How Should I Put Out My Recycling?',
            subtitle: 'Learn how to set up a system that works for you.',
          ),
          ContentItem(
            title: 'What Happens To Used Garbage Bags?',
            subtitle: 'Trash bags get recycled once your garbage is collected.',
          ),
          ContentItem(
            title: '5 Tips for Reducing Plastic Waste',
            subtitle: 'Simple daily steps to minimize plastic usage.',
          ),
        ],
      ),
    );
  }
}

class ContentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const ContentItem({
    Key? key, 
    required this.title, 
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.article),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
        },
      ),
    );
  }
}
