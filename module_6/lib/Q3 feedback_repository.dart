//import '../model/feedback_model.dart';
import 'Q3 api_service.dart';
import 'Q3 feedback_model.dart';
import 'Q3 local_storage_service.dart';
//import '../../../core/services/api_service.dart';
//import '../../../core/services/local_storage_service.dart';

class FeedbackRepository {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  FeedbackRepository({
    required this.apiService,
    required this.localStorageService,
  });

  Future<bool> submitFeedback(FeedbackModel model) async {
    await localStorageService.saveFeedback(model.toJson());
    return await apiService.sendFeedback(model.toJson());
  }
}