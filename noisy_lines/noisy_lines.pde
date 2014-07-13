import SimpleOpenNI.*;
int numberSegments = 30;
int lineSpace = 10;

int numberLines = 30;
ArrayList<Line> lines = new ArrayList<Line>();
float yoff = 0.0;

SimpleOpenNI context;

void setup() {
  size(1280, 500);
  background(0);
  stroke(255, 150);
  strokeWeight(2);
  smooth();

  for(int i=0; i<numberLines; i++) {
    lines.add(new Line(i));
  }
//
//  context = new SimpleOpenNI(this);
//
//  context.setMirror(false);
//  context.enableDepth();
}

void draw() {
  background(0);

  int i = 0;
  for(Line l: lines) {
    pushMatrix();
    translate(0, i*lineSpace);
    l.render();
    popMatrix();
    i++;
  }
}

class Line {
  int numberSegments = 30;
  int lineSpace = 10;
  int index;

  Line(int ind) {
    index = ind;
  }

  void render() {
    float segmentXIncrement = width/numberSegments;
    float xoff = 0.0;
    int lineSpacing = lineSpace*index;

    noFill();
    beginShape();
    vertex(-10, map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing));

    for (int i=0; i<numberSegments;i++) {
      float x = segmentXIncrement * (i+1);
      float y = map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing);
      xoff += 0.01;
      vertex(x, y);
    }
    endShape();
    yoff += 0.0001;
  }
}
