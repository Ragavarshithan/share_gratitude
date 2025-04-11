import 'package:riverpod/riverpod.dart';
import 'package:share_gratitude/model/post_model.dart';
import 'package:share_gratitude/services/api_service.dart';

final postServiceProvider = Provider((ref) => ApiService());

final postProvider = FutureProvider<List<Post>>((ref) async {
  return ref.read(postServiceProvider).getPost();
});

final createPostProvider = FutureProvider.family<Post, Post>((ref, post) async {
  final newPost = await ref.read(postServiceProvider).createPost(post);
  ref.invalidate(postProvider);
  return newPost;
});

final updatePostProvider = FutureProvider.family<Post, Post>((ref, id) async {
  final updatedPost = await ref.read(postServiceProvider).updatePost(id);
  ref.invalidate(postProvider);
  return updatedPost;
});

final deletePostProvider = FutureProvider.family<void, int>((ref, id) async {
  await ref.read(postServiceProvider).deletePost(id);
  ref.invalidate(postProvider);
});
