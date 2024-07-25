import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xhs/ViewModel/BlogViewModel.dart';
import 'package:xhs/ViewModel/PostModel.dart';
import 'package:xhs/constants/color_constants.dart';
import 'package:xhs/pages/home/Model/BlogModel.dart';
import 'package:xhs/utils/HelpUtils.dart';
import 'package:xhs/utils/padding_extension.dart';

class FollowPage extends StatefulWidget {
  FollowPage({super.key, required this.categoryId});

  int categoryId;

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _controller;
  late BlogViewModel viewModel;
  int pageNo = 1;
  List<BlogModel> blogList = [];

  @override
  bool get wantKeepAlive => true;

  initRefreshController() {
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initRefreshController();
    loadData();
  }

  loadData() {
    viewModel = BlogViewModel(blogList);
    viewModel.refreshData(1, widget.categoryId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  loadMockData() {
    rootBundle.loadString("mock_data/list.json").then((val) {
      var jsonObj = json.decode(val);
      List<PostModel> newList = <PostModel>[];
      jsonObj.forEach((data) {
        newList.add(PostModel.fromJson(data));
      });
    });
  }

  _buildWaterFlowItem(BlogModel item) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: brTopLR8,
              child: CachedNetworkImage(
                imageUrl: HelpUtils.ossImageUrl(item.imgUrls![0]),
                fit: BoxFit.fill,
              ),
            ),
            5.paddingHeight,
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.content!,
                    style: tsContent,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.paddingHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CachedNetworkImage(
                                  imageUrl: item.avatarUrl!,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          4.paddingWidth,
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 100.0, // 设置最大宽度
                            ),
                            child: Text(
                              item.userName!,
                              style: tsUserName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            iconFav,
                            4.paddingWidth,
                            Text(HelpUtils.showNumText(item.viewCount!),
                                style: tsViewCount),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildWaterFlow(List<BlogModel> list) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: list != null ? list!.length : 0,
      shrinkWrap: true,
      //收缩，让元素宽度自适应
      itemBuilder: (context, index) {
        var item = list![index];
        return _buildWaterFlowItem(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: colorFA,
          child: EasyRefresh(
            controller: _controller,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onRefresh: () async {
              pageNo = 1;
              await viewModel.refreshData(pageNo, widget.categoryId);
              if (!mounted) {
                return;
              }
              _controller.finishRefresh();
              _controller.resetFooter();
            },
            onLoad: () async {
              pageNo++;
              await viewModel.loadMoreData(pageNo, widget.categoryId);
              if (!mounted) {
                return;
              }
              _controller.finishLoad(viewModel.noMore
                  ? IndicatorResult.noMore
                  : IndicatorResult.success);
            },
            child: StreamBuilder(
              stream: viewModel.postStreamController.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<BlogModel>> snapshot) {
                debugPrint("snapshot: $snapshot");

                return snapshot.connectionState == ConnectionState.active
                    ? _buildWaterFlow(snapshot.data!)
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
              },
            ),
          )),
    );
  }
}
