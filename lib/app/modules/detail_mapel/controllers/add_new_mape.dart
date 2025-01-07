import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/mapel.dart';

class AddNewMapelController extends GetxController {
  var mapel = <Mapel>[].obs;
  var isLoading = true.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


   @override
  void onInit() {
    super.onInit();
    getMapel();
  }

 Future<void> getMapel() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await _firestore.collection('mapel').get();
      mapel.value = querySnapshot.docs
          .map((doc) => Mapel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching mapel: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
