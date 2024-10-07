class PetNotificationReplies {
  final String id;
  final String postId;
  final String userId;
  final String address;
  final String detail;
  final String createdAt;
  final String updatedAt;

  PetNotificationReplies(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.address,
      required this.detail,
      required this.createdAt,
      required this.updatedAt});

 

  factory PetNotificationReplies.fromJson(Map<String, dynamic> json) {
    return PetNotificationReplies(
        id: json['id'],
        postId: json['post_id'],
        userId: json['user_id'],
        address: json['address'],
        detail: json['detail'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']
    );
  }
}
