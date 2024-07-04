import 'package:workmanager/workmanager.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:get/get.dart';

// Background fetch task identifiers
const fetchBooksTask = "fetchBooksTask";
const fetchBookRecommendedTask = "fetchBookRecommendedTask";
const fetchPopularBooksTask = "fetchPopularBooksTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final mainController = Get.find<MainController>();
    
    switch (task) {
      case fetchBooksTask:
        final query = inputData?['query'] ?? 'default query';
        await mainController.fetchBooksInBackground(query);
        break;
      case fetchBookRecommendedTask:
        await mainController.fetchBookRecommendedInBackground();
        break;
      case fetchPopularBooksTask:
        await mainController.fetchPopularBooksInBackground();
        break;
      default:
        print("Unknown task: $task");
    }
    return Future.value(true);
  });
}
