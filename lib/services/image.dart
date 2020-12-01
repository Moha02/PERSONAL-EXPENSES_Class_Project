import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;



class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File storedImage;


  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await storedImage.copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
  }
  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: storedImage != null
              ? Image.file(
                  storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}





  // @override
  // Widget build(BuildContext context) {
  //   return Container(
      
  //   );
  // }



// class Image extends StatefulWidget {
//   @override
//   _ImageState createState() => _ImageState();
// }

// class _ImageState extends State<Image> {
//   File _storedImage;

//   Future<void> _takePicture() async {
//     final imageFile = await ImagePicker.getImage(
//       source: ImageSource.camera,
//       maxWidth: 600,
//     );
//     setState(() {
//       _storedImage = imageFile;
//     });
//     final appDir = await syspaths.getApplicationDocumentsDirectory();
//     final fileName = path.basename(imageFile.path);
//     final savedImage = await imageFile.copy('${appDir.path}/$fileName');



//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: 150,
//           height: 100,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.grey),
//           ),
//           child: _storedImage != null
//               ? Image.file(
//                   _storedImage,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 )
//               : Text(
//                   'No Image Taken',
//                   textAlign: TextAlign.center,
//                 ),
//           alignment: Alignment.center,
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Expanded(
//           child: FlatButton.icon(
//             icon: Icon(Icons.camera),
//             label: Text('Take Picture'),
//             textColor: Theme.of(context).primaryColor,
//             onPressed: _takePicture,
//           ),
//         ),
//       ],
//     );
//   }
// }}