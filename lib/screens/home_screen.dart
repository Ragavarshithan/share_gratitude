import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_gratitude/providers/post_provider.dart';
import 'package:share_gratitude/screens/create_post_screen.dart';
import 'package:share_gratitude/screens/edit_post_screen.dart';
import 'package:share_gratitude/widgets/delete_alert_box.dart';
import 'package:share_gratitude/widgets/loading_indicator.dart';
import 'package:share_gratitude/widgets/post_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<List<Color>> cardGradients = [
      [Color(0xFFFFA726), Color(0xFFFF7043)],
      [Color(0xFFF06292), Color(0xFFBA68C8)],
      [Color(0xFF9575CD), Color(0xFF7986CB)],
    ];

    final postAsync = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(postProvider);
          return ref.read(postProvider.future);
        },
        child: postAsync.when(
          data: (posts) {
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final gradient = cardGradients[index % cardGradients.length];
                return PostCard(
                  post: post,
                  gradient: gradient,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const EditPostScreen(),
                        settings: RouteSettings(arguments: post),
                      ),
                    );
                  },
                  onDelete: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => DeleteAlertBox(gradientColors: gradient),
                    );

                    if (confirmed == true) {
                      try {
                        await ref.read(deletePostProvider(post.id!).future);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Post deleted successfully'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete post: $e')),
                        );
                      }
                    }
                  },
                  index: index,
                );
              },
            );
          },
          error:
              (error, stackTrace) =>
                  Center(child: Text('Error: ${error.toString()}')),
          loading: () => const LoadingIndicator(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePostScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF182C54),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(
            "Create new post",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
