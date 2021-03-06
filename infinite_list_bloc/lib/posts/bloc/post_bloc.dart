import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list_bloc/posts/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'dart:async';
import 'dart:convert';

part 'post_event.dart';
part 'post_state.dart';

const throtalDuration = Duration(milliseconds: 100);
const _postLimit = 20;

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostEvent>((event, emit) {
      on<PostFetched>(_onPostFetched);
    });
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emitter) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();

        return emit(
          state.copyWith(
              status: PostStatus.success, posts: posts, hasReachedMax: false),
        );
      }

      final posts = await _fetchPosts(state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  final http.Client httpClient;

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          title: json['title'] as String,
          body: json['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
