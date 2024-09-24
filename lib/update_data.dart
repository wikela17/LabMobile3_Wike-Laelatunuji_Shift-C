import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas3/side_menu.dart';
import 'package:tugas3/list_data.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final String id;
  final String nama;
  final String jurusan;
  final String url;

  UpdateData({super.key, required this.id, required this.nama, required this.jurusan, required this.url});

  @override
  _UpdateData createState() => _UpdateData(url: url);
}

class _UpdateData extends State<UpdateData> {
  final String url;
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  _UpdateData({required this.url});

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama;
    _jurusanController.text = widget.jurusan;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }

  Widget _buatInput(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  Future<void> _updateData(String nama, String jurusan, String id) async {
    if (nama.isEmpty || jurusan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(<String, String>{
          'id': id,
          'nama': nama,
          'jurusan': jurusan,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListData()),
        );
      } else {
        throw Exception('Failed to Update Data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Mahasiswa'),
        backgroundColor: const Color.fromARGB(255, 162, 244, 54),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buatInput(_namaController, 'Masukkan Nama Mahasiswa'),
            _buatInput(_jurusanController, 'Masukkan Jurusan'),
            ElevatedButton(
              child: const Text('Edit Mahasiswa'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _updateData(_namaController.text, _jurusanController.text, widget.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}