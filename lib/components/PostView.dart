import 'package:flutter/material.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/pages/home/PostDetailsPage.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key, required this.post, required this.categoryName})
      : super(key: key);
  final Post post;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
               PostDetailsPage(post: post,))),
      child: Card(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                post.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (_,__, ___)=>Container(color: theme.colorScheme.onSurface,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      post.title,
                      style: theme.textTheme.headline5
                          ?.copyWith(color: theme.colorScheme.surface),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 40),
                    child: Text(
                      post.content.length>100 ?
                      (post.content.substring(0, 100) + "...") : post.content,
                      style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.colorScheme.surface,
                          fontSize: theme.textTheme.bodyText2!.fontSize! * 1.2),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: theme.colorScheme.surface,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${post.likes}",
                            style: theme.textTheme.headline6
                                ?.copyWith(color: theme.colorScheme.surface),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: theme.colorScheme.surface,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${post.hits}",
                            style: theme.textTheme.headline6
                                ?.copyWith(color: theme.colorScheme.surface),
                          )
                        ],
                      ),
                      Text(
                        categoryName ?? "",
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodyText2
                            ?.copyWith(color: theme.colorScheme.surface),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
