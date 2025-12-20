import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
import 'package:final_project_news_app/blocs/news/news_cubit.dart';
import 'package:final_project_news_app/blocs/news/news_state.dart';
import 'package:final_project_news_app/consts/colors.dart';
import 'package:final_project_news_app/pages/news/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.news == null || state.news!.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          return ListView(
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
                        color: blueColor,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(width: 10),

                    /// User Info
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
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is! AuthSuccess) {
                              return Text('User');
                            }
                            return Text(
                              state.user.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          },
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
                  'News For You',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: blueColor,
                  ),
                ),
              ),

              /// News List
              ListView.separated(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: state.news!.length,
                itemBuilder: (context, index) {
                  final article = state.news![index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailPage(news: state.news![index]),
                      ),
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
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10),
                              ),
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.network(
                                  article.urlToImage ??
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
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// News Title
                                  Text(
                                    article.title ?? 'No Title',
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  /// Author Name
                                  Text(
                                    article.author ?? 'No Author',
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
                                        article.publishedAt != null
                                            ? DateFormat(
                                                'dd MMM yyyy',
                                              ).format(article.publishedAt!)
                                            : '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),

                                      /// Source
                                      Text(
                                        article.source.name ?? '-',
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
          );
        },
      ),
    );
  }
}
