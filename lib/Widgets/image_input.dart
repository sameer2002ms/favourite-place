import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  //here we have call the camera to take the pictures
  _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.amber,)),
            child: _storedImage != null
                ? Image.file(
                    _storedImage!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  )
                : Text(
                    'No Image Taken',
                    textAlign: TextAlign.center,
                  ),
            alignment: Alignment.center,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
              icon: Icon(Icons.camera),
              label: Text('Take Picture'),
              onPressed: _takePicture),
        )
      ],
    );
  }
}
