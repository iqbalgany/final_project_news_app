import 'package:final_project_news_app/blocs/news/news_state.dart';
import 'package:final_project_news_app/data/remote_data/news_remote_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRemoteData newsRemoteData;

  NewsCubit(this.newsRemoteData) : super(const NewsState());

  Future<void> loadNews() async {
    emit(state.copyWith(loading: true, errorMessage: null));

    try {
      final response = await newsRemoteData.getNews();

      emit(state.copyWith(news: response, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }
}
