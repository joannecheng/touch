class LinesCollection {
  ArrayList<Line> lines = new ArrayList<Line>();

  LinesCollection(int numberLines) {
    for(int i=0; i<numberLines; i++) {
      lines.add(new Line(i));
    }
  }

  void render() {
    for(Line l: lines) {
      strokeWeight(2);
      l.render();
    }
  }

  void updateMousePos(float posX, float posY) {
    fill(255, 0, 0);
    ellipse(posX, posY, 10, 10);

    for(Line l: lines) {
      l.updateMousePos(posX, posY);
    }
  }
}

class Line {
  int numberSegments = 20;
  int lineSpace = 10;
  int index;
  int lineSpacing;

  float mousePosX;
  float mousePosY;
  Note note;

  boolean mouseOverString = false;

  Line(int ind) {
    index = ind;
    lineSpacing = lineSpace*index;
    note = new Note(index*4 + 20);
  }

  void updateMousePos(float x, float y) {
    mousePosX = x;
    mousePosY = y;
  }

  void render() {
    yoff += 0.0001;
    float xoff = 0.0;
    float segmentXIncrement = width/numberSegments;

    pushMatrix();
    translate(0, startingY() - lineSpacing);
    noFill();
    stroke(255);
    beginShape();
    vertex(-10, map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing));

    for (int i=0; i<numberSegments+1;i++) {
      float x = segmentXIncrement * (i+1);
      float y = map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing);

      if (mouseInRange(x, y, segmentXIncrement)) {
        playNote();
        if (pmouseY < mouseY) {
          vertex(x, random(y, y+10));
        }
        else {
          vertex(x, random(y-10, y));
        }
      } else {
        vertex(x, y);
      }

      xoff += 0.01;
    }

    endShape();
    popMatrix();
  }

  void playNote() {
    note.play();
  }

  boolean mouseInRange(float x, float y, float segmentXIncrement) {
    return mouseXInRange(x, segmentXIncrement) && mouseYInRange(y);
  }

  boolean mouseXInRange(float x, float segmentXIncrement) {
    return mousePosX < x+segmentXIncrement/2 && mousePosX > x-segmentXIncrement/2;
  }

  boolean mouseYInRange(float y) {
    return mousePosY < (y + (startingY() - lineSpacing) + 5) && mousePosY > (y + (startingY() - lineSpacing) - 5);
  }

  float startingY() {
    return height * 3 / 4;
  }
}
