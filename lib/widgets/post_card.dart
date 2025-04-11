import 'package:flutter/material.dart';
import 'package:share_gratitude/model/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;
  final List<Color> gradient;

  const PostCard({
    Key? key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
    required this.index,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<List<Color>> cardGradients = [
    //   [Color(0xFFFFA726), Color(0xFFFF7043)],
    //   [Color(0xFFF06292), Color(0xFFBA68C8)],
    //   [Color(0xFF9575CD), Color(0xFF7986CB)],
    // ];
    //
    // final gradient = cardGradients[index % cardGradients.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(200),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  post.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(post.body, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
