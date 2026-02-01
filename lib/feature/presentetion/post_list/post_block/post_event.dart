part of 'post_bloc.dart';

// @immutable
// sealed class PostEvent {}


@immutable
sealed class PostEvent {}

/// Initial fetch
class FetchPostsEvent extends PostEvent {}

/// Pagination - load more posts
class LoadMorePostsEvent extends PostEvent {}

/// Pull-to-refresh event
class RefreshPostsEvent extends PostEvent {}

/// Search with debounce
class SearchPostsEvent extends PostEvent {
  final String query;
  SearchPostsEvent(this.query);
}



