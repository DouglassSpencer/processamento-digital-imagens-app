import 'package:flutter/material.dart';
import 'dart:io';
import 'algorithmPage.dart';

Widget mainButtonStyle(int color, String title) {
  Color color1, color2;

  if (color == 1) {
    color1 = new Color(0xFF00F260);
    color2 = new Color(0xFF0575E6);
  } else if (color == 2) {
    color1 = new Color(0xFF6200EA);
    color2 = new Color(0xFFFF4081);
  } else if (color == 3) {
    color1 = new Color(0xFF0D47A1);
    color2 = new Color(0xFF00BCD4);
  } else if (color == 4) {
    color1 = new Color(0xFFEF6C00);
    color2 = new Color(0xFFFDD835);
  } else if (color == 5) {
    color1 = new Color(0xFFFF1744);
    color2 = new Color(0xFFFF8A80);
  } else if (color == 6) {
    color1 = new Color(0xFF00E5FF);
    color2 = new Color(0xFF9C27B0);
  } else if (color == 7) {
    color1 = new Color(0xFFFF4081);
    color2 = new Color(0xFFEF6C00);
  } else if (color == 8) {
    color1 = new Color(0xFFFDD835);
    color2 = new Color(0xFF00F260);
  }

  return Container(
    //botoes da homepage
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: [color1, color2]),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black, offset: Offset(1.0, 6.0), blurRadius: 40.0)
        ]),
    height: 80.0,
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w200,
              letterSpacing: 4,
            ))
      ],
    )),
  );
}

//PAGINA DOS ALGORITMOS
Widget algorithmPageStyle(
    List<String> _image, File _originalImage, String title, String algorithm) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Color(0xFF283593),
        title: new Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          margin:
              EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 5.0),
          child: algorithmPage(_image, _originalImage, algorithm)));
}


TextEditingController _urlController = new TextEditingController();

Widget urlPageStyle() {
String text;
if (_urlController.text == null) text = "URL já inserida: nenhuma.";
else text = "URL já inserida: " + _urlController.text;
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Color(0xFF283593),
        title: new Text(
          "URL",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          margin:
              EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Text("Insira a URL do sevidor", style: TextStyle(fontSize: 16.0),),
              Padding(padding: EdgeInsets.all(10.0),),
              TextField(
                controller: _urlController,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.web),
                    hintText: 'URL'),
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              Text(text, style: TextStyle(fontSize: 16.0),),
            ],
          )
          //child:
          ));
}
TextEditingController getUrl(){
  return _urlController;
}
