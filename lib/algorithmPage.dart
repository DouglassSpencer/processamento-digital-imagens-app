import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';


Widget algorithmPage(List<String> _image, File _originalImage, String algorithm) {

  //TELA DE HISTOGRAMA
  if (algorithm == "histogram") {

    //IMAGENS RECEBIDAS DO SERVIDOR
    Uint8List histogram = base64.decode(_image[0]);
    Uint8List red = base64.decode(_image[1]);
    Uint8List green = base64.decode(_image[2]);
    Uint8List blue = base64.decode(_image[3]);
    Uint8List gray = base64.decode(_image[4]);

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

        originalImageText(_originalImage, algorithm),
        if (_image.length == 0)
          Container(child: Text("Não foi possível carregar a imagem"))
        else
          Image.memory(histogram),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(red),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(green),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(blue),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(gray),
      ])
    ]);



    /*TELA DE HISTOGRAMA
    Aqui é exibido um histograma das e componentes R G B e Gray
    seguido das imagens de cada componentes

   */
  }

  //TELA DE NEGATIVO
  else if (algorithm == "negative") {
    Uint8List negative = base64.decode(_image[0]);


    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Imagem Negativa",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(negative),
      ])
    ]);
  }

  //TELA DE BINARIZACAO
  else if (algorithm == "bin") {

    Uint8List bin64 = base64.decode(_image[0]);
    Uint8List bin128 = base64.decode(_image[1]);
    Uint8List bin256 = base64.decode(_image[2]);
    print("bin");

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Limiar 64",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(bin64),
        Text(
          "Limiar 128",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(bin128),
        Text(
          "Limiar 200",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(bin256),
      ])
    ]);

  }

  //TELA DE SUBAMOSTRAGEM
  else if (algorithm == "subsampling") {

    Uint8List sub4 = base64.decode(_image[0]);
    Uint8List sub8 = base64.decode(_image[1]);
    Uint8List sub16 = base64.decode(_image[2]);
    Uint8List sub32 = base64.decode(_image[3]);
    Uint8List sub64 = base64.decode(_image[4]);

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

        originalImageText(_originalImage, algorithm),
        Text(
          "Histograma",
          style: TextStyle(color: Colors.indigo),
        ),
        if (_image.length == 0)
          Container(child: Text("Não foi possível carregar a imagem"))
        else
          Image.memory(sub4),
        Text(
          "RED",
          style: TextStyle(color: Colors.indigo),
        ),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub8),
        Text(
          "GREEN",
          style: TextStyle(color: Colors.indigo),
        ),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub16),
        Text(
          "BLUE",
          style: TextStyle(color: Colors.indigo),
        ),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub32),
        Text(
          "GRAY",
          style: TextStyle(color: Colors.indigo),
        ),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub64),
      ])
    ]);

  }

  //TELA DE LAPLACIANO
  else if (algorithm == "laplace") {

    Uint8List mask3 = base64.decode(_image[0]);
    Uint8List mask5 = base64.decode(_image[1]);
    Uint8List mask7 = base64.decode(_image[2]);

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(mask3),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(mask5),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(mask7),
      ])
    ]);
  }

  //TELA DE SOBEL
  else if (algorithm == "sobel") {
    Uint8List absolut3 = base64.decode(_image[0]);
    Uint8List shift3 = base64.decode(_image[1]);
    Uint8List absolut5 = base64.decode(_image[2]);
    Uint8List shift5 = base64.decode(_image[3]);
    Uint8List absolut7 = base64.decode(_image[4]);
    Uint8List shift7 = base64.decode(_image[5]);

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut3),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(shift3),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut5),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(shift5),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut7),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(shift7),
      ])
    ]);
  }

  //TELA DA TRANSFORMADA DE HOUGH
  else if (algorithm == "hough") {
    Uint8List lines1 = base64.decode(_image[0]);
    Uint8List lines2 = base64.decode(_image[1]);
    Uint8List lines3 = base64.decode(_image[2]);
    Uint8List circles1 = base64.decode(_image[3]);
    Uint8List circles2 = base64.decode(_image[4]);
    Uint8List circles3 = base64.decode(_image[5]);

    return  ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Detecção de linhas com limiar 80",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines1),
        Text(
            "Detecção de linhas com limiar 115",
            style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines2),
        Text(
          "Detecção de linhas com limiar 150",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines3),
        Text(
          "Detecção de círculos com raio máximo de 50",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(circles1),
        Text(
          "Detecção de círculos com raio máximo de 150",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(circles2),
        Text(
          "Detecção de círculos com raio máximo de 250",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(circles3),
      ])
    ]);
  }

  //TELA DO KMEANS
  else if (algorithm == "kmeans") {

    Uint8List kmeans1 = base64.decode(_image[0]);
    Uint8List kmeans2 = base64.decode(_image[1]);
    Uint8List kmeans3 = base64.decode(_image[2]);
    Uint8List kmeans4 = base64.decode(_image[3]);

    return ListView(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        originalImageText(_originalImage, algorithm),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans1),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans2),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans3),
        Text(
          "Imagem Processada",
          style: TextStyle(color: Colors.indigo),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans4),
      ])
    ]);
  }
}


//PADRÃO INICIAL DE CADA TELA
//imagem original com legenda seguida do texto do algoritmo
Widget originalImageText(_image,algorithm){
  return Container(margin: EdgeInsets.only(bottom: 10.0), child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Imagem original",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Container(margin: EdgeInsets.only(bottom: 10.0), child: Image.file(_image)),
        algorithmText(algorithm)
      ]));

}

//TEXTO DE CADA TELA
Widget algorithmText(String algorithm) {
  String text;

  if (algorithm == "histogram") {
    text = "O histograma de uma imagem indica a quantidade de pixels que a imagem tem de um determinado nível de cinza ou cor. Na figura abaixo temos os histogramas dos canais R, G, B e da escala cinza. Logo abaixo temos a apresentação desses canais.";
  } else if (algorithm == "negative") {
    text = "O efeito negativo inverte todas as cores da imagem original.";
  } else if (algorithm == "bin") {
    text = "No processo de binarizar uma imagem, o que ocorre é o seguinte: primeiro a imagem é convertida para tons de cinza. Com isso, agora ela só tem uma cor porém com intensidades diferentes. Depois disso, um valor entre 0 e 255 é escolhido, chamado de limiar. Pixels com intensidades acima do limiar se tornam brancos e pixels abaixo do limiar se tornam pretos. Exemplos: na primeira imagem o limiar é 64, na segunda, 128 e na terceira, 200.";
  } else if (algorithm == "subsampling") {
    text = "Aplicar subamostragem";
  } else if (algorithm == "laplace") {
    text = "Aplicar Laplace";
  } else if (algorithm == "sobel") {
    text = "Aplicar sobel";
  } else if (algorithm == "hough") {
    text =
    "A Transformada de Hough é uma técnica matemática que realiza a detecção de formas geométricas em imagens digitais. Em sua forma original a transformada de Hough foi elaborada por Paul Hough em 1962. Sua primeira concepção estava baseada na localização de retas. Posteriormente, a transformada de Hough foi estendida para possibilitar a localização de outras formas geométricas que possam ser parametrizadas, tais como círculos e elipses. Como exemplo, aqui apresentaremos a deteccção de retas e de círculos. Na detecção de retas, é preciso determinar um limiar. Na primeira figura temos 80 de limiar, na segunda, 115 e na terceira 150. Já na detecção de círculos, precisamos estabelecer o raio máximo dos círculos detectados. Na quarta figura temos 50 de raio máximo, na quinta, 150 e na última, 250. ";
  } else if (algorithm == "kmeans") {
    text = "Aplicar K-Means";
  }

  return Text(text, textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0),);
}

