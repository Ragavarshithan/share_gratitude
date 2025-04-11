class Post {
  final int? id;
  final String title;
  final String body;
  final int userId;

  Post({
    this.id,
    required this.title,
    required this.body,
    this.userId = 0,
  });

  Post copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }

  factory Post.fromJson(Map<String,dynamic>json){
    return Post(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        userId: json['userId']
    );
  }

  Map<String,dynamic>toJson(){
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    return other is Post &&
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.userId == userId;
  }

  @override
  int get hashCode => Object.hash(id,title,body,userId);

  @override
  String toString(){
    return 'Post(id: $id, title: $title, body: $body, userId: $userId)';
  }

  }