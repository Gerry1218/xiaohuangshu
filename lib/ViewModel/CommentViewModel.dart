import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../core/api/api.dart';
import '../core/HTTP/constants.dart';
import '../pages/home/Model/CommentItemModel.dart';

class CommentViewModel {
  List<CommentItemModel> comments = [];
  StreamController<List<CommentItemModel>> streamController = BehaviorSubject();

// 没有更多数据
  bool noMore = false;

  // 没有数据
  bool noData = false;

  getCommentList(int blogId, int pageNo) async {
    List<CommentItemModel> list = await Api.blogCommentList(120, blogId, 1);
    return list;
  }

  refreshData(int blogId) async {
    noMore = false;
    noData = false;
    var tmpList = await getCommentList(blogId, 1);
    if (tmpList.length < kPageSize) {
      noMore = true;
    }
    comments.clear();
    comments.addAll(tmpList);
    streamController.sink.add(comments);
  }

  loadMoreData(int blogId, int pageNo) async {
    if (noMore) {
      debugPrint("no more");
      return;
    }
    List<CommentItemModel> tmpList = await getCommentList(blogId, pageNo);
    if (tmpList.length < kPageSize) {
      noMore = true;
    }
    comments.addAll(tmpList);
    streamController.sink.add(comments);
  }
}
