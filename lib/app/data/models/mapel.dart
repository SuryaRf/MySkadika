import 'package:cloud_firestore/cloud_firestore.dart';

class Mapel {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic> jadwal;
  final String kode;
  final List<String> daftarSiswa;
  final String namaGuru;
  final String isi;


  Mapel({
    required this.id,
    required this.name,
    required this.description,
    required this.jadwal,
    required this.kode,
    required this.daftarSiswa,
    required this.namaGuru,
    required this.isi,
  });

  factory Mapel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Mapel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      jadwal: data['jadwal'] ?? {},
      kode: data['kode'] ?? '',
      daftarSiswa: List<String>.from(data['daftarSiswa'] ?? []),
      namaGuru: data['namaGuru'] ?? '',
      isi: data['isi'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'jadwal': jadwal,
      'kode': kode,
      'daftarSiswa': daftarSiswa,
      'namaGuru': namaGuru,
      'isi': isi,
    };
  }
}
