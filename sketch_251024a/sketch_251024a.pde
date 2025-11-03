// Wall-E Máquina de Escrever - Versão 2D Detalhada
// Projeto de Fundamentos de Computação Gráfica

// --- Paleta de Cores ---
color yellowWallE = #ffc800; // Amarelo principal
color grayMedium = #8C8C8C;   // Corpo da máquina
color grayLight = #DCDCDC;   // Destaques e olhos

color grayKnob = #5A5A5A;    // Botões e rolos
color blueLens = #0C2839;    // "Iris" do olho
color redDetail = #D93030;   // Detalhe do medidor de carga
color branco = #FFFFFF;
color cinza = #6b6d6e; // Painel botões
color cinza2 = #8F939D;
color cinzaMao = #A2A6B2;
color cinzaMedio = #4d4e50;
color cinzaEscuro = #272827;


void setup() {
  size(800, 800); // Tela um pouco maior para os detalhes

  // Define o modo de desenho de retângulos a partir do centro
  // Isso torna o posicionamento simétrico MUITO mais fácil.
  rectMode(CENTER);
  textAlign(CENTER, CENTER); // Alinha o texto pelo centro
}

void draw() {
  background(235, 227, 209); // Fundo quase branco

  // --- Desenha a partir do centro da tela ---
  translate(width/2, height/2 + 50); // Move a origem (0,0) para o centro
  strokeCap(ROUND); // Deixa as pontas das linhas arredondadas

  translate(0, -80);

  // Rolo da Máquina e Papel (Mais ao fundo)
  desenhaPapel();

  // Corpo Principal
  desenhaCorpo();

  // Esteiras
  desenhaEsteira(-235, 285); // Esteira Esquerda
  desenhaEsteira(235, 285);  // Esteira Direita

  // Braços / Alavancas
  desenhaBracos();

  // Cabeça / Olhos
  desenhaCabeca();

  // Teclado
  desenhaTeclado();
}

// ==========================================================
// FUNÇÕES DE DESENHO (para organizar o código)
// ==========================================================

void desenhaCorpo() {
  pushMatrix(); // Salva a coordenada (centro)

  // Caixa principal
  noStroke();
  fill(yellowWallE);
  rect(0, 100, 320, 260); // (x, y, larg, alt, arredondamento)

  // Painel botões
  fill(cinzaMedio);
  rect(0, 10, 320, 80);

  // Barra maquina
  fill(cinzaEscuro);
  rect(0, -28, 330, 10, 5);

  // Logo "WALL-E"
  stroke(redDetail);
  strokeWeight(0);
  fill(cinzaEscuro);
  textSize(40);
  text("WALL", -15, 200);
  fill(redDetail);
  ellipse(70, 200, 40, 40);
  fill(branco);
  text("E", 70, 200);
  fill(cinzaEscuro);
  ellipse(40, 200, 10, 10);

  // Medidor de carga (LEDs)
  noStroke();
  fill(cinzaEscuro);
  rect(50, 10, 40, 50, 5);
  fill(#F0E040); // Led 1
  rect(50, -5, 20, 5, 2);
  fill(#d0c02a); // Led 2
  rect(50, 5, 20, 5, 2);
  fill(#B0A020); // Led 3
  rect(50, 15, 20, 5, 2);
  fill(#908010); // Led 4 (fraco)
  rect(50, 25, 20, 5, 2);

  desenhaAltoFalante();

  desenhaBotoesPainel();

  popMatrix(); // Retorna ao centro
}


void desenhaEsteira(float x, float y) {
  pushMatrix(); // Salva a coordenada (centro)
  translate(x, y); // Move para a posição da esteira


  fill(cinzaMedio);
  noStroke();

  float denteWidth = 129;   // Mais largo que os 10 originais
  float denteHeight = 35;  // Um pouco mais alto que 10
  float cornerRadius = 4;  // Arredondamento dos cantos
  int numDentes = 5;       // 7 dentes, como na foto

  float yStart = -155; // Posição Y do primeiro dente
  float yEnd = 0;   // Posição Y do último dente

  for (int i = 0; i < numDentes; i++) {
    // Mapeia o índice 'i' (de 0 a 6) para a posição Y (de -70 a 70)
    // Isso distribui os 7 dentes perfeitamente
    y = map(i, 0, numDentes - 1, yStart, yEnd);

    // Lado esquerdo (centralizado em x = -55)
    rect(0, y, denteWidth, denteHeight, cornerRadius);
  }

  popMatrix(); // Retorna ao centro
}


void desenhaCabeca() {
  pushMatrix(); // Salva a coordenada (centro)

  // Pescoço
  fill(cinza2);
  rect(0, -105, 25, 70, 0); // Base do pescoço
  //rect(0, -90, 35, 35, 0); // Base do pescoço
  rect(0, -45, 40, 25, 0); // Base do pescoço
  rect(0, -60, 25, 10, 0); // Base do pescoço


  // --- Olhos (Binóculos) ---
  // A função desenha os dois olhos
  strokeWeight(4);
  stroke(yellowWallE);
  fill(cinza2);
  rect(-65, -150, 120, 95, 40, 0, 40, 25); // Caixa principal
  rect(65, -150, 123, 95, 0, 40, 25, 40); // Caixa principal
  DesenhaOlho(-60, -150, true); // Olho Esquerdo
  DesenhaOlho(60, -150, false); // Olho Direito

  popMatrix(); // Retorna ao centro
}


void DesenhaOlho(float x, float y, boolean antena) {
  pushMatrix();
  translate(x, y);

  noFill();
  strokeWeight(5);
  stroke(cinza2);
  if (antena) {
    //Antena direita
    bezier(-119, -257, -111, -276, -122, -268, -28, -292);
    ellipse(-119, -257, 10, 10);
  } else {
    // Antena direita
    bezier(119, -257, 111, -276, 122, -268, 28, -292);
    ellipse(119, -257, 10, 10);
  }

  // Lente (Aro)
  stroke(117, 117, 117);
  strokeWeight(0);
  fill(117, 117, 117);
  ellipse(0, 0, 70, 70); // Aro preto

  // Lente (Íris)
  fill(blueLens);
  ellipse(0, 0, 60, 60);

  // Reflexo da luz
  fill(40, 100, 135);
  noStroke();
  ellipse(-15, -10, 18, 18);
  ellipse(-25, -2, 6, 6);

  popMatrix();
}


void desenhaPapel() {
  pushMatrix();

  //--- Papel ---
  stroke(cinzaEscuro);
  strokeWeight(2);
  fill(255);
  rect(0, -196, 245, 200, 5); // O papel

  // Detalhe Maquina Direita
  noStroke();
  fill(cinzaMedio);
  rect(130, -49, 25, 35);
  rect(145, -48, 10, 15);

  fill(cinza2);
  rect(155, -50, 15, 50);
  rect(150, -70, 15, 10);
  rect(165, -50, 9, 25);

  fill(cinzaMedio);
  rect(178, -50, 20, 40, 5);

  // Detalhe Maquina Esquerda
  fill(cinzaMedio);
  rect(-130, -49, -25, 35);
  rect(-145, -48, -10, 15);

  fill(cinza2);
  rect(-155, -50, -15, 50);
  rect(-150, -70, -15, 10);
  rect(-172, -50, 20, 26);

  rect(-172, -63, 18, 0, 0, 0, 0, -30);

  rect(-190, -58, 20, 10, 0, 0, 0, 0);

  rect(-214, -60, 35, 35, 5);

  // --- Rolo (Platen) ---
  strokeWeight(4);
  stroke(cinzaEscuro);
  fill(grayKnob);
  rect(0, -110, 308, 47, 10); // Rolo central

  popMatrix();
}


void desenhaTeclado() {
  pushMatrix();
  

  popMatrix();
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

// ==========================================================
// FUNÇÃO PARA O PAINEL DE BOTÕES
// ==========================================================
void desenhaBotoesPainel() {
  pushMatrix(); // Salva o estado atual (para não afetar outros desenhos)

  // O painel cinza está centrado em (0, 2)
  // Vamos desenhar os botões com base nesse centro.
  float y_botoes = 25; // Posição Y (vertical) central
  float diametro = 22; // Diâmetro de cada botão

  // --- Botão 1 (Esquerda) ---
  strokeWeight(2);
  stroke(#3A3A3A); // Contorno escuro
  fill(grayKnob);  // Fundo do botão
  ellipse(10, y_botoes, diametro, diametro);
  // "Luz" do botão
  noStroke();
  fill(#D93030); // Vermelho (igual ao seu 'redDetail')
  ellipse(10, y_botoes, diametro * 0.5, diametro * 0.5);
  // "Brilho"
  fill(255, 100); // Branco com transparência
  ellipse(10, y_botoes - 2, 4, 4);

  // --- Botão 2 (Meio) ---
  strokeWeight(2);
  stroke(#3A3A3A);
  fill(grayKnob);
  ellipse(-20, y_botoes, diametro, diametro);
  // "Luz" do botão
  noStroke();
  fill(#F0E040); // Amarelo (igual ao seu 'Led 1')
  ellipse(-20, y_botoes, diametro * 0.5, diametro * 0.5);
  // "Brilho"
  fill(255, 100);
  ellipse(-20, y_botoes - 2, 4, 4);

  // --- Botão 3 (Direita) ---
  strokeWeight(2);
  stroke(#3A3A3A);
  fill(grayKnob);
  ellipse(-50, y_botoes, diametro, diametro);
  // "Luz" do botão
  noStroke();
  fill(#40A0F0); // Um azul
  ellipse(-50, y_botoes, diametro * 0.5, diametro * 0.5);
  // "Brilho"
  fill(255, 100);
  ellipse(-52, y_botoes - 2, 4, 4);

  popMatrix(); // Restaura o estado anterior
}

// ==========================================================
// FUNÇÃO PARA O ALTO-FALANTE (VERSÃO GRADE)
// ==========================================================
void desenhaAltoFalante() {
  pushMatrix();

  // Vamos centralizar o alto-falante no corpo principal,
  // que está centralizado em (0, 100)
  translate(0, 100);

  // --- Configurações da Grade ---
  int numColunas = 2;
  int numLinhas = 3;

  float rWidth = 20;  // Largura de cada "furo"
  float rHeight = 4; // Altura de cada "furo"
  float xEspaco = 4; // Espaçamento horizontal
  float yEspaco = 4; // Espaçamento vertical
  float cornerRadius = 5; // Arredondamento


  // --- Calcula a Posição Inicial (canto superior esquerdo) ---
  // Lembre-se que (0,0) agora é o CENTRO da grade
  // Então o X inicial é -(metade da largura total) + (metade da largura do 1º rect)
  float xStart = -48;
  float yStart = -112;

  noStroke();
  fill(cinzaEscuro); // Cor dos "furos"

  // --- Loop Duplo para desenhar a grade ---
  for (int i = 0; i < numColunas; i++) { // i = 0, 1
    for (int j = 0; j < numLinhas; j++) { // j = 0, 1, 2, 3

      // Calcula a posição X e Y para este retângulo
      float x = xStart + i * (rWidth + xEspaco);
      float y = yStart + j * (rHeight + yEspaco);

      // Desenha o retângulo arredondado
      rect(x, y, rWidth, rHeight, cornerRadius);
    }
  }

  popMatrix();
}
