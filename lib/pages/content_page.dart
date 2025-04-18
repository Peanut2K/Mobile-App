import 'package:flutter/material.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contents = [
  {
    'title': 'How Should I Put Out My Recycling?',
    'subtitle': 'Learn how to set up a system that works for you.',
    'icon': Icons.recycling,
    'content': '''
Setting up your recycling system is easier than you think!
🔹 **Step 1: Understand what’s recyclable**
Check your local municipality’s recycling guidelines. Generally recyclable items include:
- Paper and cardboard (clean, dry)
- Plastic bottles and containers (#1 and #2 plastics)
- Glass bottles and jars
- Metal cans

🔹 **Step 2: Set up bins at home**
Label separate bins for different types of recyclables. Place them in the kitchen, bathroom, and near your work desk.

🔹 **Step 3: Rinse and clean**
Rinse food and drink containers to avoid contamination. Contaminated items can cause a whole batch to be rejected.

🔹 **Step 4: Remove caps and labels**
Some recycling centers require bottle caps or labels to be removed.

🔹 **Step 5: Consistency is key**
Get your family or housemates on board and maintain the system every week.

🌿 Remember: small changes at home create big environmental impact!
''',
  },
  {
    'title': 'What Happens To Used Garbage Bags?',
    'subtitle': 'Trash bags get recycled once your garbage is collected.',
    'icon': Icons.delete_outline,
    'content': '''
Used garbage bags often go to landfill, but there's more to the story.

🗑️ **What typically happens:**
- Trash collectors transport bags to a facility.
- If bags are non-recyclable plastic, they go to landfill or incineration.
- Some cities have plastic film recycling, where certain bags are separated.

♻️ **Recyclable garbage bags?**
- Many garbage bags are made from LDPE or HDPE which can be recycled.
- Check if your local facility accepts plastic film.

🌍 **Alternatives to plastic garbage bags:**
- **Compostable bags**: Great for food waste if your city has composting.
- **Reusable garbage liners**: Washable options for dry trash.
- **Paper bags**: For light, dry waste.

💡 Tip: The less you throw away, the fewer bags you need!
''',
  },
  {
    'title': '5 Tips for Reducing Plastic Waste',
    'subtitle': 'Simple daily steps to minimize plastic usage.',
    'icon': Icons.lightbulb_outline,
    'content': '''
We all use plastic, but we can reduce it easily in daily life.

✅ **Tip 1: Carry a reusable water bottle**
Avoid buying plastic water bottles. Stainless steel or BPA-free bottles last years.

✅ **Tip 2: Say no to single-use plastics**
This includes straws, plastic cutlery, and shopping bags. Carry your own or ask for alternatives.

✅ **Tip 3: Buy in bulk**
Buying large packages reduces plastic packaging compared to multiple small ones.

✅ **Tip 4: Choose products in paper, glass, or metal**
Glass jars and tin cans are easier to recycle than plastic wrappers.

✅ **Tip 5: Support zero-waste shops**
Bring your own containers and bags. Many stores now support refillable items.

🎯 **Bonus**: Track your plastic usage each week to build awareness. 

Together, small actions make a big difference!
''',
  },
];


    return Scaffold(
      backgroundColor: Color(0xFF3B5F41),
      appBar: AppBar(
        title: const Text('Contents',
        style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize : 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF2D9BB)),
        backgroundColor: const Color(0xFF3B5F41),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final item = contents[index];
          return ContentCard(
            title: item['title'] as String,
            subtitle: item['subtitle'] as String,
            icon: item['icon'] as IconData,
            content: item['content'] as String,
          );
        },
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String content;

  const ContentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: title,
                content: content,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: Colors.green.shade800),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
        style: TextStyle(
            color: Color(0xFFF2D9BB),
            fontSize : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF2D9BB)),
        backgroundColor: const Color(0xFF3B5F41),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, height: 1.6,fontWeight: FontWeight.bold,),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 131, 161, 136),
    );
  }
}