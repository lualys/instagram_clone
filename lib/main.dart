import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const InstagramClone()),
  );
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: const InstagramHome(),
    );
  }
}

class InstagramHome extends StatelessWidget {
  const InstagramHome({super.key});

  final List<Map<String, String>> posts = const [
    {
      "user": "Billie Eilish",
      "subtitle": "AgroPlay, Ana Castela • Nosso Quadro",
      "avatar": "assets/story.jpg",
      "image": "assets/post1.jpg",
    },
    {
      "user": "Billie",
      "subtitle": "Zé Neto & Cristiano • Largado às Traças",
      "avatar": "assets/post5.jpg",
      "image": "assets/post1.jpg",
    },
    {
      "user": "Marilia",
      "subtitle": "Marília Mendonça • Infiel",
      "avatar": "assets/post4.jpg",
      "image": "assets/post4.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.send, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      // Stories + Feed
      body: Column(
        children: [
          // 🔹 Stories com "Seu story" no primeiro item
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length + 1, // +1 para o "Seu story"
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Primeiro story: Seu Story
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                "assets/post4.jpg",
                              ), // foto do usuário
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text("Seu story", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                } else {
                  final story = posts[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage(story["avatar"]!),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          story["user"]!,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),

          const Divider(height: 1),

          // 🔹 Feed
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(post["avatar"]!),
                      ),
                      title: Text(
                        post["user"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(post["subtitle"]!),
                      trailing: const Icon(Icons.more_vert),
                    ),
                    Image.asset(post["image"]!, fit: BoxFit.cover),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite_border),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.comment_outlined),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.send),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.bookmark_border),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
