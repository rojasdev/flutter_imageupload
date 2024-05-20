import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  Uint8List? _imageData;
  String? _fileName;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageData = result.files.single.bytes;
        _fileName = result.files.single.name;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    if (_imageData == null || _fileName == null) return;

    // Upload URL and database URL
    const uploadUrl = 'https://devlab.helioho.st/serve/upload.php';
    //final databaseUrl = 'https://your-database-url.com/save-filename.php';

    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        _imageData!,
        filename: _fileName,
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      /*var fileName = await response.stream.bytesToString();

      await http.post(
        Uri.parse(databaseUrl),
        body: {'fileName': fileName},
      ); */

      print('Image uploaded and file name saved successfully');
    } else {
      print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageData == null
                ? const Text('No image selected.')
                : Image.memory(_imageData!),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
