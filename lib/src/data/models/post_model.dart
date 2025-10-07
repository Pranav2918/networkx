class Posts {
  Posts({required this.pagination, required this.postData});

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    pagination: PostPagination.fromJson(json['pagination']),
    postData: (json['posts'] as List<dynamic>)
        .map((item) => PostData.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  final PostPagination pagination;
  final List<PostData> postData;
}

class PostPagination {
  PostPagination({
    required this.pageSize,
    required this.nextPage,
    required this.length,
    required this.totalCount,
  });

  factory PostPagination.fromJson(Map<String, dynamic> json) => PostPagination(
    pageSize: json['pageSize'] ?? 0,
    nextPage: json['nextPage'] ?? 0,
    length: json['length'] ?? 0,
    totalCount: json['totalCount'] ?? 0,
  );

  final int pageSize;
  final int nextPage;
  final int length;
  final int totalCount;
}

class PostData {
  PostData({
    required this.id,
    required this.address,
    required this.postHashtags,
    required this.postDescription,
  });
  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    id: json['_id'],
    address: json['address'],
    postHashtags: json['postHashTags'],
    postDescription: json['postDescription'],
  );

  final String id;
  final String address;
  final String postHashtags;
  final String postDescription;
}
