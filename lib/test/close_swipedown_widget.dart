import 'package:flutter/material.dart';

class CloseOnSwipeDownWidget extends StatefulWidget {
  final Widget child;

  const CloseOnSwipeDownWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<CloseOnSwipeDownWidget> createState() => CloseOnSwipeDownWidgetState();
}

class CloseOnSwipeDownWidgetState extends State<CloseOnSwipeDownWidget>
    with TickerProviderStateMixin {
  double yOffset = 0.0;
  double initialPosition = 0.0;
  bool isAnimatingOut = false;
  int animTime = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) {
        initialPosition = details.globalPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        double updatedPosition = details.globalPosition.dy;
        double deltaY = updatedPosition - initialPosition;

        animTime = 0;

        setState(() {
          yOffset = yOffset + deltaY;
          initialPosition = updatedPosition;
        });
      },
      onVerticalDragEnd: (details) {
        animTime = 300;

        if (yOffset > 200) {
          // 触发滑出动画
          _startSlideOutAnimation();
        } else {
          // 触发返回原始位置的动画
          _startReturnToOriginalPositionAnimation();
        }
      },
      child: Stack(
        children: [
          AnimatedPositioned(  // 组件跟随手指位移，以及抬起手指后组件移动动画
            duration: Duration(milliseconds: animTime),
            curve: Curves.easeInOut,
            top: yOffset,
            left: 0,
            right: 0,
            child: widget.child,
            onEnd: () {
              if(isAnimatingOut) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  // 开始滑出动画
  void _startSlideOutAnimation() {
    setState(() {
      isAnimatingOut = true;
      yOffset = MediaQuery.of(context).size.height;
    });
  }

  // 开始返回原始位置的动画
  void _startReturnToOriginalPositionAnimation() {
    setState(() {
      yOffset = 0.0;
    });
  }
}
