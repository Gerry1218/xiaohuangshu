

class HelpUtils {
  static String showNumText(int i) {
    if (i > 9999) {
      return "${ (i / 10000).toStringAsFixed(2)}万";
    }
    else {
      return i.toString();
    }
  }

  static String ossImageUrl(String url) {
    return "https://fd-fresh-mall.oss-cn-hangzhou.aliyuncs.com/$url";
  }
}