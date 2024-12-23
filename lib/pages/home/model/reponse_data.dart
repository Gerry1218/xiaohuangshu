class ResponseData<T> {
  String errmsg;
  int errno;
  int timestamp;
  T data;

  ResponseData(
      {required this.data,
      required this.errmsg,
      required this.errno,
      required this.timestamp});
}
