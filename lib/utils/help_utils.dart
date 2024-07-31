import 'package:intl/intl.dart';

class HelpUtils {
  static String showNumText(int i) {
    if (i > 9999) {
      return "${(i / 10000).toStringAsFixed(2)}万";
    } else {
      return i.toString();
    }
  }

  static String ossImageUrl(String url) {
    return "https://fd-fresh-mall.oss-cn-hangzhou.aliyuncs.com/$url";
  }

  static String format(int millisecondsSinceEpoch, {bool dayOnly = true}) {
    DateTime nowDate = DateTime.now();
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String prefix = '';

    if (nowDate.year != targetDate.year) {
      prefix = DateFormat('yyyy-M-d').format(targetDate);
    } else if (nowDate.month != targetDate.month) {
      prefix = DateFormat('M-d').format(targetDate);
    } else if (nowDate.day > targetDate.day) {
      if (nowDate.day - targetDate.day == 1) {
        prefix = '昨天';
      } else {
        prefix = DateFormat('M-d').format(targetDate);
      }
    } else if (nowDate.day - targetDate.day == 0) {
      if (nowDate.hour - targetDate.hour > 12 && dayOnly) {
        prefix = DateFormat('h:mm').format(targetDate);
      } else {
        if (nowDate.hour - targetDate.hour == 0) {
          if (nowDate.minute - targetDate.minute <= 5) {
            prefix = '刚刚';
          } else {
            prefix = '${nowDate.minute - targetDate.minute} 分钟前';
          }
        } else {
          prefix = '${nowDate.hour - targetDate.hour} 小时前';
        }
      }
    }

    return '$prefix ';
  }
}
