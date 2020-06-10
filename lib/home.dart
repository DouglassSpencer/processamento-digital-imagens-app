import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'api.dart' as api;
import 'style.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  var data;
  File _image;
  bool haveImage = false;

  //BUSCA A IMAGEM
  Future getImage(bool isCamera) async {
    File image;

    if (isCamera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      haveImage = false;
      setState(() {
        Get.snackbar("Erro", "Não é possível carregar a imagem.",
            duration: Duration(seconds: 3),
            icon: Icon(Icons.close, color: Colors.white),
            isDismissible: true,
            colorText: Colors.white);
      });
    } else {
      haveImage = true;
      setState(() {
        Get.snackbar("Imagem carregada", image.path.split("/").last,
            duration: Duration(seconds: 3),
            icon: Icon(Icons.check, color: Colors.white),
            isDismissible: true,
            colorText: Colors.white);
        _image = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  //RETORNA UM BOTÃO PARA A LISTA DE BOTÕES DA HOMEPAGE
  Widget getListItems(
      int color, String algorithm, String title, BuildContext context) {
    return GestureDetector(
        child: mainButtonStyle(color, title),
        onTap: () async {
          if (!haveImage) {
            setState(() {
              Get.snackbar("Erro", "Nenhuma imagem carregada.",
                  duration: Duration(seconds: 3),
                  icon: Icon(Icons.close, color: Colors.white),
                  isDismissible: true,
                  colorText: Colors.white);
            });
          } else {
            //IMAGEM RECEBIDA DO SERVER
            List<String> dataImage64 = await api.upload(_image, algorithm);

            if (dataImage64.length == 0) {
              setState(() {
                Get.snackbar("Erro", "Não foi possível processar a imagem.",
                    duration: Duration(seconds: 3),
                    icon: Icon(Icons.close, color: Colors.white),
                    isDismissible: true,
                    colorText: Colors.white);
              });
            } else{
              Get.to(algorithmPageStyle(
                dataImage64, _image, title, algorithm));}
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFF37474F),
        drawer: Drawer(//Menu lateral
          child: Container(
              color: Color(0xFF263238),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Image.asset("assets/images/arvore.JPG"),
                  ListTile(
                    leading: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    title: Text('Mensagens',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    title: Text('Perfil',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text('Configurações',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text('Sobre',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    onTap: () => Get.defaultDialog(
                      middleText:
                          "Esse é um trabalho apresentado à disciplina de Processamento Digital de Imagens pela PUC Minas. O objetivo é mostrar o resultado da aplicação de alguns métodos da disciplina em uma imagem.",
                    ),
                  ),
                ],
              )),
        ),
        appBar: AppBar( //cabeçalho homepage
          elevation: 10.0,
          centerTitle: true,
          backgroundColor: Color(0xFF263238),
          title: new Text(
            'PDI',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Builder(
            builder: (context) => ListView(//lista de botoes
                  children: <Widget>[
                    getListItems(1, 'histogram', 'Histogramas', context),
                    getListItems(2, 'negative', 'Negativo', context),
                    getListItems(3, 'bin', 'Binarização', context),
                    getListItems(4, 'subsampling', 'Subamostragem', context),
                    getListItems(5, 'laplace', 'Filtro Laplaciano', context),
                    getListItems(6, 'sobel', 'Filtro de Sobel', context),
                    getListItems(7, 'hough', 'Transformada de Hough', context),
                    getListItems(8, 'kmeans', 'K-Means', context),
                  ],
                )),

        //ADICIONAR IMAGEM
        floatingActionButton: SpeedDial(
            backgroundColor: Colors.red,
            closeManually: true,
            child: Icon(Icons.add_a_photo),
            children: [
              SpeedDialChild(
                  child: Icon(Icons.camera),
                  label: "Câmera",
                  backgroundColor: Colors.blue,
                  onTap: () => getImage(true)),
              SpeedDialChild(
                  child: Icon(Icons.photo),
                  label: "Galeria",
                  backgroundColor: Colors.green,
                  onTap: () => getImage(false)),
            ]));
  }
}
