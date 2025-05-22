import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahLaguView extends StatefulWidget {
  final String playlistId;

  const TambahLaguView({super.key, required this.playlistId});

  @override
  State<TambahLaguView> createState() => _TambahLaguViewState();
}

class _TambahLaguViewState extends State<TambahLaguView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();

  bool isLoading = false;

  Future<void> tambahLagu() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final url = Uri.parse(
        'https://learn.smktelkom-mlg.sch.id/ukl2/playlists/${widget.playlistId}/songs');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": titleController.text,
        "artist": artistController.text,
        "description": descriptionController.text,
        "source": sourceController.text,
        "thumbnail": thumbnailController.text,
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lagu berhasil ditambahkan!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal menambahkan lagu. (${response.statusCode})"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Lagu"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul Lagu'),
                validator: (value) =>
                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: artistController,
                decoration: const InputDecoration(labelText: 'Artis'),
                validator: (value) =>
                    value!.isEmpty ? 'Artis tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: sourceController,
                decoration:
                    const InputDecoration(labelText: 'Link YouTube / Source'),
              ),
              TextFormField(
                controller: thumbnailController,
                decoration:
                    const InputDecoration(labelText: 'Thumbnail (nama file)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : tambahLagu,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Tambah Lagu',
                        style: TextStyle(color: Colors.white),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
