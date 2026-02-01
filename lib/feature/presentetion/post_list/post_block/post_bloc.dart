import 'package:bloc/bloc.dart';
import 'package:bloclearnbyproject/core/utils/debounce.dart';
import 'package:bloclearnbyproject/feature/data/model/post_list_model/post_model.dart';
import 'package:bloclearnbyproject/feature/data/repositories/post_repositories.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc() : super(PostInitial()) {
//     on<PostEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  int page = 1;
  bool isLoadingMore = false;
  List<PostModel> allPosts = [];

  PostBloc(this.repository) : super(PostInitial()) {
    // 🔹 1. Initial fetch
    on<FetchPostsEvent>(_fetchPosts);

    // 🔹 2. Pagination
    on<LoadMorePostsEvent>(_loadMorePosts);

    // 🔹 3. Search (debounce)
    on<SearchPostsEvent>(
      _searchPosts,
      transformer: debounce(Duration(milliseconds: 400)),
    );

    // 🔹 4. Pull-to-refresh
    on<RefreshPostsEvent>(_refreshPosts);
  }

  // ------------------------------------------------
  // 🔽 FETCH FIRST PAGE
  // ------------------------------------------------
  Future<void> _fetchPosts(
      FetchPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(PostLoading());

    try {
      page = 1;

      final posts = await repository.getPosts(page: page);

      allPosts = posts;

      emit(PostLoaded(
        posts: allPosts,
        page: page,
        hasMore: posts.isNotEmpty,
      ));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  // ------------------------------------------------
  // 🔽 LOAD MORE POSTS (Pagination)
  // ------------------------------------------------
  Future<void> _loadMorePosts(
      LoadMorePostsEvent event,
      Emitter<PostState> emit,
      ) async {
    if (isLoadingMore) return;

    final currentState = state;
    if (currentState is! PostLoaded) return;
    if (!currentState.hasMore) return;

    isLoadingMore = true;
    page++;

    emit(PostPaginationLoading(allPosts));

    try {
      final posts = await repository.getPosts(page: page);

      if (posts.isEmpty) {
        emit(PostNoMoreData());
      } else {
        allPosts.addAll(posts);

        emit(PostLoaded(
          posts: allPosts,
          page: page,
          hasMore: posts.isNotEmpty,
        ));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }

    isLoadingMore = false;
  }

  // ------------------------------------------------
  // 🔽 SEARCH (Debounce + Cancel Previous Request)
  // ------------------------------------------------
  Future<void> _searchPosts(
      SearchPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      add(FetchPostsEvent()); // blank search → reload normal list
      return;
    }

    emit(PostLoading());

    try {
      final results = await repository.searchPosts(query);

      emit(PostLoaded(
        posts: results,
        page: 1,
        hasMore: false, // search results me pagination nahi
      ));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  // ------------------------------------------------
  // 🔽 REFRESH LIST (Pull-To-Refresh)
  // ------------------------------------------------
  Future<void> _refreshPosts(
      RefreshPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    page = 1;

    emit(PostLoading());

    try {
      final posts = await repository.getPosts(page: page);

      allPosts = posts;

      emit(PostLoaded(
        posts: allPosts,
        page: 1,
        hasMore: posts.isNotEmpty,
      ));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}






