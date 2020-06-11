import cv2
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
import math
import base64
import os

def viewHistograms(image):
  # se as imagens já forem cinza, a conversão gera um erro
  if image is not None:
    # imagem cinza
    if len(image.shape) == 2:
      GR = cv2.calcHist([image],[0],None,[256],[0,255])

      plt.subplot(121), plt.imshow(image, cmap='gray', vmin=0, vmax=255), plt.title('Imagem cinza')
      plt.subplot(122), plt.plot(GR, color='gray'), plt.title('Histograma da imagem cinza')

      plt.xlim([0,255])
      plt.show()

    # imagem colorida
    else:
      image1 = cv2.cvtColor(image,cv2.COLOR_BGR2RGB)
      gray = cv2.cvtColor(image,cv2.COLOR_RGB2GRAY)

      R = cv2.calcHist([image],[0],None,[256],[0,255])
      G = cv2.calcHist([image],[1],None,[256],[0,255])
      B = cv2.calcHist([image],[2],None,[256],[0,255])
      GR = cv2.calcHist([gray],[0],None,[256],[0,255])

      plt.plot(R,color='red',linewidth=0.7), plt.plot(G,color='green',linewidth=0.7), plt.plot(B,color='blue',linewidth=0.7), plt.plot(GR,color='gray',linewidth=0.7), plt.title('Histogramas')
      plt.savefig("histogram.png")
      plt.close()
      plt.imshow(image[:,:,0], cmap='Reds', vmin=0, vmax=255), plt.title('Componente RED')
      plt.savefig("red.png")
      plt.clf()
      plt.close()
      plt.imshow(image[:,:,1], cmap='Greens', vmin=0, vmax=255), plt.title('Componente GREEN')
      plt.savefig("green.png")
      plt.clf()
      plt.close()
      plt.imshow(image[:,:,2], cmap='Blues', vmin=0, vmax=255), plt.title('Componente BLUE')
      plt.savefig("blue.png")
      plt.clf()
      plt.close()
      plt.imshow(gray, cmap='gray', vmin=0, vmax=255), plt.title('Imagem cinza')
      plt.savefig("gray.png")
      plt.close()

def binarizar(image, limiar):
  #Binarização da imagem
  if len(image.shape) > 2:
    image2 = cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
  else:
    image2 = image

  img_bin = np.zeros(image2.shape, np.uint8)
  
  #passa a dimensão y (sao invertidos), mas aqui usa-se o x por convencao
  for x in range(img_bin.shape[0]): 
    for y in range(img_bin.shape[1]):
      #print(img_gray[x][y])
      if image2[x][y] <= limiar:
        img_bin[x][y] = 0 #ausência de cor é preto (baixa cor)
      else:
        img_bin[x][y] = 255 #muita cor, branco

  return img_bin

def negative(image):
# negativo de imagem
# recebe uma imagem (BGR ou gray), imprime o negativo da imagem
# e retorna uma imagem (original ou negativa)


  '''
    Input: imagem BGR
    Output: None
  '''

  if len(image.shape) > 2:

    #separa as componentes RGB  
    B, G, R = cv2.split(image)
  
    #inverte cada componente
    B_neg = 255-B
    G_neg = 255-G
    R_neg = 255-R

    #merge das componentes
    im_neg = cv2.merge([B_neg, G_neg, R_neg])
  
    # converte para escala de cinza
    im_neg_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # inverte 
    im_neg_gray = 255 - im_neg_gray

    # exibe as imagens
    #lab1.viewImages([im_neg, im_neg_gray], ['Imagem Negativa', 'Imagem negativa Escala de Cinza'])
    #verificar esse retorno, pois há 2 possiveis imagens
  else:
    im_neg = 255 - image # inverte

  return im_neg

def preparaJson(imageOut):
  #escreve uma imagem temporaria com os resultados (nparray -> jpg)
  cv2.imwrite('temp_img.jpg', imageOut)

  #lê a imagem e a codifica para binário (jpg -> binario -> base64)
  with open('temp_img.jpg', 'rb') as binary_file:
    img_binary = binary_file.read()
    base64Image = base64.b64encode(img_binary)
  
  #remove a imagem temporaria
  try:
    os.remove('temp_img.jpg') 
  except:
    print('fail remove')
  finally:
    #decodifica de binario e passa para utf-8 (string). (binario -> string)
    return {'image':base64Image.decode('utf-8')}

def subamostragem(image):
  for amostra in [4,8,16,32,64]:
    plt.figure()
  
    if len(image.shape) > 2:
      image2=cv2.cvtColor(image,cv2.COLOR_BGR2RGB) #a imagem vem em formato BGR
      new_shape = (int((image2.shape[0] + 0.5)/amostra), int((image2.shape[1] + 0.5)/amostra), image2.shape[2]) #divide a imagem em 1/4
      img_sub = np.zeros((new_shape[0],new_shape[1],new_shape[2]), np.uint8)
      for x in range(new_shape[0]):
        for y in range(new_shape[1]):
          for z in range(new_shape[2]):
            img_sub[x][y][z] = image2[(x*amostra)][(y*amostra)][z]
      plt.imshow(img_sub)

    else:
      new_shape = (int((image.shape[0] + 0.5)/amostra), int((image.shape[1] + 0.5)/amostra)) #divide a imagem em 1/4
      #print("new shape: ", new_shape)
      img_sub = np.zeros((new_shape[0],new_shape[1]), np.uint8)
      #print(img_bin.shape)
      for x in range(new_shape[0]):
        for y in range(new_shape[1]):
          img_sub[x][y] =  int(image[(x*amostra)][(y*amostra)])
      plt.imshow(img_sub, cmap='gray')
    
    plt.title(('Subamostragem em %d, dimensões: %dx%d \n dimensões originais: %dx%d'%(amostra, new_shape[0], new_shape[1], image.shape[0], image.shape[1])))
    filename='sub'+str(amostra)+'.png'
    plt.savefig(filename)
    plt.close()

def houghLinhas (image,threshold):

  #################
  #Entradas
  # - Imagem
  # - Limiar
  #################
  
  img = np.copy(image)
  
  #Detecção das bordas usando detector Canny
  edges = cv2.Canny(img,50,200,apertureSize = 3)

  #Aplicação da transformada
  #  - Saída do detector de bordas
  #  - Parametro rô (rho)
  #  - Parametro teta (theta)
  #  - Limiar
  lines = cv2.HoughLines(edges,1,np.pi/180,threshold)

  #Desenhando linhas encontradas
  for i in range(0, len(lines)):
    rho = lines[i][0][0]
    theta = lines[i][0][1]
    a = math.cos(theta)
    b = math.sin(theta)
    x0 = a * rho
    y0 = b * rho
    pt1 = (int(x0 + 1000*(-b)), int(y0 + 1000*(a)))
    pt2 = (int(x0 - 1000*(-b)), int(y0 - 1000*(a)))
    cv2.line(img, pt1, pt2, (0,0,255), 2, cv2.LINE_AA)

  return img


def houghCirculos(image,minRadius,maxRadius):

  #################
  #Entradas
  # - Imagem
  # - Raio minimo
  # - Raio maximo
  #################
  
  output = np.copy(image)

  #escala de cinza
  gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

  #suavizacao para reduzir ruido e
  #diminuir deteccao de ciruculos falsos
  gray = cv2.medianBlur(gray, 5)    
    
  rows = gray.shape[0]

  #Aplicação da transformada
  #  - Imagem em tonsde cinza
  #  - Metodo de deteccao
  #  - 
  #  - Distancia minima entre os centros
  #  - Limiar superior
  #  - Limiar para detecacao de centro
  #  - Raio minimo
  #  - Raio maximo
  circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1, rows / 8,
                               param1=100, param2=30,
                               minRadius=minRadius,
                               maxRadius=maxRadius)

  #Desenhando circulos encontrados
  if circles is not None:

    circles = np.uint16(np.around(circles))

    for i in circles[0, :]:
      center = (i[0], i[1])
      # circle center
      cv2.circle(output, center, 1, (0, 100, 100), 3)
      # circle outline
      radius = i[2]
      cv2.circle(output, center, radius, (255, 0, 255), 3)
  return output


def sobel(img): 
  

  # converte a imagem para cinza, se ela ja não for
  if len(img.shape) > 2:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
  else:
    gray = img

  # aplica o filtro sobel nas direcoes x e y
  grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=3)
  grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=3)  
  
  # o resultado de cada mascara do filtro possui valores float
  # pega o valor absoluto dos pixels resultantes do gradiente na direcao x e y
  abs_grad_x = cv2.convertScaleAbs(grad_x)
  abs_grad_y = cv2.convertScaleAbs(grad_y)
  
  # cv2.addWeighted(src1, alpha, src2, beta, gamma) -> src1 * alpha + src2 * beta + gamma
  # faz a soma dos grdientes x e y
  grad = cv2.addWeighted(grad_x, 0.5, grad_y, 0.5, 0) # gradiente com valores float. Os valores são deslocados para serem 8b
  grad_trunc = cv2.addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0) # gradiente com valores absolutos

  cv2.imwrite("absolut_3.jpg",grad_trunc)
  cv2.imwrite("shift_3.jpg",grad)

  # aplica o filtro sobel nas direcoes x e y
  grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=5)
  grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=5)  
  
  # o resultado de cada mascara do filtro possui valores float
  # pega o valor absoluto dos pixels resultantes do gradiente na direcao x e y
  abs_grad_x = cv2.convertScaleAbs(grad_x)
  abs_grad_y = cv2.convertScaleAbs(grad_y)
  
  # cv2.addWeighted(src1, alpha, src2, beta, gamma) -> src1 * alpha + src2 * beta + gamma
  # faz a soma dos grdientes x e y
  grad = cv2.addWeighted(grad_x, 0.5, grad_y, 0.5, 0) # gradiente com valores float. Os valores são deslocados para serem 8b
  grad_trunc = cv2.addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0) # gradiente com valores absolutos

  cv2.imwrite("absolut_5.jpg",grad_trunc)
  cv2.imwrite("shift_5.jpg",grad)

  # aplica o filtro sobel nas direcoes x e y
  grad_x = cv2.Sobel(gray, cv2.CV_64F, 1, 0, ksize=7)
  grad_y = cv2.Sobel(gray, cv2.CV_64F, 0, 1, ksize=7)  
  
  # o resultado de cada mascara do filtro possui valores float
  # pega o valor absoluto dos pixels resultantes do gradiente na direcao x e y
  abs_grad_x = cv2.convertScaleAbs(grad_x)
  abs_grad_y = cv2.convertScaleAbs(grad_y)
  
  # cv2.addWeighted(src1, alpha, src2, beta, gamma) -> src1 * alpha + src2 * beta + gamma
  # faz a soma dos grdientes x e y
  grad = cv2.addWeighted(grad_x, 0.5, grad_y, 0.5, 0) # gradiente com valores float. Os valores são deslocados para serem 8b
  grad_trunc = cv2.addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0) # gradiente com valores absolutos

  cv2.imwrite("absolut_7.jpg",grad_trunc)
  cv2.imwrite("shift_7.jpg",grad)


def laplaciano(img,kernel):

  
  #se imagem for colorida, converte para escala gray
  if len(img.shape) > 2:
    imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

  #aplica o filtro
  #dimensoes da mascara
  resultado = cv2.Laplacian(imgGray, cv2.CV_64F, ksize=kernel)
  resultado = np.uint8(np.absolute(resultado))
  return resultado


def kmeans(image,gray,K):

  #######################
  #Entradas
  # - Imagem
  # - Aplicar tons de cinza (sim ou não)
  # - Numero de clusters
  #######################


  Z = image.reshape((-1,3))

  #Conversao para float32
  Z = np.float32(Z)
  
  #Definicao do criterio
  # - Tupla com:
  #   - tipo
  #   .   - TERM_CRITERIA_EPS
  #   .     pare se a precisão for atingida.
  #   .
  #   .   - TERM_CRITERIA_MAX_ITER
  #   .     pare se número maximo de iterações for atingido.
  #   .
  #   - maximo de iteracaoes
  #   - precisão
  criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)

  #Aplicacao do Kmeans
  # - Entrada
  # - Numero de clusters
  # - Melhores labels
  # - Criterio
  # - Iteracoes
  # - Definicao dos centros iniciais
  #
  # Output
  # - distance: soma da distância ao quadrado de cada ponto
  #             até seus centros correspondentes.
  # - label: vetor de labels
  # - center: vetor de centros dos clusters
  distance,label,center=cv2.kmeans(Z,K,None,criteria,10,cv2.KMEANS_RANDOM_CENTERS)
  
  #Conversao para uint8 novamente
  center = np.uint8(center)

  #Obtendo imagem de saida
  output = center[label.flatten()].reshape((image.shape))

  return output
