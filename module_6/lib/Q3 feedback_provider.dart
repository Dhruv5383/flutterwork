import 'package:flutter/material.dart';
//import '../model/feedback_model.dart';
//import '../repository/feedback_repository.dart';
import 'Q3 feedback_model.dart';
import 'Q3 feedback_repository.dart';

class FeedbackProvider extends ChangeNotifier {
  final FeedbackRepository repository;

  FeedbackProvider({required this.repository});

  bool isLoading = false;

  Future<bool> submit(FeedbackModel model) async {
    isLoading = true;
    notifyListeners();

    bool result = await repository.submitFeedback(model);

    isLoading = false;
    notifyListeners();

    return result;
  }
}