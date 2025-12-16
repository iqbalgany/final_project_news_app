import 'package:final_project_news_app/pages/news/news_detail_page.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /// Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 20, 30, 20),
            child: Row(
              children: [
                ///
                Container(
                  width: 70,
                  height: 70,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back 👋',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Thomas Shelby',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          /// Latest News Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Latest News',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          /// News List
          ListView.separated(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsDetailPage()),
                ),
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    height: 150,
                    child: Row(
                      children: [
                        /// News Image
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10),
                          ),
                          child: Image.network(
                            'https://tse3.mm.bing.net/th/id/OIP.IvQ6zp4yhQsC3MFzlkrhTgHaHa?w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /// News Title
                              Text(
                                'Monarch population soars 4,900 percent since last year in thrilling 2021 western migration',
                                maxLines: 3,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              /// Author Name
                              Text(
                                'By Jane Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Date
                                  Text(
                                    'Jan 15, 2022',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),

                                  /// Source
                                  Text(
                                    'CNBC',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
