import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannersController extends GetxController {
  RxList<String> bannerUrls = RxList([]);

  @override
  void onInit() {
    super.onInit();

    fetchBannersUrls();
  }

  // fatch banners data
  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection("Banners").get();

      if (bannersSnapshot.docs.isNotEmpty) {
        bannerUrls.value =
            bannersSnapshot.docs.map((doc) => doc['image'] as String).toList();
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
