class PostFrozen {
  final String frozen;

  PostFrozen({this.frozen});

  factory PostFrozen.fromJson(Map<String, dynamic> json) {
    return PostFrozen(
      frozen: json['\$t']
    );
  }
}