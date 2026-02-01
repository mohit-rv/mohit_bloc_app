part of 'post_bloc.dart';

// @immutable
// sealed class PostState {}
//
// final class PostInitial extends PostState {}


@immutable
sealed class PostState {}

/// Initial empty state
class PostInitial extends PostState {}

/// Loading the first page
class PostLoading extends PostState {}

/// Main success state (pagination + search + refresh)
class PostLoaded extends PostState {
  final List<PostModel> posts;
  final int page;
  final bool hasMore;

  PostLoaded({
    required this.posts,
    required this.page,
    required this.hasMore,
  });
}

/// Error state
class PostError extends PostState {
  final String message;
  PostError(this.message);
}

/// Loading state while fetching next page (bottom loader)
class PostPaginationLoading extends PostState {
  final List<PostModel> oldPosts;
  PostPaginationLoading(this.oldPosts);
}

/// No more pages left (pagination end)
class PostNoMoreData extends PostState {}