part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const [],
      this.hasReachedMax = false});

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  PostState copyWith(
      {PostStatus? status, List<Post>? posts, bool? hasReachedMax}) {
    return PostState(
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        posts: posts ?? this.posts);
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
