import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myskadika/app/data/models/mapel.dart';

class StudentHomeController extends GetxController {
var mapel = <Mapel>[].obs;
  var isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchMapel();
  }

  Future<void> fetchMapel() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await _firestore.collection('mapel').get();
      mapel.value =
          snapshot.docs.map((doc) => Mapel.fromFirestore(doc)).toList();
    } finally {
      isLoading.value = false;
    }
  }
  // Fungsi untuk refresh data
  Future<void> refreshData() async {
    await fetchMapel(); 
  }
}
