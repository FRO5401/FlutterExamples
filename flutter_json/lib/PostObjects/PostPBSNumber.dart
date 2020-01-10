class PostPBSNumber {
  final String pbsNumber;

  PostPBSNumber({this.pbsNumber});

  factory PostPBSNumber.fromJson(Map<String, dynamic> json) {
    return PostPBSNumber(
      pbsNumber: json['\$t'],
    );
  }
}