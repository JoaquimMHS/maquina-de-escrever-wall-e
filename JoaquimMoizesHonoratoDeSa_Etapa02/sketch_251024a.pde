// Wall-E Máquina de Escrever - Versão 2D Detalhada
// Projeto de Fundamentos de Computação Gráfica
import ddf.minim.*;
Minim minim;
AudioPlayer somTecla;


// --- Paleta de Cores ---
color amarelo = #ffc800;        // Amarelo Wall-E
color azulLente = #0C2839;      // "Iris" do olho
color vermelho = #D93030;       // Circulo do "E" em wall-e
color cinza = #6b6d6e;          // Painel botões
color cinza2 = #8F939D;         // Pescoço, Binóculos, Borda Olho, Braços e detalhes da maquina
color cinzaMao = #A2A6B2;       // Cinza mais claro da mão
color cinzaClaro = #DCDCDC;     // Teclas do teclado
color cinzaMedio = #4d4e50;     // Esteiras, rolo da maquina,
color cinzaEscuro = #272827;

boolean botaoOnLigado = false;
boolean botaoDigLigado = false;
boolean botaoTextLigado = false;
boolean botoesDigTeclado = false;

void setup() {
  size(800, 800);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  minim = new Minim(this);
  somTecla = minim.loadFile("ligando_wallE.mp3");
}

void draw() {
  background(235, 227, 209);
  translate(width/2, height/2); // Move a origem (0,0) para o centro

  // Rolo da Máquina e Papel (Mais ao fundo)
  desenhaPapel();

  // Corpo Principal
  desenhaCorpo();

  desenhaEsteira(-235, 285); // Esteira Esquerda
  desenhaEsteira(235, 285);  // Esteira Direita

  // Braços
  desenhaBracos();

  // Cabeça / Olhos
  desenhaCabeca();

  // Teclado
  desenhaTeclado();
}

void desenhaCorpo() {
  pushMatrix();
  // Caixa principal
  noStroke();
  fill(amarelo);
  rect(0, 100, 320, 260); // (x, y, larg, alt, arredondamento)

  // Painel botões
  fill(cinzaMedio);
  rect(0, 10, 320, 80);

  // Barra maquina
  fill(cinzaEscuro);
  rect(0, -28, 330, 10, 5);

  // Logo "WALL-E"
  stroke(vermelho);
  strokeWeight(0);
  fill(cinzaEscuro);
  textSize(40);
  text("WALL", -15, 140);
  fill(vermelho);
  ellipse(70, 140, 40, 40);
  fill(255);
  text("E", 70, 139);
  fill(cinzaEscuro);
  ellipse(40, 140, 10, 10);
  
  if (botaoOnLigado == true) {
    desenhaBocaTriste();
  } else {
    desenhaBocaNeutra();
  }


  popMatrix();
}

void desenhaBocaNeutra() {
  pushMatrix();
  // Medidor de carga (LEDs)
  stroke(0);
  strokeWeight(1);
  fill(cinzaEscuro);
  rect(0, 12, 120, 60, 0);

  strokeWeight(2);
  stroke(0,255,0);
  fill(0);
  rect(0, 15, 90, 5, 10);

  popMatrix();
}

void desenhaBocaTriste() {
  pushMatrix();
  stroke(0);
  strokeWeight(1);
  fill(cinzaEscuro);
  rect(0, 12, 120, 60, 0);

  //noStroke();
  strokeWeight(2);
  stroke(0,255,0);
  fill(0);
  rect(0, 10, 55, 5);

  rect(30, 15, 5, 5);
  rect(35, 20, 5, 5);
  rect(40, 28, 5, 10);

  rect(-30, 15, 5, 5);
  rect(-35, 20, 5, 5);
  rect(-40, 28, 5, 10);

  popMatrix();
}


void desenhaEsteira(float x, float y) {
  pushMatrix();
  translate(x, y);

  fill(cinzaMedio);
  noStroke();

  int numDentes = 5;

  for (int i = 0; i < numDentes; i++) {
    y = map(i, 0, numDentes - 1, -155, 0);
    rect(0, y, 129, 35, 4);
  }

  popMatrix();
}


void desenhaCabeca() {
  pushMatrix();

  // Pescoço
  fill(cinza2);
  rect(0, -116, 25, 95, 0);
  rect(0, -45, 40, 25, 0);
  rect(0, -60, 25, 10, 0);

  // Olhos (Binóculos)
  strokeWeight(4);
  stroke(amarelo);
  fill(cinza2);
  rect(-75, -150, 135, 100, 40, 0, 40, 25); // Binóculos esquerda
  rect(75, -150, 135, 100, 0, 40, 25, 40); // Binóculos direita

  if (botaoOnLigado == true) {
    desenhaOlho(-60, -150, true); 
    desenhaOlho(60, -150, false);
  } else {
    desenhaOlhoFechado(-60, -150, true);
    desenhaOlhoFechado(60, -150, false);
  }

  popMatrix();
}


void desenhaOlho(float x, float y, boolean antena) {
  pushMatrix();
  translate(x, y);

  noFill();
  strokeWeight(5);
  stroke(cinza2);
  if (antena) {
    //Antena esquerda
    bezier(-95, -40, -86, -71, -85, -65, 0, -81);
    ellipse(-95, -40, 10, 10);
  } else {
    // Antena direita
    bezier(95, -40, 86, -71, 85, -65, 0, -81);
    ellipse(95, -40, 10, 10);
  }

  // Lente (Aro)
  stroke(117, 117, 117);
  strokeWeight(0);
  fill(117, 117, 117);
  ellipse(0, 0, 70, 70); // Aro preto

  // Lente (Íris)
  fill(azulLente);
  ellipse(0, 0, 60, 60);

  // Reflexo da luz
  fill(40, 100, 135);
  noStroke();
  ellipse(-15, -10, 18, 18);
  ellipse(-25, -2, 6, 6);

  popMatrix();
}

void desenhaOlhoFechado(float x, float y, boolean antena) {
  pushMatrix();
  translate(x, y);

  noFill();
  strokeWeight(5);
  stroke(cinza2);
  if (antena) {
    //Antena esquerda
    bezier(-95, -40, -86, -71, -85, -65, 0, -81);
    ellipse(-95, -40, 10, 10);
  } else {
    // Antena direita
    bezier(95, -40, 86, -71, 85, -65, 0, -81);
    ellipse(95, -40, 10, 10);
  }

  // Lente (Aro)
  strokeWeight(0);
  fill(cinzaEscuro);
  rect(0, 0, 71, 6, 5);

  popMatrix();
}

void desenhaPapel() {
  pushMatrix();

  // Papel
  stroke(cinzaEscuro);
  strokeWeight(2);
  fill(255);
  rect(0, -196, 245, 200, 5);

  // Detalhe Maquina Direita
  noStroke();
  fill(cinzaMedio);
  rect(130, -52, 25, 40);
  rect(145, -52, 10, 15);

  fill(cinza2);
  rect(155, -56, 12, 50);
  rect(152, -77, 15, 10);
  rect(165, -53, 20, 25);

  fill(cinzaMedio);
  rect(187, -52, 25, 50, 5);

  // Detalhe Maquina Esquerda
  fill(cinzaMedio);
  rect(-130, -52, 25, 40);
  rect(-145, -52, -10, 15);

  fill(cinza2);
  rect(-155, -56, -12, 50);
  rect(-152, -77, -15, 10);
  rect(-170, -56, 20, 30);

  rect(-170, -69, 18, 0, 0, 0, 0, -35);
  rect(-187, -65, 35, 12, 0, 0, 0, 0);
  rect(-215, -70, 35, 35, 5);

  // --- Rolo da maquina
  strokeWeight(4);
  stroke(cinzaEscuro);
  fill(cinzaMedio);
  rect(0, -110, 308, 47, 10);

  popMatrix();
}

void desenhaTeclado() {
  pushMatrix();
  translate(0, 260);
  noStroke();

  float raio = 20.0;
  float x_base = 190.0 - raio;
  float y_base = 42.0;
  float x_lateral = 185.8;
  float y_lateral = 22.4;

  fill(cinza);
  beginShape();
  
  vertex(-140, -75);
  vertex(-140, -95);
  vertex(-165, -95);
  vertex(-165, -75);
  vertex(-x_lateral, y_lateral); 
  quadraticVertex(-190, 42, -x_base, y_base); 
  vertex(x_base, y_base);
  quadraticVertex(190, 42, x_lateral, y_lateral);
  vertex(165, -75); 
  vertex(165, -95);
  vertex(140, -95);
  vertex(140, -75);
  endShape(CLOSE);

  fill(cinzaEscuro);
 
  float raio_interno = 10.0; 
  float x_base_int = 165.0 - raio_interno; 
  float y_base_int = 23.0;
  float x_lat_int = 163.0;
  float y_lat_int = 13.2;

  beginShape();
  vertex(-145, -75);
  vertex(145, -75);
  vertex(x_lat_int, y_lat_int);
  quadraticVertex(165, 23, x_base_int, y_base_int); 
  vertex(-x_base_int, y_base_int);
  quadraticVertex(-165, 23, -x_lat_int, y_lat_int);
  endShape(CLOSE);

  desenhaBotoes();

  popMatrix();
}

void desenhaBotoes() {
  pushMatrix();
  noStroke();

  textSize(15);
  String[] linha1 = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"};
  String[] linha2 = {"F", "G", "H", "J", "K", "C", "V", "B", "N", "M"};

  float diametroTecla = 25;
  float y_linha1 = -50;
  float y_linha2 = -20;
  float x_inicio = -135;
  float x_fim = 135;

  if (botaoDigLigado) {
    desenhaLinhaTeclas(linha1, y_linha1, x_inicio, x_fim, diametroTecla);
  }
  
  if (botaoTextLigado) {
    desenhaLinhaTeclas(linha2, y_linha2, x_inicio, x_fim, diametroTecla);
  }
 


  textSize(15);
  fill(0);
  textAlign(CENTER, CENTER);

  if (!botaoOnLigado) {
    fill(cinzaClaro);
    ellipse(-86, 8, 42, 23);
    fill(0);
    text("OFF", -86, 8);
  } else {
    fill(0, 255, 0);
    ellipse(-86, 8, 42, 23);
    fill(0);
    text("ON", -86, 8);
  }

  if (!botaoDigLigado) {
    fill(cinzaClaro);
    ellipse(0, 8, 42, 23);
    fill(0);
    text("DIG", 0, 8);
  } else {
    fill(100, 0, 0);
    ellipse(0, 8, 42, 23);
    fill(0);
    text("DIG", 0, 8);
  }
  if (!botaoTextLigado) {
    fill(cinzaClaro);
    ellipse(86, 8, 42, 23);
    fill(0);
    text("TEXT", 87, 8);
  } else {
    fill(0, 0, 255);
    ellipse(86, 8, 42, 23);
    fill(0);
    text("TEXT", 87, 8);
  }
  
  if(botoesDigTeclado){
    stroke(0);
    strokeWeight(2);
    desenhaLinhaTeclas(linha2, y_linha2, x_inicio, x_fim, diametroTecla);
  }
    

  noStroke();
  fill(0, 30);
  rect(0, 45, 344, 8, 20);

  popMatrix();
}

void desenhaLinhaTeclas(String[] teclas, float y, float x_inicio, float x_fim, float diametro) {

  int numTeclas = teclas.length;

  for (int i = 0; i < numTeclas; i++) {
    float x = map(i, 0, numTeclas - 1, x_inicio, x_fim);

    fill(cinzaClaro);
    ellipse(x, y, diametro, diametro);

    fill(0);
    text(teclas[i], x, y);
  }
}

void keyPressed() {

  if (key == 'o' || key == 'O') {
    botaoOnLigado = !botaoOnLigado;
    if (somTecla != null) {
      somTecla.rewind();
      somTecla.play();
    }
  }

  if (key == 'd' || key == 'D') {
    botaoDigLigado = !botaoDigLigado;
  }

  if (key == 't' || key == 'T') {
    botaoTextLigado = !botaoTextLigado;
  }
  
  
  if(key == 'f' || key == 'F'){
    botoesDigTeclado = !botoesDigTeclado;
  }
    
}


void desenhaBracos() {
  pushMatrix();
  // Braço direito
  fill(cinza2);
  rect(195, 30, 30, 50);
  rect(180, -10, 48, 15);
  rect(180, 70, 48, 15);
  rect(145, 5, 55, 45);
  rect(145, 55, 55, 45);
  fill(cinzaMao);
  quad(80, -5, 80, 28, 115, 28, 115, -18);
  quad(80, 65, 80, 33, 115, 33, 115, 78);
  // Braço esquerdo
  fill(cinza2);
  rect(-195, 30, 30, 50);
  rect(-180, -10, 48, 15);
  rect(-180, 70, 48, 15);
  rect(-145, 5, 55, 45);
  rect(-145, 55, 55, 45);
  fill(cinzaMao);
  quad(-80, -5, -80, 28, -115, 28, -115, -18);
  quad(-80, 65, -80, 33, -115, 33, -115, 78);

  popMatrix();
}
