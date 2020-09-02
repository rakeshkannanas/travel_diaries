import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart' ;
import 'dart:io';
import 'package:path_provider/path_provider.dart' as sysdir;
import 'package:path/path.dart' as path;

class ImagePick extends StatefulWidget {
  final Function save;
  ImagePick(this.save);
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File _storedImage;
  Future<void> _takePic() async {
    final picker = ImagePicker();
    final _imagePicked = await picker.getImage(source: ImageSource.camera,maxWidth: 600);
    if(_imagePicked == null)
    {
      return;
    }
    setState(() {
      _storedImage = File(_imagePicked.path);
    });
    final sysDir = await sysdir.getApplicationDocumentsDirectory();
    final imgPath = await path.basename(_storedImage.path);
    final copiedImage = await _storedImage.copy('${sysDir.path}/$imgPath');
    widget.save(copiedImage);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Row(
        children: [
          Container(
            height: 170,
            width: width * 0.5,
            decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
            child: Center(
              child: _storedImage == null ?  Text(
                'No image added',
                textAlign: TextAlign.center,
              ) : Image.file(_storedImage,fit: BoxFit.cover,width: double.infinity,)
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: width * 0.5,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () { _takePic(); },
                    icon: Icon(Icons.camera,color: Theme.of(context).primaryColor,),

                  ),
                  GestureDetector(onTap:(){_takePic(); },child: FittedBox(child: Text('Take Picture',style: TextStyle(color: Theme.of(context).primaryColor),)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
