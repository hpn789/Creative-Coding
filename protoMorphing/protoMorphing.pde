// Tableaux des positions des vertices des différentes formes
ArrayList<PVector> circle = new ArrayList<PVector>();
ArrayList<PVector> square = new ArrayList<PVector>();
ArrayList<PVector> triangle = new ArrayList<PVector>();
ArrayList<PVector> star = new ArrayList<PVector>();
ArrayList<PVector> losange = new ArrayList<PVector>();
ArrayList<PVector> octogone = new ArrayList<PVector>();
ArrayList<PVector> fleur = new ArrayList<PVector>();
ArrayList<Particle> arrayParticle = new ArrayList<Particle>();

int nbParticle = 8000;
// An ArrayList for a third set of vertices, the ones we will be drawing
// in the window
ArrayList<PVector> morph = new ArrayList<PVector>();

// This boolean variable will control if we are morphing to a circle or square
int state = 1;

void setup() {
  size(1280, 720);

  // Create a circle using vectors pointing from center
  for (int angle = 0; angle < 360; angle += 9) {
    // Note we are not starting from 0 in order to match the
    // path of a circle.  
    PVector v = PVector.fromAngle(radians(angle-135));
    v.mult(100);
    circle.add(v);
    // Let's fill out morph ArrayList with blank PVectors while we are at it
    morph.add(new PVector());
  }
  
  // Instancie le tableau de particule avec des coordonnées random
  for(int i = 0; i < nbParticle; i++)
  {
    arrayParticle.add(new Particle((int)random(0, 1281), (int)random(0, 721), color(255, 255, 0)));
  }
  InitGeometry();
}

void draw() {
  background(51);
  noStroke();
  
  testParticlePosition();
  drawParticle();
  drawGeometry();
}

void InitGeometry()
{
  // Triangle 
  for(int i = 0; i < 10; i++)
  {
   triangle.add(new PVector(0, -50));
   triangle.add(new PVector(50, -50));
   triangle.add(new PVector(0, 50));
   triangle.add(new PVector(-50, -50));
  }  
  
  // A square is a bunch of vertices along straight lines
  // Top of square
  for (int x = -50; x < 50; x += 10) {
    square.add(new PVector(x, -50));
  }
  // Right side
  for (int y = -50; y < 50; y += 10) {
    square.add(new PVector(50, y));
  }
  // Bottom
  for (int x = 50; x > -50; x -= 10) {
    square.add(new PVector(x, 50));
  }
  // Left side
  for (int y = 50; y > -50; y -= 10) {
    square.add(new PVector(-50, y));
  }
  
  // Losange
  for(int w = 0; w < 10; w++)
  {
    losange.add(new PVector(-50, 0));
    losange.add(new PVector(0, 70));
    losange.add(new PVector(50, 0));
    losange.add(new PVector(0, -70));
  }
  
  // Fleur
  for(int r = 0; r < 3; r++)
  {
    fleur.add(new PVector(-70, 0));
    fleur.add(new PVector(-40, 20));
    fleur.add(new PVector(-40, 50));
    fleur.add(new PVector(-15, 45));
    fleur.add(new PVector(0, 70));
    fleur.add(new PVector(15, 45));
    fleur.add(new PVector(40, 50));
    fleur.add(new PVector(40, 20));
    fleur.add(new PVector(70, 0));
    fleur.add(new PVector(40, -20));
    fleur.add(new PVector(40, -50));
    fleur.add(new PVector(15, -45));
    fleur.add(new PVector(0, -70));
    fleur.add(new PVector(-15, -45));
    fleur.add(new PVector(-40, -50));
    fleur.add(new PVector(-40, -20));
  }
    fleur.add(new PVector(-70, 0));
    fleur.add(new PVector(-40, 20));
    fleur.add(new PVector(-40, 50));
    fleur.add(new PVector(-15, 45));
    fleur.add(new PVector(0, 70));
    fleur.add(new PVector(15, 45));
    fleur.add(new PVector(40, 50));
    fleur.add(new PVector(40, 20));
  
  // Star
  for(int p = 0; p < 5; p++)
  {
    star.add(new PVector(-60, -30));
    star.add(new PVector(-15, -30));
    star.add(new PVector(0, -70));
    star.add(new PVector(15, -30));
    star.add(new PVector(60, -30));
    star.add(new PVector(25, 0));
    star.add(new PVector(40, 40));
    star.add(new PVector(0, 10));
    star.add(new PVector(-40, 40));
    star.add(new PVector(-25, 0));
  }
  
  // Octogone
  for(int l =0; l < 10; l++)
  {
    octogone.add(new PVector(-50, 0));
    octogone.add(new PVector(-40, 37));
    octogone.add(new PVector(0, 50));
    octogone.add(new PVector(40, 37));
    octogone.add(new PVector(50, 0));
    octogone.add(new PVector(40, -37));
    octogone.add(new PVector(0, -50));
    octogone.add(new PVector(-40, -37));
  }
}

void testParticlePosition()
{
  for(int s = 0; s < nbParticle; s++)
  {
    if(arrayParticle.get(s).getX() > 1280 || arrayParticle.get(s).getY() > 720)
    {
      arrayParticle.get(s).setPos((int)random(0, 1281), (int)random(0, 721));
      arrayParticle.get(s).setColor(color(random(0, 256), random(0, 256), random(0, 256)));
    }
  }
}

void drawGeometry()
{
    // We will keep how far the vertices are from their target
  float totalDistance = 0;
  
  // Look at each vertex
  for (int i = 0; i < circle.size(); i++) {
    PVector v1;
    // Are we lerping to the circle or square?
    if (state == 1) {
      v1 = circle.get(i);
    }
    else if(state == 2) {
      v1 = square.get(i);
    }
    else if(state == 3)
    {
      v1 = triangle.get(i);
    }
    else if(state == 4)
    {
      v1 = star.get(i);
    }
    else if(state == 5)
    {
      v1 = octogone.get(i);
    }
    else if(state == 6)
    {
      v1 = losange.get(i);
    }
    else
    {
      v1 = fleur.get(i);
    }
    
    // Get the vertex we will draw
    PVector v2 = morph.get(i);
    
    // Lerp to the target
    v2.lerp(v1, 0.1);
    
    // Check how far we are from target
    totalDistance += PVector.dist(v1, v2);
  }
  
  // If all the vertices are close, switch shape
  if (totalDistance < 0.1) {
    state = (int)random(1,8);
  }
  
  // Draw relative to center
  translate(width/2, height/2);
  strokeWeight(4);
  // Draw a polygon that makes up all the vertices
  beginShape();
  noFill();
  stroke(random(0,256), random(0, 256), random(0, 256));
  for (PVector v : morph) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}

void drawParticle()
{
  for(int p = 0; p < nbParticle; p++)
  {
    int random = (int)random(0, 2);
    if(random == 1)
    {
      pushMatrix();
      translate(arrayParticle.get(p).getX(), arrayParticle.get(p).getY());
      fill(51);
      ellipse(arrayParticle.get(p).getX(), arrayParticle.get(p).getY(), 20,20);
      popMatrix();
    }
  }
  
  if(mouseX < 1280 || mouseY < 720)
  {
    for( int k = 0; k < nbParticle; k++)
    {    
      int randomX = (int)random(0, 2);
      int randomY = (int)random(0, 2);
      int incrementX = 1;
      int incrementY = 1;
      
      if(randomX == 0)
      {
        incrementX = 0;
      }
  
      if(randomY == 0)
      {
        incrementY = 0;
      }
      
      arrayParticle.get(k).setPos(arrayParticle.get(k).getX() + incrementX, arrayParticle.get(k).getY() + incrementY);
    }
  }
  else
  {
    for( int k = 0; k < nbParticle; k++)
    { 
      if(arrayParticle.get(k).getX() < mouseX)
      {
        arrayParticle.get(k).setPos(arrayParticle.get(k).getX() + 1, arrayParticle.get(k).getY());
      }
      else
      {
        arrayParticle.get(k).setPos(arrayParticle.get(k).getX() - 1, arrayParticle.get(k).getY());
      }
      if(arrayParticle.get(k).getY() < mouseY)
      {
        arrayParticle.get(k).setPos(arrayParticle.get(k).getX(), arrayParticle.get(k).getY() + 1);
      }
      else
      {
        arrayParticle.get(k).setPos(arrayParticle.get(k).getX(), arrayParticle.get(k).getY() - 1);
      }
    }
  }
  
  for(int h = 0; h < nbParticle; h++)
  {
      pushMatrix();
      translate(arrayParticle.get(h).getX(), arrayParticle.get(h).getY());
      colorMode(RGB);
      fill(arrayParticle.get(h).getColor());
      ellipse(arrayParticle.get(h).getX(), arrayParticle.get(h).getY(), 3, 3);
      popMatrix();
  }
}

class Particle
{
  int posX = 0;
  int posY = 0;
  color c;
  
  Particle(int x, int y, color c)
  {
    this.posX = x;
    this.posY = y;
    this.c = c;
  }
  
  int getX()
  {
    return this.posX;
  }
    
  int getY()
  {
    return this.posY;
  }
  
  color getColor()
  {
    return this.c;
  }
  
  void setColor(color c)
  {
    this.c = c;
  }
  
  void setPos(int x, int y)
  {
    this.posX = x;
    this.posY = y;
  }
}