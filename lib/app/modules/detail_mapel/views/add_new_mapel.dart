import 'package:flutter/material.dart';

import 'package:get/get.dart';



class AddNewMapel extends GetView<AddNewMapel> {
  const AddNewMapel({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddNewMapel'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddNewMapel is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
