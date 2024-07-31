import 'package:flutter/material.dart';
import 'package:xhs/pages/home/Model/CommentItemModel.dart';
import 'package:xhs/utils/help_utils.dart';
import 'package:xhs/utils/padding_extension.dart';

class BlogContentWidget extends StatefulWidget {
  BlogContentWidget({super.key, required this.model, this.style});

  CommentItemModel model;
  TextStyle? style;

  @override
  State<BlogContentWidget> createState() => _BlogContentWidgetState();
}

class _BlogContentWidgetState extends State<BlogContentWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // final maxWidth = constraints.maxWidth;
        // final textSpan = TextSpan(
        //   text: widget.model.commentContent ?? widget.model.replyContent,
        //   style: widget.style ?? const TextStyle(color: Colors.black),
        // );
        //
        // final textPainter = TextPainter(
        //   text: textSpan,
        //   textDirection: TextDirection.ltr,
        // );
        // textPainter.layout(maxWidth: maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildExpandedText()],
        );
      },
    );
  }

  Widget _buildExpandedText() {
    return RichText(
      softWrap: true,
      text: TextSpan(
        text: widget.model.commentContent ?? widget.model.replyContent,
        style: widget.style ??
            const TextStyle(
              color: Colors.black,
            ),
        children: [
          WidgetSpan(
              child: Container(
            child: Row(
              children: [
                Text(HelpUtils.format(widget.model.gmtCreate),
                    style: TextStyle(color: Colors.grey.shade600)),
                5.paddingWidth,
                Text(
                  "北京",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                5.paddingWidth,
                GestureDetector(
                  child: const Text("回复"),
                  onTap: () {
                    debugPrint("点击 回复 事件...");
                  },
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
