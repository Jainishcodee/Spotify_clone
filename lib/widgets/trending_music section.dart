import 'package:flutter/material.dart';
import '../audio.dart';
import '../data.dart';

class TrendingMusic extends StatelessWidget {
  const TrendingMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 15),
          child: Text(
            "Trending this Week",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TrendingMusicFullScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top trending songs collage
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 180,
                    width: 180,
                    color: Colors.grey[900],
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: Data().trendingSongs.take(4).map((song) {
                        return Image.asset(
                          song['image']!,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Top 10 Trending",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "This Week's Hottest Tracks",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Full screen view for trending songs
class TrendingMusicFullScreen extends StatelessWidget {
  const TrendingMusicFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Top 10 Trending',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Create a grid of top 4 song images as header background
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: Data().trendingSongs.take(4).map((song) {
                      return Image.asset(
                        song['image']!,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(18, 18, 18, 0.5),
                          Color.fromRGBO(18, 18, 18, 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final song = Data().trendingSongs[index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color:
                                  index < 3 ? Colors.green : Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            song['image']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      song['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${song['artist']} • ${song['weeklyPlays']} plays',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          song['duration']!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioPlayerPro(
                            audioURL: song['audio']!,
                            image: song['image']!,
                            name: song['name']!,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: Data().trendingSongs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
