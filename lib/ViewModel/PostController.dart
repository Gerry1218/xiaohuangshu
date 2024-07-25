import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'PostModel.dart';

class PostController implements IPostController {
  final List<PostModel> initPostModelList;
  final ScrollController scrollController;

  PostController(
      {required this.initPostModelList, required this.scrollController});

  StreamController<List<PostModel>> postStreamController = BehaviorSubject();

  void dispose() {
    postStreamController.close();
    scrollController.dispose();
  }

  void widgetReady() {
    if (!postStreamController.isClosed) {
      postStreamController.sink.add(initPostModelList);
    }
  }

  Future<List<PostModel>> getPageData(
      {int pageSize = 30,
      int pageNumber = 1,
      List<PostModel> initPostList = const []}) async {
    int start = (pageNumber - 1) * pageSize;
    int end = start + pageSize;

    if (start >= initPostList.length) {
      return [];
    }
    if (end > initPostList.length) {
      end = initPostList.length;
    }

    debugPrint("pageNumber: $pageNumber");
    return initPostList.sublist(start, end);
  }

  @override
  void addPost(PostModel postModel) {
    if (postStreamController.isClosed) {
      return;
    }
    initPostModelList.add(postModel);
    postStreamController.sink.add(initPostModelList);
  }

  @override
  void loadMoreData(List<PostModel> list) {
    if (initPostModelList.length > 20) {
      initPostModelList.removeRange(0, initPostModelList.length - 10);
    }

    initPostModelList.addAll(list);
    if (postStreamController.isClosed) return;
    postStreamController.sink.add(initPostModelList);
  }

  @override
  void refreshData(List<PostModel> list) {
    initPostModelList.clear();
    initPostModelList.addAll(list);
  }
}

abstract class IPostController {
  void addPost(PostModel postModel);

  void loadMoreData(List<PostModel> list);

  void refreshData(List<PostModel> list);
}
