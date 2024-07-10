import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Article.dart';
import '../../services/HomePageServices.dart';

part 'news_alerrt_state.dart';

class NewsAlertCubit extends Cubit<NewsAlertState> {
  NewsAlertCubit() : super(NewsAlertInitial());

  void getNews() async {
    emit(NewsAlertLoading());
    try {
      final res = await HomePageService().getTopRatedMovies();
      if (res.statusCode == 200) {
        final List<Article> articles =
            HomePageService().parseArticles(res.body);
        emit(NewsAlertLoaded(articles));
      } else {
        emit(NewsAlertError('Failed to load news'));
      }
    } catch (e) {
      emit(NewsAlertError('Failed to load news ->  error is : $e'));
    }
  }
}
