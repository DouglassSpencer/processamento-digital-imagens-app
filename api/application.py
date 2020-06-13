from flask import Flask,request,Response,jsonify
import base64
import cv2
import numpy as np
import os
import functions as fc

app = Flask(__name__)

@app.route('/api')
def test():
    d={}
    d['Query'] = str(request.args['Query'])
    return jsonify(d)

    
@app.route('/home', methods=['POST'])
def home():
    if request.method == 'POST':
        data = request.files['file']
        return jsonify({"status":"ok"})


@app.route('/api/image', methods=['POST'])
def image():
    #print(request.get_json())
    filename = request.get_json()['filename'] #nome do arquivo original
    data = request.get_json()['image'] #recebe uma string
    data = data.encode('utf-8') #transforma em binario usando utf-8 
    algorithm =  request.get_json()['algorithm'] #algoritmo a ser realizado

    print("Recebido: ")
    print(" - Arquivo: ", filename)
    print(" - Algoritmo: ", algorithm)

    with open(filename, "wb") as fh:
        fh.write(base64.decodebytes(data)) #decodifica o codigo binario

    image = cv2.imread(filename)
    #image = cv2.imread('a.jpg')

################################################################################
    if algorithm == 'histogram':
        fc.viewHistograms(image)

        with open('histogram.png', 'rb') as binary_file:
          hist_img_binary = binary_file.read()
          hist_base64Image = base64.b64encode(hist_img_binary)

        with open('red.png', 'rb') as binary_file2:
          red_img_binary = binary_file2.read()
          red_base64Image = base64.b64encode(red_img_binary)

        with open('green.png', 'rb') as binary_file3:
          gre_img_binary = binary_file3.read()
          gre_base64Image = base64.b64encode(gre_img_binary)

        with open('blue.png', 'rb') as binary_file4:
          blu_img_binary = binary_file4.read()
          blu_base64Image = base64.b64encode(blu_img_binary)

        with open('gray.png', 'rb') as binary_file5:
          gra_img_binary = binary_file5.read()
          gra_base64Image = base64.b64encode(gra_img_binary)

        #remove a imagem temporaria
        try:
          os.remove(filename)
          os.remove('histogram.png')
          os.remove('red.png')
          os.remove('green.png')
          os.remove('blue.png')
          os.remove('gray.png') 
        except:
          print('fail remove')
        finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'histogram':hist_base64Image.decode('utf-8'),
                         'red':red_base64Image.decode('utf-8'),
                         'green':gre_base64Image.decode('utf-8'),
                         'blue':blu_base64Image.decode('utf-8'),
                         'gray':gra_base64Image.decode('utf-8')})

###############################################################################

    if algorithm == 'bin':
        image64 = fc.binarizar(image,64)
        image128 = fc.binarizar(image,128)
        image200 = fc.binarizar(image,200)


        cv2.imwrite('temp_img1.jpg', image64)
        cv2.imwrite('temp_img2.jpg', image128)
        cv2.imwrite('temp_img3.jpg', image200)

        with open('temp_img1.jpg', 'rb') as binary_file:
          bin64_binary = binary_file.read()
          bin64_base64Image = base64.b64encode(bin64_binary)

        with open('temp_img2.jpg', 'rb') as binary_file2:
          bin128_binary = binary_file2.read()
          bin128_base64Image = base64.b64encode(bin128_binary)

        with open('temp_img3.jpg', 'rb') as binary_file3:
          bin200_binary = binary_file3.read()
          bin200_base64Image = base64.b64encode(bin200_binary)

        try:
          os.remove(filename)
        except:
          print('fail remove2')
        return jsonify({'bin64':bin64_base64Image.decode('utf-8'),
                         'bin128':bin128_base64Image.decode('utf-8'),
                         'bin200':bin200_base64Image.decode('utf-8')})
        
###############################################################################

    if algorithm == 'negative':
        imageOut = fc.negative(image)
        try:
          os.remove(filename)
        except:
          print('fail remove2')
        return jsonify(fc.preparaJson(imageOut))
    
###############################################################################

    if algorithm == 'subsampling':
        fc.subamostragem(image)
        with open('sub4.png', 'rb') as binary_file:
            sub4_binary = binary_file.read()
            sub4_base64Image = base64.b64encode(sub4_binary)

        with open('sub8.png', 'rb') as binary_file2:
          sub8_binary = binary_file2.read()
          sub8_base64Image = base64.b64encode(sub8_binary)

        with open('sub16.png', 'rb') as binary_file3:
          sub16_binary = binary_file3.read()
          sub16_base64Image = base64.b64encode(sub16_binary)

        with open('sub32.png', 'rb') as binary_file4:
          sub32_binary = binary_file4.read()
          sub32_base64Image = base64.b64encode(sub32_binary)

        with open('sub64.png', 'rb') as binary_file5:
          sub64_binary = binary_file5.read()
          sub64_base64Image = base64.b64encode(sub64_binary)

        #remove a imagem temporaria
        try:
          os.remove(filename)
          os.remove('sub4.png')
          os.remove('sub8.png')
          os.remove('sub16.png')
          os.remove('sub32.png')
          os.remove('sub64.png')

        except:
          print('fail remove')
        finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'sub4':sub4_base64Image.decode('utf-8'),
                        'sub8':sub8_base64Image.decode('utf-8'),
                        'sub16':sub16_base64Image.decode('utf-8'),
                        'sub32':sub32_base64Image.decode('utf-8'),
                        'sub64':sub64_base64Image.decode('utf-8')})

###############################################################################
###############################################################################
        
        
    if algorithm == 'hough':
        imageCircles1 = fc.houghCirculos(image,1,50);
        imageCircles2 = fc.houghCirculos(image,1,150);
        imageCircles3 = fc.houghCirculos(image,1,250);
        imageLines1 = fc.houghLinhas(image,80);
        imageLines2 = fc.houghLinhas(image,115);
        imageLines3 = fc.houghLinhas(image,150);

        #escreve uma imagem temporaria com os resultados (nparray -> jpg)
        cv2.imwrite('temp_img1.jpg', imageCircles1)
        cv2.imwrite('temp_img2.jpg', imageCircles2)
        cv2.imwrite('temp_img3.jpg', imageCircles3)
        cv2.imwrite('temp_img4.jpg', imageLines1)
        cv2.imwrite('temp_img5.jpg', imageLines2)
        cv2.imwrite('temp_img6.jpg', imageLines3)
 
        #lê a imagem e a codifica para binário (jpg -> binario -> base64)
        with open('temp_img1.jpg', 'rb') as binary_file:
          img_binary1 = binary_file.read()
          circles1 = base64.b64encode(img_binary1)
        with open('temp_img2.jpg', 'rb') as binary_file:
          img_binary2 = binary_file.read()
          circles2 = base64.b64encode(img_binary2)
        with open('temp_img3.jpg', 'rb') as binary_file:
          img_binary3 = binary_file.read()
          circles3 = base64.b64encode(img_binary3)
        with open('temp_img4.jpg', 'rb') as binary_file:
          img_binary4 = binary_file.read()
          lines1 = base64.b64encode(img_binary4)
        with open('temp_img5.jpg', 'rb') as binary_file:
          img_binary5 = binary_file.read()
          lines2 = base64.b64encode(img_binary5)
        with open('temp_img6.jpg', 'rb') as binary_file:
          img_binary6 = binary_file.read()
          lines3 = base64.b64encode(img_binary6)
        
        #remove a imagem temporaria
        try:
          os.remove(filename)
          os.remove('temp_img1.jpg')
          os.remove('temp_img2.jpg')
          os.remove('temp_img3.jpg')
          os.remove('temp_img4.jpg')
          os.remove('temp_img5.jpg')
          os.remove('temp_img6.jpg')
        except:
          print('fail remove')
        finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'lines1':lines1.decode('utf-8'),
                          'lines2':lines2.decode('utf-8'),
                          'lines3':lines3.decode('utf-8'),
                          'circles1':circles1.decode('utf-8'),
                          'circles2':circles2.decode('utf-8'),
                          'circles3':circles3.decode('utf-8'),})

################################################################################

    if algorithm == 'sobel':
        fc.sobel(image);

        #lê a imagem e a codifica para binário (jpg -> binario -> base64)
        with open('absolut_3.jpg', 'rb') as binary_file:
          img_binary1 = binary_file.read()
          absolut_3 = base64.b64encode(img_binary1)
        with open('shift_3.jpg', 'rb') as binary_file:
          img_binary2 = binary_file.read()
          shift_3 = base64.b64encode(img_binary2)
          
        with open('absolut_5.jpg', 'rb') as binary_file:
          img_binary3 = binary_file.read()
          absolut_5 = base64.b64encode(img_binary3)
        with open('shift_5.jpg', 'rb') as binary_file:
          img_binary4 = binary_file.read()
          shift_5 = base64.b64encode(img_binary4)
          
        with open('absolut_7.jpg', 'rb') as binary_file:
          img_binary5 = binary_file.read()
          absolut_7 = base64.b64encode(img_binary5)
          
        with open('shift_7.jpg', 'rb') as binary_file:
          img_binary6 = binary_file.read()
          shift_7 = base64.b64encode(img_binary6)
        
        #remove a imagem temporaria
        try:
          os.remove(filename)
          os.remove('absolut_3.jpg')
          os.remove('absolut_5.jpg')
          os.remove('absolut_7.jpg')
          os.remove('shift_3.jpg')
          os.remove('shift_5.jpg')
          os.remove('shift_7.jpg')
        except:
          print('fail remove')
        finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'absolut3':absolut_3.decode('utf-8'),
                          'shift3':absolut_5.decode('utf-8'),
                          'absolut5':absolut_7.decode('utf-8'),
                          'shift5':shift_3.decode('utf-8'),
                          'absolut7':shift_5.decode('utf-8'),
                          'shift7':shift_7.decode('utf-8'),})

################################################################################    

    if algorithm == 'laplace':

        cv2.imwrite('mask3.jpg', fc.laplaciano(image,3))
        cv2.imwrite('mask5.jpg', fc.laplaciano(image,5))
        cv2.imwrite('mask7.jpg', fc.laplaciano(image,7))
 
        #lê a imagem e a codifica para binário (jpg -> binario -> base64)
        with open('mask3.jpg', 'rb') as binary_file:
          img_binary1 = binary_file.read()
          mask3Image = base64.b64encode(img_binary1)
        with open('mask5.jpg', 'rb') as binary_file:
          img_binary2 = binary_file.read()
          mask5Image = base64.b64encode(img_binary2)
        with open('mask7.jpg', 'rb') as binary_file:
          img_binary3 = binary_file.read()
          mask7Image = base64.b64encode(img_binary3)
        
        #remove a imagem temporaria
        try:
          os.remove(filename)
          os.remove('mask3.jpg')
          os.remove('mask5.jpg')
          os.remove('mask7.jpg')
        except:
          print('fail remove')
        finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'mask3':mask3Image.decode('utf-8'),
                          'mask5':mask5Image.decode('utf-8'),
                          'mask7':mask7Image.decode('utf-8')})
        
################################################################################
        
    if algorithm == 'kmeans':
         kmeans1 = fc.kmeans(image,False,3);
         kmeans2 = fc.kmeans(image,False,5);
         kmeans3 = fc.kmeans(image,False,7);
         kmeans4 = fc.kmeans(image,False,10);
         
         cv2.imwrite('temp_img1.jpg', kmeans1)
         cv2.imwrite('temp_img2.jpg', kmeans2)
         cv2.imwrite('temp_img3.jpg', kmeans3)
         cv2.imwrite('temp_img4.jpg', kmeans4)

         with open('temp_img1.jpg', 'rb') as binary_file:
            img_binary1 = binary_file.read()
            imageKmeans1 = base64.b64encode(img_binary1)
            
         with open('temp_img2.jpg', 'rb') as binary_file:
            img_binary2 = binary_file.read()
            imageKmeans2 = base64.b64encode(img_binary2)
            
         with open('temp_img3.jpg', 'rb') as binary_file:
            img_binary3 = binary_file.read()
            imageKmeans3 = base64.b64encode(img_binary3)
            
         with open('temp_img4.jpg', 'rb') as binary_file:
            img_binary4 = binary_file.read()
            imageKmeans4 = base64.b64encode(img_binary4)
          
         try:
          os.remove(filename)
          os.remove('temp_img1.jpg')
          os.remove('temp_img2.jpg')
          os.remove('temp_img3.jpg')
          os.remove('temp_img4.jpg')
         except:
          print('fail remove')
         finally:
          #decodifica de binario e passa para utf-8 (string). (binario -> string)
          return jsonify({'kmeans1':imageKmeans1.decode('utf-8'),
                          'kmeans2':imageKmeans2.decode('utf-8'),
                          'kmeans3':imageKmeans3.decode('utf-8'),
                          'kmeans4':imageKmeans4.decode('utf-8'),})





if __name__ == '__main__':
    app.run()


