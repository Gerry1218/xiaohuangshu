import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xhs/ViewModel/CommentViewModel.dart';
import 'package:xhs/components/blog_content_widget.dart';
import 'package:xhs/components/common_widget.dart';
import 'package:xhs/core/api/api.dart';
import 'package:xhs/model/DataCenter.dart';
import 'package:xhs/model/DatabaseUtils.dart';
import 'package:xhs/pages/home/Model/CommentItemModel.dart';
import 'package:xhs/utils/help_utils.dart';
import 'package:xhs/utils/padding_extension.dart';

import '../../constants/color_constants.dart';
import '../home/Model/BlogModel.dart';

class BlogDetailPage extends StatefulWidget {
  BlogDetailPage({super.key, required this.model});

  BlogModel model;

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  // StreamController streamController = StreamController();
  late CommentViewModel viewModel;
  late EasyRefreshController _controller;
  int currIndex = 1;

  bool isVisiblePageNo = false;

  Timer? _timer;

  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    initRefreshController();
    loadData();
  }

  initRefreshController() {
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  loadData() async {
    viewModel = CommentViewModel();

    // Api.blogDetail(1, widget.model.id!);
    if (DataCenter().currentUserModel == null) {
      var model = await Api.appLogin("13188888888", "123456");
      DataCenter().updateUserModel(model);
      if (model != null) {
        DatabaseUtils().updateOrInsertUser(model!);
      }
    }
    viewModel.refreshData(widget.model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
      bottomNavigationBar: _buildToolbar(),
    );
  }

  _buildToolbar() {
    return Container(
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(color: colorF1))),
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: GestureDetector(
                onTap: () {

                },
                child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: colorF1,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 30,
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 20, color: color999),
                      5.paddingWidth,
                      Text(
                        "说点什么",
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      )
                    ],
                  ),
                ),
            ),
          ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: const Row(
              children: [Icon(Icons.favorite_border_rounded), Text("1.01w")],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: const Row(
              children: [Icon(Icons.star_border_rounded), Text("1.2k")],
            ),
          )
        ],
      ),
    );
  }

  _buildContent() {
    return EasyRefresh(
      controller: _controller,
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      onRefresh: () async {
        pageNo = 1;
        await viewModel.refreshData(widget.model.id!);
        if (!mounted) {
          return;
        }

        _controller.finishRefresh();
        _controller.resetFooter();
      },
      onLoad: () async {
        pageNo++;
        await viewModel.loadMoreData(widget.model.id!, pageNo);
        if (!mounted) {
          return;
        }
        _controller.finishLoad(viewModel.noMore
            ? IndicatorResult.noMore
            : IndicatorResult.success);
      },
      child: StreamBuilder(
          stream: viewModel.streamController.stream,
          builder: (BuildContext context,
              AsyncSnapshot<List<CommentItemModel>> snapshot) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSwiper(),
                  _buildContentTitle(),
                  ..._buildContentComment(),
                  _buildCommentList(snapshot),
                ],
              ),
            );
          }),
    );
  }

  _buildSwiper() {
    Size sz = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: sz.width,
          height: sz.height * 5 / 7,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CommonWidget.networkImage(
                      imageUrl:
                          HelpUtils.ossImageUrl(widget.model.imgUrls![index])));
            },
            itemCount: widget.model.imgUrls!.length,
            pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 20),
                builder: DotSwiperPaginationBuilder(
                    size: 6,
                    activeSize: 6,
                    color: Colors.grey.shade300,
                    activeColor: colorF44C40)),
            onIndexChanged: (index) {
              currIndex = index + 1;
              // isVisiblePageNo = true;
              setState(() {
                isVisiblePageNo = true;
              });
              _timer = Timer(const Duration(seconds: 5), () {
                if (mounted) {
                  setState(() {
                    isVisiblePageNo = false;
                  });
                }
              });

              debugPrint("onIndexChanged: $index");
            },
          ),
        ),
        Visibility(
            visible: isVisiblePageNo,
            child: Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(2, 2, 2, 0.6)),
                  child: Text(
                    "$currIndex/${widget.model.imgUrls!.length}",
                    style: tsNumber,
                  ),
                )))
      ],
    );
  }

  _buildContentComment() {
    return [
      Text(
        '共 ${widget.model.commentCount} 条评论',
        style:
            const TextStyle(color: color4C, fontSize: 15, letterSpacing: 0.5),
      ),
      8.paddingHeight,
      commentWidget,
      15.paddingHeight
    ];
  }

  _buildCommentList(AsyncSnapshot<List<CommentItemModel>> snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      List<CommentItemModel> list = snapshot.data!;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: List.generate(
              list.length, (index) => _buildCommentItem(list[index])),
        ),
      );
    } else {
      return const Text("Loading");
    }
  }

  _buildCommentItem(CommentItemModel item, {bool isComment = true}) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
                width: 30,
                height: 30,
                child: CommonWidget.networkImage(imageUrl: item.avatarUrl)),
          ),
          15.paddingWidth,
          Flexible(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.userName),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlogContentWidget(model: item),
                            if (false)
                              GestureDetector(
                                onTap: () {
                                  debugPrint("展开回复...");
                                },
                                child: const Text(
                                  "展开2条回复",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            15.paddingHeight,
                          ],
                        ),
                      ],
                    ),
                  ),
                  6.paddingWidth,
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 25,
                      ),
                      Text("${item.likeCount}")
                    ],
                  ),
                ],
              ),
              if (isComment &&
                  item.replyList != null &&
                  item.replyList!.isNotEmpty)
                ...List.generate(
                    item.replyList!.length,
                    (index) => _buildCommentItem(item.replyList![index],
                        isComment: false)),
            ],
          )), // 5.paddingWidth,
          // Column(
          //   children: [
          //     Icon(
          //       Icons.favorite_border,
          //       size: 25,
          //     ),
          //     Text("821")
          //   ],
          // )
        ],
      ),
    );
  }

  get commentWidget {
    var url =
        "https://img2.baidu.com/it/u=621347114,4165472689&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500";
    return Row(
      children: [
        5.paddingWidth,
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
              width: 30,
              height: 30,
              child: CommonWidget.networkImage(imageUrl: url)),
        ),
        15.paddingWidth,
        Expanded(
            child: GestureDetector(
          onTap: () {
            debugPrint("GestureDetector...");
          },
          child: Container(
            // color: Colors.orange,
            height: 36,
            decoration: const BoxDecoration(
                color: Color.fromARGB(93, 231, 226, 226),
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "让大家听到你的声音",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint("@ event");
                        },
                        child: const Icon(
                          Icons.alternate_email,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint("emoji event");
                        },
                        child: const Icon(
                          Icons.sentiment_satisfied,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint("photo event");
                        },
                        child: const Icon(
                          Icons.image_outlined,
                          size: 25,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  _buildContentTitle() {
    return Container(
      padding: const EdgeInsets.all(10),
      // color: Colors.pink,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          const Text(
            "标题",
            style: TextStyle(
                fontSize: 16, letterSpacing: 0.4, fontWeight: FontWeight.w500),
          ),
          5.paddingHeight,
          Text(
            widget.model.content!,
            style: const TextStyle(
                color: color16,
                fontWeight: FontWeight.w500,
                height: 1.5,
                letterSpacing: 0.3),
          ),
          5.paddingHeight,
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '#程序猿',
                style: const TextStyle(
                    color: Color.fromRGBO(45, 87, 139, 1),
                    fontSize: 13,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {debugPrint("TapGestureRecognizer tag")}),
            TextSpan(
                text: '#大龄程序员',
                style: const TextStyle(
                    color: Color.fromRGBO(45, 87, 139, 1),
                    fontSize: 13,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {debugPrint("TapGestureRecognizer tag")})
          ])),
          Text(
            "${HelpUtils.format(widget.model.gmtCreate!)} 南京",
            style: const TextStyle(
                color: color666, fontSize: 14, letterSpacing: 1),
          ),
          10.paddingHeight,
          Center(
            child: CommonWidget.solidWidget(
                h: 1,
                w: MediaQuery.of(context).size.width * .95,
                color: colorF1),
          ),
          15.paddingHeight
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: Container(
        // decoration: const BoxDecoration(color: Colors.lightBlue),
        child: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context, widget.model);
          },
        ),
      ),
      // centerTitle: true,
      title: _buildTitle(),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                debugPrint("点击了关注");
              },
              child: Container(
                width: 80,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorEB4C41, width: 1),
                ),
                child: const Text(
                  "关注",
                  style: tsFollow,
                ),
              ),
            ),
            // 10.paddingWidth,
            Container(
              // color: Colors.pink,
              child: IconButton(
                  onPressed: () {
                    debugPrint("点击了分享");
                  },
                  icon: const Icon(
                    Icons.ios_share,
                    color: Colors.black54,
                    size: 30,
                  )),
            ),
            10.paddingWidth,
          ],
        )
      ],
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: CommonWidget.solidWidget(
            h: 1, w: MediaQuery.of(context).size.width, color: colorE5),
      ),
    );
  }

  _buildTitle() {
    return Container(
      // color: Colors.green,
      // decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
                width: 44,
                height: 44,
                child: CommonWidget.networkImage(
                    imageUrl: widget.model.avatarUrl!)),
          ),
          // CircleAvatar(
          //   radius: 20,
          //   child: CachedNetworkImage(
          //     imageUrl: widget.model.avatarUrl!,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          10.paddingWidth,
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 180.0, // 设置最大宽度
            ),
            child: Text(
              widget.model.userName!,
              style: tsUserName14,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
