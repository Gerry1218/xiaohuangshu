import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  static Widget radiusIcons(IconData icon,
      {double size = 50, double iconSize = 30, VoidCallback? onTap}) {
    return ClipOval(
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            side: BorderSide(
                color: Color.fromARGB(255, 219, 217, 217), width: 1)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.white,
            width: size,
            height: size,
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }

  static Widget solidWidget(
      {required double h, required double w, Color? color}) {
    return SizedBox(
      width: w,
      height: h,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );
  }

  static Widget networkImage({required String imageUrl}) {
    if (imageUrl == null || imageUrl.length == 0) {
      debugPrint("null");
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          CircularProgressIndicator(backgroundColor: Colors.grey[200]),
      errorWidget: (context, url, error) {
        debugPrint('Error loading image: $error');
        return const Icon(Icons.error); // 用一个错误图标代替
      },
      fit: BoxFit.cover,
    );
  }
}
