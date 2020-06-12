import 'package:http/http.dart' as http;
import 'dart:convert';

//COMUNICACAO COM O SERVER VIA JSON
Future upload(file, algorithm) async {

  int response;

  print("upload");
  String body;

  if (file == null) return;

  //Leitura e conversão para base64 da imagem
  String base64Image = base64Encode(file.readAsBytesSync());
  String fileName = file.path.split("/").last;
  print(fileName);

  //Envio e recebimento da imagem
  await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "image": base64Image,
            "filename": fileName,
            "algorithm": algorithm
          }))
      .then((res){
        response = res.statusCode;
        print('Response status: ${res.statusCode}');
        print('Responde size: ${res.body.length}');
        body = res.body;
        //print('Response body: ${res.body}');
  }).catchError((err) {
    print("Erro:");
    print(err);
    //return null;
  });

  List<String> image = List<String>();
  if (response == 200) {
    Map<String, dynamic> dataImageJson = jsonDecode(body);

    if (algorithm == "histogram") {
      image.add(dataImageJson['histogram'].toString());
      image.add(dataImageJson['red'].toString());
      image.add(dataImageJson['green'].toString());
      image.add(dataImageJson['blue'].toString());
      image.add(dataImageJson['gray'].toString());
    }
    if (algorithm == "bin") {
      image.add(dataImageJson['bin64'].toString());
      image.add(dataImageJson['bin128'].toString());
      image.add(dataImageJson['bin200'].toString());
    }
    else if (algorithm == "hough") {
      image.add(dataImageJson['lines1']);
      image.add(dataImageJson['lines2']);
      image.add(dataImageJson['lines3']);
      image.add(dataImageJson['circles1']);
      image.add(dataImageJson['circles2']);
      image.add(dataImageJson['circles3']);
    } else if (algorithm == "subsampling") {
      image.add(dataImageJson['sub4']);
      image.add(dataImageJson['sub8']);
      image.add(dataImageJson['sub16']);
      image.add(dataImageJson['sub32']);
      image.add(dataImageJson['sub64']);
    }
    else if (algorithm == "sobel") {
      image.add(dataImageJson['absolut3']);
      image.add(dataImageJson['absolut5']);
      image.add(dataImageJson['absolut7']);
      image.add(dataImageJson['shift3']);
      image.add(dataImageJson['shift5']);
      image.add(dataImageJson['shift7']);
    }
    else if (algorithm == "laplace") {
      image.add(dataImageJson['mask3']);
      image.add(dataImageJson['mask5']);
      image.add(dataImageJson['mask7']);
    }
    else if (algorithm == "kmeans") {
      image.add(dataImageJson['kmeans1']);
      image.add(dataImageJson['kmeans2']);
      image.add(dataImageJson['kmeans3']);
      image.add(dataImageJson['kmeans4']);
    }
    else
      image.add(dataImageJson['image']);
  }
  print("fim upload");
  return image;
}


