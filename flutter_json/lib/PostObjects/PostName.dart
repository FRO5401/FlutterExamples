class PostName {
  final String name;

  PostName({this.name});

  factory PostName.fromJson(Map<String, dynamic> json) {
    return PostName(
      name: json['gsx\$_cokwr']
    );
  }
}