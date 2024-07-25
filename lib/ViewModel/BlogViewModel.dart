import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:xhs/core/Api.dart';
import 'package:xhs/core/HTTP/Constants.dart';
import 'package:xhs/pages/home/Model/BlogModel.dart';

class BlogViewModel {
  // 没有更多数据
  bool noMore = false;
  // 没有数据
  bool noData = false;
  // 数据列表
  List<BlogModel> list = [];

  BlogViewModel(this.list);

  StreamController<List<BlogModel>> postStreamController = BehaviorSubject();

  void dispose() {
    postStreamController.close();
  }

  add(BlogModel model) {
    if (postStreamController.isClosed) {
      return;
    }
    list.add(model);
    postStreamController.sink.add(list);
  }

  void loadMore(List<BlogModel> tmpList) {
    // if (list.length > 20) {
    //   list.removeRange(0, list.length - 10);
    // }

    list.addAll(tmpList);
    if (postStreamController.isClosed) return;
    postStreamController.sink.add(list);
  }

  void refresh(List<BlogModel> tmpList) {
    list.clear();
    list.addAll(tmpList);
    postStreamController.sink.add(list);
  }

  Future<List<BlogModel>> getBlogList(int pageNo, int communityId) async {
    List<BlogModel> list = await Api.selectBlogList(pageNo, communityId);
    return list;
  }

  refreshData(int pageNo, int communityId) async {
    noData = false;
    noMore = false;
    List<BlogModel> tmpList = await getBlogList(1, communityId);
    if (tmpList.isEmpty) {
      noData = true;
    }
    list.clear();
    list.addAll(tmpList);
    postStreamController.sink.add(list);
  }

  loadMoreData(int pageNo, int communityId) async {
    List<BlogModel> tmpList = await getBlogList(pageNo, communityId);
    if (tmpList.length < kPageSize) {
      noMore = true;
    }
    list.addAll(tmpList);
    postStreamController.sink.add(list);
  }
}
