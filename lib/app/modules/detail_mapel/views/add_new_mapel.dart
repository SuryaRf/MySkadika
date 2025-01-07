import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myskadika/app/data/models/mapel.dart';

class AddNewMapel extends StatefulWidget {
  const AddNewMapel({super.key});

  @override
  State<AddNewMapel> createState() => _AddNewMapelState();
}

class _AddNewMapelState extends State<AddNewMapel> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _jadwalController = TextEditingController();
  final _kodeController = TextEditingController();
  final _namaGuruController = TextEditingController();
  final _isiController = TextEditingController();
  final _jamController = TextEditingController();

  final List<String> _daftarSiswa = []; // Kosongkan atau isi default sesuai kebutuhan

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addMapel() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Buat instance Mapel baru
        Mapel newMapel = Mapel(
          id: '', // ID akan dibuat oleh Firestore
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          jadwal: {'hari': _jadwalController.text.trim(), 'jam': _jamController.text.trim()},
          kode: _kodeController.text.trim(),
          daftarSiswa: _daftarSiswa,
          namaGuru: _namaGuruController.text.trim(),
          isi: _isiController.text.trim(),
        );

        // Simpan ke Firestore
        await _firestore.collection('mapel').add(newMapel.toFirestore());

        Get.snackbar(
          'Success',
          'Mapel berhasil ditambahkan',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reset form setelah sukses
        _formKey.currentState!.reset();
        _nameController.clear();
        _descriptionController.clear();
        _jadwalController.clear();
        _kodeController.clear();
        _namaGuruController.clear();
        _isiController.clear();
        _jamController.clear();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal menambahkan Mapel: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mata Pelajaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        'Form Tambah Mapel',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nama Mapel',
                      hintText: 'Masukkan nama mapel',
                      icon: Icons.book,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama Mapel tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Deskripsi',
                      hintText: 'Masukkan deskripsi mapel',
                      icon: Icons.description,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _jadwalController,
                      label: 'Hari',
                      hintText: 'Masukkan hari jadwal',
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _jamController,
                      label: 'Jam',
                      hintText: 'Masukkan jam jadwal',
                      icon: Icons.access_time,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _kodeController,
                      label: 'Kode Mapel',
                      hintText: 'Masukkan kode mapel',
                      icon: Icons.code,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _namaGuruController,
                      label: 'Nama Guru',
                      hintText: 'Masukkan nama guru',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _isiController,
                      label: 'Isi Mapel',
                      hintText: 'Masukkan isi mapel',
                      icon: Icons.edit,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Isi Mapel tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        
                        onPressed: _addMapel,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                            
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Simpan Mapel',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.green,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
