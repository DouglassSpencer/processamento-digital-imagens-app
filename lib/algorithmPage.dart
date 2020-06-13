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
          "\n\nImagem Negativa\n",
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
          "\n\nLimiar 64\n",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(bin64),
        Text(
          "\n\nLimiar 128\n",
          style: TextStyle(color: Colors.indigo, fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(bin128),
        Text(
          "\n\nLimiar 200\n",
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
        if (_image.length == 0)
          Container(child: Text("Não foi possível carregar a imagem"))
        else
          Image.memory(sub4),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub8),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub16),
        _image.length == 0
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(sub32),
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
          "\n\nFiltro de tamanho 3\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(mask3),
        Text(
          "\n\nFiltro de tamanho 5\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(mask5),
        Text(
          "\n\nFiltro de tamanho 7\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
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
          "\n\nFiltro de tamanho 3 com valores absolutos\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut3),
        Text(
          "\n\nFiltro de tamanho 3 com valores deslocados\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(shift3),
        Text(
          "\n\nFiltro de tamanho 5 com valores absolutos\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut5),
        Text(
          "\n\nFiltro de tamanho 5 com valores deslocados\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(shift5),
        Text(
          "\n\nFiltro de tamanho 7 com valores absolutos\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(absolut7),
        Text(
          "\n\nFiltro de tamanho 7 com valores deslocados\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
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
          "\n\nDetecção de linhas com limiar 80\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines1),
        Text(
            "\n\nDetecção de linhas com limiar 115\n",
            style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines2),
        Text(
          "\n\nDetecção de linhas com limiar 150\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(lines3),
        Text(
          "\n\nDetecção de círculos com raio máximo de 50\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(circles1),
        Text(
          "\n\nDetecção de círculos com raio máximo de 150\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(circles2),
        Text(
          "\n\nDetecção de círculos com raio máximo de 250\n",
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
          "\n\n3 Clusters\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans1),
        Text(
          "\n\n5 Clusters\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans2),
        Text(
          "\n\n7 Clusters\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
        ),
        _image == null
            ? Container(child: Text("Não foi possível carregar a imagem"))
            : Image.memory(kmeans3),
        Text(
          "\n\n10 Clusters\n",
          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
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
          "Imagem original\n",
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
    text = "Não sabe o que é um histograma? Peraí que já te conto!"
            "O histograma de uma imagem é um gráfico que mostra a "
            "quantidade de pixels que a imagem de cada nível de cinza "
            "(em uma imagem em tons de cinza) ou nível de uma cor. Só "
            "isso! Na figura abaixo temos os histogramas dos canais RGB "
            "(vermelho, verde e azul) e da escala cinza. Logo após temos "
            "a representação desses canais.";
  } else if (algorithm == "negative") {
    text = "O negativo é um efeito bastante conhecido, facilmente encontrada na maioria"
        " dos editores de imagem. Mas, convenhamos, melhor que utilizar os filtros dos"
        " editores de imagens é usar sabendo como ele fez esse feito impressionante! "
        "Vamos lá! O efeito negativo não tem segredo! Basicamente, o filtro negativo"
        " inverte as cores de uma imagem. Sim, só isso, viu que não é nada mirabolante!"
        " Talvez, você esteja se pergutando \"Afinal, o que é inverter uma cor?\". Vamos considerar"
  " que temos uma imagem codificada com 8 bits, isso significa que temos 256 níveis."
  " Como eu cheguei nisso? Basta fazer 2^8 e a mágica está feita! (lembre-se que é de 0"
  " a 255, hein!?). Agora que já sabemos isso, para inverter a cor de um pixel é só usar"
  " isso aqui: \n\npixel = 255 - pixel_original\n\n Pronto, você acabou de aprender como"
  " fazer o efeito negativo!";
  } else if (algorithm == "bin") {
    text = "A binarização de uma imagem é uma técnica muito legal e muito útil"
        " em diversas aplicações. Basicamente, essa técnica codifica a sua"
        " utilizando dois bits, usualmente, 0 e 1. Onde o 0 corresponde a cor"
        " preta e o 1 a cor branca. Tá, mas tenha calma, você não deve sair"
        " mudando os pixels para 0 e 1 indiscriminadamente não, por favor!"
        " Vamos entender o processo! A primeira coisa que você precisa é ter"
        " uma imagem em tons de cinza, se sua imagem for colorida, será necessário"
        " realizar um conversão! Depois da conversão, temos uma imagem com valores"
        " que podem variar entre 0 e 255 (Lembre-se que 0 a 255 é quando a imagem foi"
    " codificada com 8 bits!). Assim, para binarizar a imagem escolhemos um valor "
  "entre 0 e 255 e mudamos o valor do pixel seguindo o seguinte critério: "
  "todos os pixels acima desse valor tornam-se branco = 1 e todos abaixo desse valor"
  " tornam-se preto = 0. Esse valor escolhido é chamado de limiar. Vamos ver alguns"
  " exemplos! Vou apresentar pra você três imagens, a primeira foi binarizada com"
  " valor de limiar de 64 a segunda com 128 e a terceira com 200. Sentiu a diferença"
  " que a escolha do limiar gera no resultado final?";
  } else if (algorithm == "subsampling") {
    text = "A subamostragem de uma imagem consiste na redução de sua resolução "
        "espacial mantendo a mesma representação da imagem. Para realizar uma "
        "subamostragem, deve-se escolher por qual fator os pixels serão "
        "selecionados. Dado um fator X tal que X > 0, seleciona-se 1 pixel "
        "para a subamostragem a cada X linhas e colunas da imagem. Para X = 1, "
        "o resultado da subamostragem será a imagem original. Nas figuras "
        "abaixo temos subamostragens da imagem por 4, 8, 16, 32 e 64";
  } else if (algorithm == "laplace") {
    text = "Assim como o filtro Sobel, o filtro de Laplace é um filtro linear "
        "passa-alta. Há diferentes máscaras para o filtro de laplace. "
        "Abaixo temos uma máscara laplaciana invariante a 90º. Devido à u"
        "tilização de apenas uma máscara para variações de bordas nos eixos "
        "x e y da imagem, este filtro é dito ser de derivada à segunda.\n\n"
        "         0   -1    0\n"
        "G  =  -1    4    -1    \n"
        "         0   -1    0\n\n"
        "Olha esses exemplos aqui:\n";
  } else if (algorithm == "sobel") {
    text = "O filtro de Sobel é um filtro linear passa-alta que utiliza duas "
        "máscaras, que chamaremos de Gx e Gy. \n\n"
        "         -1   -2   -1               -1    0    -1\n"
        "Gx =  0    0    0     Gy = -2    0    -2\n"
        "         -1   -2   -1               -1    0    -1\n"
        "\nNestas máscaras, Gx realça bordas horizontais e Gy realça bordas "
        "verticais. Para cada pixel da imagem de entrada, tanto a máscara "
        "Gx, quanto a máscara Gy, resultam em um valor de gradiente cada. "
        "A magnitude do vetor gradiente, na imagem de saída, a "
        "partir destas máscaras, é dada pela raíz quadrada da soma dos "
        "quadrados de Gx e Gy. Dá uma olhada em alguns exemplos.\n";
  } else if (algorithm == "hough") {
    text =
    "A Transformada de Hough é uma técnica matemática que realiza a detecção "
        "de formas geométricas em imagens digitais. Em sua forma original a "
        "transformada de Hough foi elaborada por Paul Hough em 1962. Sua "
        "primeira concepção estava baseada na localização de retas. "
        "Posteriormente, a transformada de Hough foi estendida para "
        "possibilitar a localização de outras formas geométricas que possam "
        "ser parametrizadas, tais como círculos e elipses. Como exemplo, aqui "
        "apresentaremos a deteccção de retas e de círculos. Na detecção de "
        "retas, é preciso determinar um limiar. Na primeira figura temos 80 "
        "de limiar, na segunda, 115 e na terceira 150. Já na detecção de "
        "círculos, precisamos estabelecer o raio máximo dos círculos "
        "detectados. Na quarta figura temos 50 de raio máximo, na quinta, "
        "150 e na última, 250. ";
  } else if (algorithm == "kmeans") {
    text = "O K-Means é um algoritmo de agrupamento de dados. A ideia do algoritmo "
        "é muito simples! Imagine que temos um conjunto de dados, esses dados "
        "são, por exemplo, frutas. Sabemos que as frutas possuem algumas "
        "características, então o objetivo do algoritmo é agrupar esses frutas "
        "de acordo com suas características. Um detalhe importante do algoritmo "
        "K-means é que ele necessita que você diga quantos grupos você quer criar. "
        "Esse número de grupos é o parâmetro K. Para um conjunto de dados com K"
        " grupos temos K centroides. Você deve estar se perguntando, mas o que é"
        " um centroide? Calma, vou explicar. O centroide representa o ponto médio"
        " do cluster. Ok, mas, qual a necessidade do centroide? Imagine que temos"
        " queremos agrupar as frutas em três grupos (A, B e C). Selecionamos uma"
        " fruta aleatoriamente e verificamos que ela possui um distância para o centroide A = 1,"
    " para o B = 10 e para o C = 20. Essa fruta será associada ao grupo A, pois o"
        " objetivo é ter um grupo onde as frutas tenham a menor distância possível"
        " do centroide. Isso é o que chamamos de coesão. Mas, para termos bons grupos"
        " não precisamos apenas de coesão, precisamos, também, do conceito de separação,"
        " que significa que o grupo A, por exemplo, deve ser o mais separado possível"
         "do grupos B e C. Agora vamos pensar nisso em uma aplicação em imagens! No "
        " processamento de imagens, não temos frutas temos pixels e os grupos são uma"
         "determinada cor. Então, a característica utilizada para agrupar os pixels são"
    " as cores. Ao aplicar o K-Means em uma imagem e escolher um valor de K, a imagem"
  "de saída terá k cores. Bora lá ver como como fica o resultado disso!";
  }

  return Text(text, textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0),);
}


