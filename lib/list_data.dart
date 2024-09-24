import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tugas3/side_menu.dart';
import 'package:tugas3/tambah_data.dart';
import 'package:tugas3/update_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataMahasiswa = [];
  String url = Platform.isAndroid ? 'http://192.168.1.130/api_flutter/index.php' : 'http://localhost/api_flutter/index.php';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchData());
  }

  void lihatMahasiswa(String nama, String jurusan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nama Mahasiswa : $nama"),
          content: Text("Jurusan Kuliah : $jurusan"),
        );
      },
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        dataMahasiswa = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'jurusan': item['jurusan'] as String,
            'id': item['id'] as String,
          };
        }));
        setState(() {}); // Add this line to update the UI
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse('$url?id=$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to delete data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Mahasiswa'),
        backgroundColor: Colors.red,
      ),
      drawer: const SideMenu(),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TambahData(url: url),
                ),
              );
            },
            child: const Text('Tambah Data Mahasiswa'),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: dataMahasiswa.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dataMahasiswa[index]['nama']!),
                        subtitle: Text('Jurusan: ${dataMahasiswa[index]['jurusan']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () => lihatMahasiswa(dataMahasiswa[index]['nama']!, dataMahasiswa[index]['jurusan']!),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateData(
                                      id: dataMahasiswa[index]['id']!,
                                      nama: dataMahasiswa[index]['nama']!,
                                      jurusan: dataMahasiswa[index]['jurusan']!,
                                      url: url,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await deleteData(int.parse(dataMahasiswa[index]['id']!));
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Data berhasil di hapus'),
                                      content: const Text('ok'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const ListData(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}