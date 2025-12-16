import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.chevron_left_rounded, color: Colors.black),
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {
              isSaved = !isSaved;
              setState(() {});
            },
            color: Colors.black,
            icon: isSaved
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_border_outlined),
          ),
          Icon(Icons.bookmark_border_outlined, color: Colors.transparent),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://tse3.mm.bing.net/th/id/OIP.IvQ6zp4yhQsC3MFzlkrhTgHaHa?w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
                ),
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Monarch population soars 4,900 percent since last year in thrilling 2021 western migration',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ///
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://tse3.mm.bing.net/th/id/OIP.IvQ6zp4yhQsC3MFzlkrhTgHaHa?w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    ///
                    Text(
                      'Thomas Shelby',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Jan 15, 2022',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
