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

class HomeState extends State<Home> {
  //with TickerProviderStateMixin {
  var data;
  File _image;
  bool haveImage = false;
  TextEditingController _urlController = new TextEditingController();

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

  File getImageFile() {
    return _image;
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
            _urlController = getUrl();
            if(_urlController == null){
              setState(() {
                Get.snackbar("Erro", "Nenhuma URL inserida.",
                    duration: Duration(seconds: 3),
                    icon: Icon(Icons.close, color: Colors.white),
                    isDismissible: true,
                    colorText: Colors.white);
              });
            }else{
            //PARA TODOS OS ALGORITMOS MENOS SOBEL E LAPLACE
            if (algorithm != "spatial") {
              //IMAGEM RECEBIDA DO SERVER
              List<String> dataImage64 = await api.upload(_image, algorithm, _urlController.text);

              if (dataImage64.length == 0) {
                setState(() {
                  Get.snackbar("Erro", "Não foi possível processar a imagem.",
                      duration: Duration(seconds: 3),
                      icon: Icon(Icons.close, color: Colors.white),
                      isDismissible: true,
                      colorText: Colors.white);
                });
              } else {
                Get.to(
                    algorithmPageStyle(dataImage64, _image, title, algorithm));
              }
            } else{ //PARA OS FILTROS ESPACIAIS
              Get.to(Scaffold(//PAGINA ANTES DOS DA APLICACAO DOS FILTROS
                backgroundColor: Color(0xFF37474F),
                appBar: new AppBar(
                  elevation: 10.0,
                  centerTitle: true,
                  backgroundColor: Color(0xFF283593),
                  title: new Text(
                    "Filtros Espaciais".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Builder(
                    builder: (context) => ListView(
                          //lista de botoes
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16.0),
                              child: Text(

                                  "Os filtros espaciais compõe um tipo de operação dentre várias  possíveis nas imagens. Para calcular cada valor de pixel de saída, estes filtros realizam uma operação entre um conjunto de pixels da imagem de entrada. Os filtros espaciais geralmente são classificados como lineares e não-lineares, nos quais o primeiro realiza operações de convolução e o segundo utiliza operadores estatísticos. O conjunto de pixels no qual a operação de filtragem é feita são aqueles que estão inclusos em uma máscara, geralmente de tamanho quadrado, e que desliza sobre a imagem para cada novo valor de saída. Os filtros lineares podem ser passa-alta, passa-baixa ou passa-faixa, no qual o primeiro resulta no realce de bordas e detalhes da imagem, o segundo na suavização do gradiente da imagem, e o terceiro é composto por uma sequência dos dois anteriores."
                                  ,style: TextStyle(fontSize: 18.0,color: Colors.white,),
                                  textAlign: TextAlign.justify),
                            ),
                            GestureDetector(
                                child: mainButtonStyle(3, "Filtro Laplaciano"),
                                onTap: () async {
                                  //IMAGEM RECEBIDA DO SERVER
                                  List<String> dataImage64 =
                                      await api.upload(_image, "laplace", _urlController.text);

                                  if (dataImage64.length == 0) {
                                    setState(() {
                                      Get.snackbar("Erro",
                                          "Não foi possível processar a imagem.",
                                          duration: Duration(seconds: 3),
                                          icon: Icon(Icons.close,
                                              color: Colors.white),
                                          isDismissible: true,
                                          colorText: Colors.white);
                                    });
                                  } else {
                                    Get.to(algorithmPageStyle(
                                        dataImage64,
                                        _image,
                                        "Filtro Laplaciano",
                                        "laplace"));
                                  }
                                }),
                            GestureDetector(
                                child: mainButtonStyle(2, "Filtro Sobel"),
                                onTap: () async {
                                  //IMAGEM RECEBIDA DO SERVER
                                  List<String> dataImage64 =
                                      await api.upload(_image, "sobel", _urlController.text);

                                  if (dataImage64.length == 0) {
                                    Get.snackbar("Erro",
                                        "Não foi possível processar a imagem.",
                                        duration: Duration(seconds: 3),
                                        icon: Icon(Icons.close,
                                            color: Colors.white),
                                        isDismissible: true,
                                        colorText: Colors.white);
                                  } else {
                                    Get.to(algorithmPageStyle(dataImage64,
                                        _image, "Filtro de Sobel", "sobel"));
                                  }
                                }),
                          ],
                        )),
              ));}}
          }
        });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFF37474F),
        drawer: Drawer(
          //Menu lateral
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
                    title: Text(
                      'Mensagens',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    title: Text('Perfil',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
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
                      Icons.web,
                      color: Colors.white,
                    ),
                    title: Text('URL',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    onTap: () => {
                      Get.to(urlPageStyle())
                      },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text('Sobre',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    onTap: () => Get.defaultDialog(
                      title: "Sobre",
                      middleText:
                          "Esse é um trabalho apresentado à disciplina de Processamento Digital de Imagens pela PUC Minas. O objetivo é mostrar o resultado da aplicação de alguns métodos da disciplina em uma imagem.",
                    ),
                  ),
                ],
              )),
        ),
        appBar: AppBar(
          //cabeçalho homepage
          elevation: 10.0,
          centerTitle: true,
          backgroundColor: Color(0xFF263238),
          title: new Text(
            'PDI',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Builder(
            builder: (context) => ListView(
                  //lista de botoes
                  children: <Widget>[
                    getListItems(5, 'histogram', 'Histogramas', context),
                    getListItems(2, 'negative', 'Negativo', context),
                    getListItems(3, 'bin', 'Binarização', context),
                    getListItems(4, 'subsampling', 'Subamostragem', context),
                    //getListItems(5, 'laplace', 'Filtro Laplaciano', context),
                    getListItems(1, 'spatial', 'Filtros Espaciais', context),
                    //getListItems(6, 'sobel', 'Filtro de Sobel', context),
                    getListItems(6, 'hough', 'Transformada de Hough', context),
                    getListItems(7, 'kmeans', 'K-Means', context),
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
