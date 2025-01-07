import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_mapel_controller.dart';

class DetailMapelView extends GetView<DetailMapelController> {
  final dynamic mapel; // Sesuaikan tipe data jika sudah pasti
  // ignore: use_super_parameters
  const DetailMapelView({Key? key, required this.mapel}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mapel.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mapel.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
             Text(
  mapel.isi?.replaceAll('\\n', '\n') ?? 'No description available.',
  textAlign: TextAlign.justify, // Membuat teks rata kiri-kanan
  style: TextStyle(
    fontSize: 16,
    color: Colors.grey[700],
    height: 1.5, // Menambah jarak antar baris
    letterSpacing: 0.5, // Memberikan sedikit spasi antar huruf
  ),
),

              // Tambahkan detail lain sesuai kebutuhan
            ],
          ),
        ),
      ),
    );
  }
}
