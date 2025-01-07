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
          jadwal: {'jadwal': _jadwalController.text.trim()},
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Mapel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Mapel tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: _jadwalController,
                decoration: const InputDecoration(labelText: 'Jadwal'),
              ),
              TextFormField(
                controller: _kodeController,
                decoration: const InputDecoration(labelText: 'Kode Mapel'),
              ),
              TextFormField(
                controller: _namaGuruController,
                decoration: const InputDecoration(labelText: 'Nama Guru'),
              ),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(labelText: 'Isi Mapel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Isi Mapel tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addMapel,
                child: const Text('Simpan Mapel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
