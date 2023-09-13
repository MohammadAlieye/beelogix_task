import 'package:beelogix_task/model/photo_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class MainScreenController extends GetxController {
  RxBool isSwitched = false.obs;
  var photos = <Photo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final response =
          await Dio().get("https://jsonplaceholder.typicode.com/photos");
      if (response.statusCode == 200) {
        final data = response.data as List;
        final loadedPhotos = data
            .map((json) =>
                Photo(id: json['id'], title: json['title'], url: json['url']))
            .toList();
        photos.assignAll(loadedPhotos);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch photos");
    }
  }
}
