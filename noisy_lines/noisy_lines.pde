import SimpleOpenNI.*;

int numberLines = 30;
int numberSegments = 30;
float yoff = 0.0;

void setup() {
  frameRate(10);
  size(1280, 500);
  background(0);
  stroke(255, 150);
  smooth();
}

void draw() {
  background(0);

  for(int i=0; i<numberLines;i++) {
    drawLine(i);
  }
}

void drawLine(int index) {
  noFill();
  beginShape();
  float segmentXIncrement = width/numberSegments;
  float xoff = 0;

  for(int i=0; i<numberSegments + 3;i++) {
    float x = segmentXIncrement * i;
    float y = map(noise(xoff, yoff), 0, 1, height/2 - 60, height/2 + 60);

    if ((mouseY > height/2 - 50 && mouseY < height/2 + 50)
      && (mouseX > x - segmentXIncrement && mouseX < x + segmentXIncrement)
    ) {
      y = map(noise(xoff, yoff), 0, 1, height/2 - 150, height/2 + 150);
    }

    vertex(x, y);
    xoff += 0.05;
  }
  yoff += 0.1;
  vertex(width + 10, height + 10);
  vertex(-10, height + 10);
  endShape(CLOSE);
}
