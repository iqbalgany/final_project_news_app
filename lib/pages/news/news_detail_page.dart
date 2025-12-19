import 'package:final_project_news_app/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel news;
  const NewsDetailPage({super.key, required this.news});

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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            child: Image.network(
              widget.news.urlToImage ??
                  'https://ichef.bbci.co.uk/news/1024/cpsprodpb/14A8C/production/_92802648_thinkstockphotos-609795616.jpg',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    'https://ichef.bbci.co.uk/news/1024/cpsprodpb/14A8C/production/_92802648_thinkstockphotos-609795616.jpg',
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  widget.news.title ?? 'No Title',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://ichef.bbci.co.uk/news/1024/cpsprodpb/14A8C/production/_92802648_thinkstockphotos-609795616.jpg',
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 10),

                      ///
                      Text(
                        widget.news.author ?? 'No Author',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      // Spacer(),
                      Text(
                        widget.news.publishedAt != null
                            ? DateFormat(
                                'dd MMM yyyy',
                              ).format(widget.news.publishedAt!)
                            : '-',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      widget.news.content ?? lorem(paragraphs: 5, words: 1000),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      lorem(paragraphs: 5, words: 1000),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
