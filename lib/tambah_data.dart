import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas3/side_menu.dart';
import 'package:tugas3/list_data.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  final String url;

  TambahData({super.key, required this.url});

  @override
  _TambahData createState() => _TambahData(url: url);
}

class _TambahData extends State<TambahData> {
  final String url;
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  _TambahData({required this.url});

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

  Future<void> _insertData(String nama, String jurusan) async {
    if (nama.isEmpty || jurusan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(<String, String>{
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
        throw Exception('Failed to Insert Data');
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
        title: const Text('Tambah Mahasiswa'),
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
              child: const Text('Tambah Mahasiswa'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _insertData(_namaController.text, _jurusanController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}