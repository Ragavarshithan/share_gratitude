import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_gratitude/model/post_model.dart';
import '../providers/post_provider.dart';
import '../widgets/post_form.dart';

class EditPostScreen extends ConsumerWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: PostForm(
        initialTitle: post.title,
        initialBody: post.body,
        onSubmit: (title, body) async {
          final updatedPost = Post(
            id: post.id,
            title: title,
            body: body,
            userId: post.userId,
          );

          try {
            await ref.read(updatePostProvider(updatedPost).future);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post updated successfully')),
              );
              Navigator.pop(context);
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to update post: ${e.toString()}'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
