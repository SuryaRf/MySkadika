import 'package:get/get.dart';

import '../controllers/detail_mapel_controller.dart';

class DetailMapelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMapelController>(
      () => DetailMapelController(),
    );
  }
}
