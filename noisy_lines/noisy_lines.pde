import SimpleOpenNI.*;

int numberLines = 30;
int numberSegments = 30;
int lineSpace = 10;
float yoff = 0.0;

SimpleOpenNI context;

void setup() {
  size(1280, 500);
  background(0);
  stroke(255, 150);
//
//  context = new SimpleOpenNI(this);
//
//  context.setMirror(false);
//  context.enableDepth();
}

void draw() {
  background(0);

  for(int i=0; i<numberLines;i++) {
    pushMatrix();
    translate(0, i*lineSpace);
    drawLine(i);
    popMatrix();
  }
}

void drawLine(int index) {
  noFill();
  beginShape();
  float segmentXIncrement = width/numberSegments;
  float xoff = 0.0;

  for(int i=0; i<numberSegments + 3;i++) {
    float x = segmentXIncrement * i;
    int lineSpacing = lineSpace*index;
    int prevLineSpacing = lineSpace*(index-1);
    float y = map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing);

    if ((mouseY > height/2 - 50 && mouseY < height/2 + 50)
      && (mouseX > x - segmentXIncrement && mouseX < x + segmentXIncrement)
    ) {
      y = map(noise(xoff, yoff), 0, 1, height/2 - 150, height/2 + 150);
    }

    vertex(x, y);
    xoff += 0.01;
  }
  yoff += 0.0001;
  vertex(width + 10, height + 10);
  vertex(-10, height + 10);
  endShape(CLOSE);
}
