import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:math';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const InstagramClone(),
    ),
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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          StoriesWidget(posts: posts),
          const Divider(height: 1),
          Expanded(child: FeedWidget(posts: posts)),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}

class AnimatedStoryBorder extends StatefulWidget {
  final String imagePath;
  final double size;
  final bool isMyStory;
  const AnimatedStoryBorder({
    super.key,
    required this.imagePath,
    this.size = 64,
    this.isMyStory = false,
  });

  @override
  State<AnimatedStoryBorder> createState() => _AnimatedStoryBorderState();
}

class _AnimatedStoryBorderState extends State<AnimatedStoryBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: widget.isMyStory
                    ? [Colors.blue, Colors.green, Colors.blue]
                    : [Colors.red, Colors.orange, Colors.purple, Colors.red],
                startAngle: 0,
                endAngle: 2 * pi,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: widget.size / 2 - 3,
                backgroundImage: AssetImage(widget.imagePath),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StoriesWidget extends StatelessWidget {
  final List<Map<String, String>> posts;
  const StoriesWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildMyStory();
          final story = posts[index - 1];
          return _buildStory(story);
        },
      ),
    );
  }

  Widget _buildMyStory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedStoryBorder(
                imagePath: "assets/post4.jpg",
                isMyStory: true,
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
                  child: const Icon(Icons.add, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("Seu story", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStory(Map<String, String> story) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          AnimatedStoryBorder(imagePath: story["avatar"]!),
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
}

class FeedWidget extends StatelessWidget {
  final List<Map<String, String>> posts;
  const FeedWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(post: post);
      },
    );
  }
}

class PostCard extends StatelessWidget {
  final Map<String, String> post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
  }
}
