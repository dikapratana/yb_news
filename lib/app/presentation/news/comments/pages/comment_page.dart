import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yb_news/app/core/components/button/app_button.dart';
import 'package:yb_news/app/core/components/form/text_field/reactive_text_field.dart';
import 'package:yb_news/app/core/components/layout/main_layout.dart';
import 'package:yb_news/app/core/components/typography/app_text.dart';
import 'package:yb_news/app/core/styles/app_colors.dart';
import 'package:yb_news/app/extentions/space_extention.dart';

class SubCommentModel {
  final String name;
  final String avatar;
  final String text;
  final String timeAgo;
  final int likes;

  SubCommentModel({
    required this.name,
    required this.avatar,
    required this.text,
    required this.timeAgo,
    required this.likes,
  });
}

class CommentModel {
  final String name;
  final String avatar;
  final String text;
  final String timeAgo;
  final int likes;
  final List<SubCommentModel> replies;

  CommentModel({
    required this.name,
    required this.avatar,
    required this.text,
    required this.timeAgo,
    required this.likes,
    this.replies = const [],
  });
}

class CommentPage extends HookWidget {
  CommentPage({super.key});

  final List<CommentModel> _comments = [
    CommentModel(
      name: 'Wilson Franci',
      avatar: 'https://via.placeholder.com/48?text=WF',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 125,
    ),
    CommentModel(
      name: 'Madelyn Saris',
      avatar: 'https://via.placeholder.com/48?text=MS',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typeetting industry.',
      timeAgo: '4w',
      likes: 3,
      replies: [
        SubCommentModel(
          name: 'John Doe',
          avatar: 'https://via.placeholder.com/48?text=JD',
          text: 'Great point! I totally agree with this.',
          timeAgo: '3w',
          likes: 5,
        ),
        SubCommentModel(
          name: 'Jane Smith',
          avatar: 'https://via.placeholder.com/48?text=JS',
          text: 'Thanks for sharing this insight!',
          timeAgo: '2w',
          likes: 2,
        ),
      ],
    ),
    CommentModel(
      name: 'Marley Botosh',
      avatar: 'https://via.placeholder.com/48?text=MB',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 12,
      replies: [
        SubCommentModel(
          name: 'Alex Johnson',
          avatar: 'https://via.placeholder.com/48?text=AJ',
          text: 'I appreciate your perspective on this topic.',
          timeAgo: '3w',
          likes: 8,
        ),
      ],
    ),
    CommentModel(
      name: 'Alffonso Septimus',
      avatar: 'https://via.placeholder.com/48?text=AS',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 14000,
      replies: [
        SubCommentModel(
          name: 'Emma Wilson',
          avatar: 'https://via.placeholder.com/48?text=EW',
          text: 'This is exactly what I was thinking!',
          timeAgo: '4w',
          likes: 45,
        ),
        SubCommentModel(
          name: 'Michael Brown',
          avatar: 'https://via.placeholder.com/48?text=MB',
          text: 'Well said, completely on point.',
          timeAgo: '4w',
          likes: 23,
        ),
      ],
    ),
    CommentModel(
      name: 'Omar Herwitz',
      avatar: 'https://via.placeholder.com/48?text=OH',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      timeAgo: '4w',
      likes: 16,
    ),
    CommentModel(
      name: 'Corey Geidt',
      avatar: 'https://via.placeholder.com/48?text=CG',
      text: '',
      timeAgo: 'now',
      likes: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final commentControl = FormControl<String>();
    final likedComments = useState<Set<int>>({});
    final likedSubComments = useState<Set<String>>({});
    final expandedComments = useState<Set<int>>({});

    return MainLayout(
      title: 'Comments',
      showBackButton: true,
      onBackPressed: () => Navigator.pop(context),
      isScrollable: false,
      appbar: true,
      child: Column(
        children: [
          // COMMENTS LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _comments.length,
              itemBuilder: (ctx, index) {
                final comment = _comments[index];
                final isLiked = likedComments.value.contains(index);
                final isExpanded = expandedComments.value.contains(index);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildComment(
                        context: ctx,
                        avatar: comment.avatar,
                        name: comment.name,
                        text: comment.text,
                        timeAgo: comment.timeAgo,
                        likes: comment.likes,
                        isLiked: isLiked,
                        onLikeTap: () => _toggleLike(likedComments, index),
                        onReplyTap: () => _showReply(ctx, comment.name),
                      ),
                      if (comment.replies.isNotEmpty && !isExpanded)
                        _buildSeeMore(
                          count: comment.replies.length,
                          onTap: () => _toggleExpand(expandedComments, index),
                        ),
                      if (comment.replies.isNotEmpty && isExpanded)
                        _buildReplies(
                          context: ctx,
                          replies: comment.replies,
                          liked: likedSubComments,
                          parentIndex: index,
                        ),
                      if (comment.replies.isNotEmpty && isExpanded)
                        _buildHideButton(
                          onTap: () => _toggleExpand(expandedComments, index),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildInput(context, commentControl),
        ],
      ),
    );
  }

  Widget _buildComment({
    required BuildContext context,
    required String avatar,
    required String name,
    required String text,
    required String timeAgo,
    required int likes,
    required bool isLiked,
    required VoidCallback onLikeTap,
    required VoidCallback onReplyTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(avatar),
          backgroundColor: Colors.grey.shade300,
        ),
        12.w,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(name, fontSize: 14, fontWeight: FontWeight.bold),
              4.h,
              if (text.isNotEmpty) AppText(text, fontSize: 13),
              if (text.isNotEmpty) 8.h,
              _buildActionRow(timeAgo, likes, isLiked, onLikeTap, onReplyTap),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(
    String timeAgo,
    int likes,
    bool isLiked,
    VoidCallback onLikeTap,
    VoidCallback onReplyTap,
  ) {
    return Row(
      children: [
        AppText(timeAgo, fontSize: 12, color: Colors.grey.shade600),
        12.w,
        GestureDetector(
          onTap: onLikeTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 14,
                color: isLiked ? Colors.red : Colors.grey.shade600,
              ),
              4.w,
              AppText(
                _formatNumber(likes),
                fontSize: 12,
                color: isLiked ? Colors.red : Colors.grey.shade600,
              ),
            ],
          ),
        ),
        12.w,
        GestureDetector(
          onTap: onReplyTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.reply, size: 12, color: Colors.grey.shade600),
              4.w,
              AppText('reply', fontSize: 12, color: Colors.grey.shade600),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReplies({
    required BuildContext context,
    required List<SubCommentModel> replies,
    required ValueNotifier<Set<String>> liked,
    required int parentIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: List.generate(replies.length, (i) {
          final reply = replies[i];
          final key = '${parentIndex}_$i';
          final isLiked = liked.value.contains(key);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 60),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(reply.avatar),
                  backgroundColor: Colors.grey.shade300,
                ),
                12.w,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        reply.name,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      4.h,
                      AppText(reply.text, fontSize: 12),
                      8.h,
                      _buildActionRow(
                        reply.timeAgo,
                        reply.likes,
                        isLiked,
                        () => _toggleLikeSubComment(liked, key),
                        () => _showReply(context, reply.name),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSeeMore({required int count, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AppText(
          'See more ($count)',
          fontSize: 12,
          color: AppColors.neutral2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHideButton({required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AppText(
          'Hide replies',
          fontSize: 12,
          color: AppColors.neutral2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, FormControl<String> commentControl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ReactiveTextFieldX(
              formControl: commentControl,
              hint: 'Type your comment',
              onSuffixTap: () => _submitComment(context, commentControl),
            ),
          ),
          12.w,
          AppButton(
            padding: EdgeInsets.all(8),
            isFullWidth: false,
            icon: Transform.rotate(
              angle: -math.pi / 4, // Memutar -45 derajat ke arah Timur Laut
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
            onPressed: () => _submitComment(context, commentControl),
          ),
        ],
      ),
    );
  }

  // HELPERS
  void _toggleLike(ValueNotifier<Set<int>> liked, int index) {
    if (liked.value.contains(index)) {
      liked.value = {...liked.value}..remove(index);
    } else {
      liked.value = {...liked.value, index};
    }
  }

  void _toggleLikeSubComment(ValueNotifier<Set<String>> liked, String key) {
    if (liked.value.contains(key)) {
      liked.value = {...liked.value}..remove(key);
    } else {
      liked.value = {...liked.value, key};
    }
  }

  void _toggleExpand(ValueNotifier<Set<int>> expanded, int index) {
    if (expanded.value.contains(index)) {
      expanded.value = {...expanded.value}..remove(index);
    } else {
      expanded.value = {...expanded.value, index};
    }
  }

  void _showReply(BuildContext context, String name) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Reply to $name')));
  }

  void _submitComment(BuildContext context, FormControl<String> control) {
    if (control.value?.toString().isNotEmpty ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comment posted!'),
          duration: Duration(seconds: 1),
        ),
      );
      control.reset();
    }
  }

  String _formatNumber(int n) => n >= 1000000
      ? '${(n / 1000000).toStringAsFixed(1)}M'
      : n >= 1000
      ? '${(n / 1000).toStringAsFixed(1)}K'
      : n.toString();
}
