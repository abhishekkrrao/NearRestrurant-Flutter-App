import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  Edit(this.state);

  var state;

  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerMobile = new TextEditingController();
  TextEditingController _controllerAddress = new TextEditingController();
  File _image;
  // VideoPlayerController _controllers;
  var isVideo = false;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller.value = TextEditingValue(
      text: widget.state['name'],
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.state['name'].length),
      ),
    );
    _controllerEmail.value = TextEditingValue(
      text: widget.state['email'],
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.state['email'].length),
      ),
    );
    _controllerMobile.value = TextEditingValue(
      text: widget.state['mobile'],
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.state['mobile'].length),
      ),
    );
    _controllerAddress.value = TextEditingValue(
      text: widget.state['addres'],
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.state['addres'].length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        centerTitle: false,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 96.0,

                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 96,
                        width: 96,
                        child: Container(
                          height: 96,
                          width: 96,
                          child: _image == null ? logoWidget("assets/user.png") : pickerWidget(_image),
                        ),
                      ),
                      Positioned(
                        right: -10.0,
                        top: -10.0,
                        child: IconButton(
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.gallery);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 23,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextInput(
                  "Full Name ", "Full Name  *", "Full Name ", _controller, 55),
              TextInput("Email", "Email *", "email", _controllerEmail, 55),
              TextInput("Mobile", "Mobile *", "Mobile", _controllerMobile, 55),
              TextInput(
                  "Address", "Address *", "Address", _controllerAddress, 100),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: customButtom(context, "Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Buttom
  Widget customButtom(BuildContext context, String label) {
    print(widget.state);
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 46,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.green,
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 21,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Custom Input Field
  Widget TextInput(hintData, labelData, type, TextEditingController _controller,
      double hieght) {
    return SizedBox(
        height: hieght,
        width: double.infinity,
        child: TextField(
          maxLines: 3,
          controller: _controller,
          decoration: InputDecoration(
              hintText: hintData,
              labelText: labelData,
              labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              hintStyle: TextStyle(fontSize: 11, color: Colors.black38),
              contentPadding: EdgeInsets.all(5),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12)),
              focusColor: Colors.black12,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12))),
          keyboardType: type == "email"
              ? TextInputType.emailAddress
              : (type == "Mobile" ? TextInputType.number : TextInputType.text),
        ));
  }

  //Logo
  Widget logoWidget(String path) {
    return Center(
      child: Image(
        height: 96,
        width: 96,
        image: AssetImage(path),
      ),
    );
  }

  //Logo
  Widget pickerWidget(File path) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(96),
        child: Image.file(path,fit:BoxFit.fill,height: 88,),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 96,
        maxHeight: 96,
        imageQuality: 100,
      );
      setState(() {
         print(pickedFile.path);
         _image = File(pickedFile.path);
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
