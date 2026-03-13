class FeedbackModel {
  final String name;
  final String email;
  final String category;
  final List<String> improvements;
  final String comments;

  FeedbackModel({
    required this.name,
    required this.email,
    required this.category,
    required this.improvements,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "category": category,
      "improvements": improvements,
      "comments": comments,
    };
  }
}