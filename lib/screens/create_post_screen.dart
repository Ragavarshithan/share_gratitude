import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_gratitude/model/post_model.dart';
import '../providers/post_provider.dart';
import '../widgets/post_form.dart';

class CreatePostScreen extends ConsumerWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: PostForm(
        onSubmit: (title, body) async {
          final post = Post(title: title, body: body, userId: 1);

          try {
            await ref.read(createPostProvider(post).future);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post created successfully')),
              );
              Navigator.pop(context);
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to create post: ${e.toString()}'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
